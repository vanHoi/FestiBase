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

/* Correct insert with a tent */
BEGIN TRAN
EXEC sp_add_or_update_podium 1, 0, 1, 3, 'Tent 1', 1200, 600, 100, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
ROLLBACK TRAN

/* Correct insert without a tent */
BEGIN TRAN
EXEC sp_add_or_update_podium 1, 0, 1, 0, 'Tent zonder podium', 1200, 600, 100, 600, 12000, 12, 1000, 450, 450, 'Weinig ruimte', 60
ROLLBACK TRAN

/* Podium too wide for the tent */
BEGIN TRAN
EXEC sp_add_or_update_podium 1, 0, 1, 3, 'Tent 10', 1400, 600, 100, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
ROLLBACK TRAN
BEGIN TRAN
EXEC sp_add_or_update_podium 0, 0, 1, 3, 'Tent 10', 1400, 600, 100, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
ROLLBACK TRAN

/* Podium is too long for the tent */
BEGIN TRAN
EXEC sp_add_or_update_podium 1, 0, 1, 3, 'Tent 10', 1200, 2200, 100, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
ROLLBACK TRAN
BEGIN TRAN
EXEC sp_add_or_update_podium 0, 0, 1, 3, 'Tent 10', 1200, 2200, 100, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
ROLLBACK TRAN

/* Podium floor height is higher then the side height of the tent */
BEGIN TRAN
EXEC sp_add_or_update_podium 1, 0, 1, 3, 'Tent 10', 1200, 600, 550, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
BEGIN TRAN
ROLLBACK TRAN
EXEC sp_add_or_update_podium 0, 0, 1, 3, 'Tent 10', 1200, 600, 550, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
ROLLBACK TRAN

/* Capacity from the podium is too high for the tent */
BEGIN TRAN
EXEC sp_add_or_update_podium 1, 0, 1, 3, 'Tent 10', 1200, 600, 100, 600, 15000, 12, 1000, 450, 450, 'Veel ruimte', 60
ROLLBACK TRAN
BEGIN TRAN
EXEC sp_add_or_update_podium 0, 0, 1, 3, 'Tent 10', 1200, 600, 100, 600, 15000, 12, 1000, 450, 450, 'Veel ruimte', 60
ROLLBACK TRAN

/* Not enough standing room (less then 3 meters) on the podium */
BEGIN TRAN
UPDATE TENT SET ridge_height = 750 WHERE tent_number = 3
EXEC sp_add_or_update_podium 1, 0, 1, 3, 'Tent 10', 1200, 600, 499, 700, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
ROLLBACK TRAN
BEGIN TRAN
UPDATE TENT SET ridge_height = 750 WHERE tent_number = 3
EXEC sp_add_or_update_podium 0, 0, 1, 3, 'Tent 10', 1200, 600, 499, 700, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
ROLLBACK TRAN

/* Podium is too high for the tent */
BEGIN TRAN
EXEC sp_add_or_update_podium 1, 0, 1, 3, 'Tent 10', 1200, 600, 100, 1200, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
ROLLBACK TRAN
BEGIN TRAN
EXEC sp_add_or_update_podium 0, 0, 1, 3, 'Tent 10', 1200, 600, 100, 1200, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
ROLLBACK TRAN

/* Update zonder tentnummer */
BEGIN TRAN
EXEC sp_add_or_update_podium 0, 0, 1, 0, 'Tent 15', 1200, 600, 100, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
ROLLBACK TRAN

/* Correcte update */
BEGIN TRAN
EXEC sp_add_or_update_podium 0, 1, 1, 3, 'Tent 1', 1200, 600, 100, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 60
ROLLBACK TRAN
