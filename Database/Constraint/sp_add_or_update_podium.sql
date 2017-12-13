DROP PROC IF EXISTS sp_add_or_update_podium;
GO
CREATE PROC sp_add_or_update_podium
	@insert BIT,
	@podium_number INT = NULL,
	@festival_number INT,
	@tent_number INT = NULL,
	@name VARCHAR(50),
	@construction_width INT,
	@construction_length INT,
	@floor_height INT = NULL,
	@construction_height INT = NULL,
	@capacity INT,
	@floor_load INT,
	@free_span_width INT,
	@free_span_length INT,
	@free_span_height INT = NULL,
	@environment TEXT,
	@time_between_performances INT
AS
BEGIN
	BEGIN TRY
		IF (@tent_number IS NOT NULL)
		BEGIN

			IF (@construction_width < (SELECT construction_width FROM TENT WHERE tent_number = @tent_number))
			BEGIN
				;THROW 50001, 'The width of the podium can''t be greater or equal to the the width of the tent!', 1
			END

			IF (@construction_length < (SELECT construction_length FROM TENT WHERE tent_number = @tent_number))
			BEGIN
				;THROW 50002, 'The length of the podium can''t be greater or equal to the the length of the tent!', 1
			END

			IF (@floor_height <= (SELECT side_height FROM TENT WHERE tent_number = @tent_number))
			BEGIN
				;THROW 50003, 'The floor height of the podium can''t be greater or equal to the the side height of the tent!', 1
			END

			IF (@capacity > (SELECT capacity FROM TENT WHERE tent_number = @tent_number))
			BEGIN
				;THROW 50004, 'The capacity of the podium can''t be greater than the the capacity of the tent!', 1
			END

			IF ((@floor_height + 300) < (SELECT ridge_height FROM TENT WHERE tent_number = @tent_number))
			BEGIN
				;THROW 50005, 'There is less then three meters standing space available from the podium floor to the highest point in the tent.', 1
			END

			IF (@construction_height <= (SELECT ridge_height FROM TENT WHERE tent_number = @tent_number))
			BEGIN
				;THROW 50006, 'The construction height of the podium can''t be greater or equal to the the ridge height of the tent!', 1
			END

		END

	IF (@insert = 1)
	BEGIN
		INSERT INTO PODIUM (festival_number, tent_number, name, construction_width, construction_length, floor_height, construction_height, capacity,
		floor_load, free_span_width, free_span_length, free_span_height, environment, time_between_performances)
		 VALUES (@festival_number, @tent_number, @name, @construction_width, @construction_length, @floor_height, @construction_height, @capacity,
		 @floor_load, @free_span_width, @free_span_length, @free_span_height, @environment, @time_between_performances)
	END
	ELSE 
	BEGIN
		IF (@tent_number = null)
		BEGIN
			;THROW 50000, 'You must supply a podium number with an update statement.', 1
		END
		UPDATE PODIUM SET festival_number = @festival_number, tent_number = @tent_number, name = @name, construction_width = @construction_width,
			construction_length = @construction_length, floor_height = @floor_height, construction_height = @construction_height, capacity = @capacity,
			floor_load = @floor_load, free_span_width = @free_span_width, free_span_length = @free_span_length, free_span_height = @free_span_height,
			environment = @environment, time_between_performances = @time_between_performances
	END

  END TRY

	BEGIN CATCH
		;THROW
	END CATCH

END
GO

/* Tests */

-- Add new podium to test with
INSERT INTO Podium (festival_number, name, construction_width, construction_length, floor_height, construction_height, capacity, floorheight, floor_load, free_span_width, free_span_depth, free_span_height, environment) VALUES (1, 'Test Stage', 1000, 600, 200, 600, 10000, 200, 15, 800, 500, 500, 'Plat vlak land') 
-- Search for the podium_number
DECLARE @podium_number INT;
SELECT @podium_number = podium_number FROM PODIUM WHERE festival_number = 1 AND name = 'Test Stage'

/* Correcte insert */
EXEC procAddOrUpdateTent 1, null, @podium_number, 1200, 2000, 500, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000
-- Search for the tent number
DECLARE @tent_number INT;
SELECT @tent_number = MAX(tent_number) FROM TENT

/* Tent not wide enough for the podium */
EXEC procAddOrUpdateTent 1, null, @podium_number, 800, 2000, 500, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000
EXEC procAddOrUpdateTent 0, @tent_number, @podium_number, 800, 2000, 500, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000

/* Tent not deep enough for the podium */
EXEC procAddOrUpdateTent 1, null, @podium_number, 1200, 500, 500, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000
EXEC procAddOrUpdateTent 0, @tent_number, @podium_number, 1200, 500, 500, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000

/* Tent side height are not high enough for the podium */
EXEC procAddOrUpdateTent 1, null, @podium_number, 1200, 2000, 200, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000
EXEC procAddOrUpdateTent 0, @tent_number, @podium_number, 1200, 2000, 200, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000

/* Tent to small for the podium */
EXEC procAddOrUpdateTent 1, null, @podium_number, 1200, 2000, 500, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 8000
EXEC procAddOrUpdateTent 0, @tent_number, @podium_number, 1200, 2000, 500, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 8000

/* Not enough standing room (less then 3 meters) on the podium */
EXEC procAddOrUpdateTent 1, null, @podium_number, 1200, 2000, 400, 400, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000
EXEC procAddOrUpdateTent 0, @tent_number, @podium_number, 1200, 2000, 400, 400, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000

/* Podium is to high for the tent */
EXEC procAddOrUpdateTent 1, null, @podium_number, 1200, 2000, 400, 500, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000
EXEC procAddOrUpdateTent 0, @tent_number, @podium_number, 1200, 2000, 400, 500, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000

/* Correcte update */
EXEC procAddOrUpdateTent 1, @tent_number, @podium_number, 3000, 2000, 500, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000
