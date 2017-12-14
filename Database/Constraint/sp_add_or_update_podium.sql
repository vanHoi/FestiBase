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

			IF (@construction_width > (SELECT width FROM TENT WHERE tent_number = @tent_number))
			BEGIN
				;THROW 50001, 'The width of the podium can''t be greater or equal to the the width of the tent!', 1
			END

			IF (@construction_length > (SELECT length FROM TENT WHERE tent_number = @tent_number))
			BEGIN
				;THROW 50002, 'The length of the podium can''t be greater or equal to the the length of the tent!', 1
			END

			IF (@floor_height > (SELECT side_height FROM TENT WHERE tent_number = @tent_number))
			BEGIN
				;THROW 50003, 'The floor height of the podium can''t be greater then the side height of the tent!', 1
			END

			IF (@capacity > (SELECT capacity FROM TENT WHERE tent_number = @tent_number))
			BEGIN
				;THROW 50004, 'The capacity of the podium can''t be greater than the the capacity of the tent!', 1
			END

			IF ((@floor_height + 300) > (SELECT ridge_height FROM TENT WHERE tent_number = @tent_number))
			BEGIN
				;THROW 50005, 'There is less then three meters standing space available from the podium floor to the highest point in the tent.', 1
			END

			IF (@construction_height >= (SELECT ridge_height FROM TENT WHERE tent_number = @tent_number))
			BEGIN
				;THROW 50006, 'The construction height of the podium can''t be greater or equal to the the ridge height of the tent!', 1
			END

		END

	IF (@insert = 1)
	BEGIN
		IF (@tent_number = 0)
		BEGIN
			SET @tent_number = NULL -- THIS IS NEEDED, BECAUSE THE DATABASE WON'T ACCEPT THE NUMBER 0
		END
		INSERT INTO PODIUM (festival_number, tent_number, name, construction_width, construction_length, floor_height, construction_height, capacity,
		floor_load, free_span_width, free_span_length, free_span_height, environment, time_between_performances)
		 VALUES (@festival_number, @tent_number, @name, @construction_width, @construction_length, @floor_height, @construction_height, @capacity,
		 @floor_load, @free_span_width, @free_span_length, @free_span_height, @environment, @time_between_performances)
	END
	ELSE 
	BEGIN
		IF (@podium_number = 0)
		BEGIN
			;THROW 50000, 'You must supply a podium number with an update statement.', 1
		END
		UPDATE PODIUM SET festival_number = @festival_number, tent_number = @tent_number, name = @name, construction_width = @construction_width,
			construction_length = @construction_length, floor_height = @floor_height, construction_height = @construction_height, capacity = @capacity,
			floor_load = @floor_load, free_span_width = @free_span_width, free_span_length = @free_span_length, free_span_height = @free_span_height,
			environment = @environment, time_between_performances = @time_between_performances WHERE podium_number = @podium_number
	END

  END TRY

	BEGIN CATCH
		;THROW
	END CATCH

END
GO

/* Tests */

-- Add new tent to test with
INSERT INTO TENT (festival_number, name, width, length, side_height, ridge_height, construction_width, construction_length, tent_type, color, floor_type, capacity) VALUES (1, 'Hele Grote Tent', 1300, 2000, 500, 1000, 1500, 3300, 'Grote Tent voor meerdere podiums', 'Blauw-wit', 'Systeemvloer', 12000) 
-- Search for the podium_number
DECLARE @tent_number INT;
SELECT @tent_number = tent_number FROM TENT WHERE festival_number = 1 AND name = 'Hele Grote Tent'
SELECT @tent_number
-- Number 3 in my case, we're going to add the podiums to this tent

/* Correct insert */
EXEC sp_add_or_update_podium 1, 0, 1, 3, 'Tent 1', 1200, 600, 100, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
-- Search for the tent number
DECLARE @tent_number INT;
SELECT @tent_number = MAX(tent_number) FROM TENT
SELECT @tent_number
-- Number  3 in my case, we're going to update this tent

/* Correct insert without a tent */
EXEC sp_add_or_update_podium 1, 0, 1, 0, 'Tent zonder podium', 1200, 600, 100, 600, 12000, 12, 1000, 450, 450, 'Weinig ruimte', 60

/* Podium too wide for the tent */
EXEC sp_add_or_update_podium 1, 0, 1, 3, 'Tent 10', 1400, 600, 100, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
EXEC sp_add_or_update_podium 0, 0, 1, 3, 'Tent 10', 1400, 600, 100, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60

/* Podium is too long for the tent */
EXEC sp_add_or_update_podium 1, 0, 1, 3, 'Tent 10', 1200, 2200, 100, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
EXEC sp_add_or_update_podium 0, 0, 1, 3, 'Tent 10', 1200, 2200, 100, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60

/* Podium floor height is higher then the side height of the tent */
UPDATE TENT SET ridge_height = 10000 WHERE tent_number = 3
EXEC sp_add_or_update_podium 1, 0, 1, 3, 'Tent 10', 1200, 600, 550, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
EXEC sp_add_or_update_podium 0, 0, 1, 3, 'Tent 10', 1200, 600, 550, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60

/* Capacity from the podium is too high for the tent */
EXEC sp_add_or_update_podium 1, 0, 1, 3, 'Tent 10', 1200, 600, 100, 600, 15000, 12, 1000, 450, 450, 'Veel ruimte', 60
EXEC sp_add_or_update_podium 0, 0, 1, 3, 'Tent 10', 1200, 600, 100, 600, 15000, 12, 1000, 450, 450, 'Veel ruimte', 60

/* Not enough standing room (less then 3 meters) on the podium */
UPDATE TENT SET ridge_height = 750 WHERE tent_number = 3
EXEC sp_add_or_update_podium 1, 0, 1, 3, 'Tent 10', 1200, 600, 499, 700, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
EXEC sp_add_or_update_podium 0, 0, 1, 3, 'Tent 10', 1200, 600, 499, 700, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60

/* Podium is too high for the tent */
EXEC sp_add_or_update_podium 1, 0, 1, 3, 'Tent 10', 1200, 600, 100, 1200, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
EXEC sp_add_or_update_podium 0, 0, 1, 3, 'Tent 10', 1200, 600, 100, 1200, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60

/* Update zonder tentnummer */

EXEC sp_add_or_update_podium 0, 0, 1, 0, 'Tent 15', 1200, 600, 100, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60

/* Correcte update */

EXEC sp_add_or_update_podium 0, 3, 1, 3, 'Tent 1', 1200, 600, 100, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
