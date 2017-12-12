DROP PROC IF EXISTS procAddTent;
GO
CREATE PROC procAddTent
	@podium_number INT,
	@width INT,
	@length INT,
	@side_height INT,
	@ridge_height INT,
	@construction_width INT,
	@construction_length INT,
	@tent_type VARCHAR(50),
	@color VARCHAR(50),
	@floor_type VARCHAR(50),
	@capacity INT
AS
BEGIN
	BEGIN TRY
		IF (@podium_number IS NOT NULL)
		BEGIN

			IF (@width < (SELECT podium_width FROM PODIUM WHERE podium_number = @podium_number))
			BEGIN
				;THROW 50000, 'The width of the podium can''t be greater or equal to the the width of the tent!', 1
			END

			IF (@length < (SELECT podium_depth FROM PODIUM WHERE podium_number = @podium_number))
			BEGIN
				;THROW 50001, 'The depth of the podium can''t be greater or equal to the the depth of the tent!', 1
			END

			IF (@side_height <= (SELECT height FROM PODIUM WHERE podium_number = @podium_number))
			BEGIN
				;THROW 50002, 'The height of the podium can''t be greater or equal to the the side height of the tent!', 1
			END

			IF (@capacity < (SELECT capacity FROM PODIUM WHERE podium_number = @podium_number))
			BEGIN
				;THROW 50003, 'The capacity of the podium can''t be greater than the the capacity of the tent!', 1
			END

			IF (@ridge_height < ((SELECT height FROM PODIUM WHERE podium_number = @podium_number) + 300))
			BEGIN
				;THROW 50004, 'There is less then three meters standing space available from the podium floor to the highest point in the tent.', 1
			END

		END

  INSERT INTO TENT VALUES (@podium_number, @length, @width, @side_height, @ridge_height,
                           @construction_width, @construction_length, @tent_type, @color, @floor_type, @capacity)

  END TRY

	BEGIN CATCH
		;THROW
	END CATCH

END
GO

/* Tests */

-- Add new podium to test with
INSERT INTO Podium (festival_number, name, podium_width, podium_depth, height, capacity, floorheight, floor_load, free_span_width, free_span_depth, free_span_height, environment) VALUES (1, 'Test Stage', 1000, 600, 200, 10000, 200, 15, 800, 500, 500, 'Plat vlak land') 
-- Search for the podium_number
DECLARE @podium_number INT;
SELECT @podium_number = podium_number FROM PODIUM WHERE festival_number = 1 AND name = 'Test Stage'

/* Correct */
EXEC procAddTent @podium_number, 1200, 2000, 500, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000

/* Tent not wide enough for the podium */
EXEC procAddTent @podium_number, 800, 2000, 500, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000

/* Tent not deep enough for the podium */
EXEC procAddTent @podium_number, 1200, 500, 500, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000

/* Tent side height are not high enough for the podium */
EXEC procAddTent @podium_number, 3000, 2000, 200, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000

/* Tent to small for the podium */
EXEC procAddTent @podium_number, 3000, 2000, 500, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 8000

/* Not enough standing room (less then 3 meters) on the podium */
EXEC procAddTent @podium_number, 3000, 2000, 400, 400, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000
