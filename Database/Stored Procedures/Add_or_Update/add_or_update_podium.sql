/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		20-12-2017									*/
/* Created by:		Mariusz Blautzik							*/
/* Edited by:		Ivo Reumkens								*/
/* Procedure:		Insert + Update PODIUM						*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_add_or_update_podium
GO
CREATE PROCEDURE sp_add_or_update_podium
   @podium_number		 INT = NULL,
   @festival_number      INT,
   @tent_number			 INT = NULL,
   @name				 VARCHAR(50),
   @construction_width	 INT,
   @construction_length	 INT,
   @construction_height	 INT = NULL,
   @floor_height		 INT = NULL,
   @capacity			 INT,
   @floor_load			 INT,
   @free_span_width		 INT,
   @free_span_length	 INT,
   @free_span_height	 INT = NULL,
   @environment			 TEXT,
   @insert				 BIT
AS
BEGIN
	BEGIN TRY

		/* Checking the constraints on performance */
		EXEC sp_check_podium @tent_number, @construction_width, @construction_length, @construction_height, @floor_height, @capacity, @free_span_width, @free_span_length, @free_span_height

		IF (@tent_number = 0)
		BEGIN
			SET @tent_number = NULL -- THIS IS NEEDED, BECAUSE THE DATABASE WON'T ACCEPT THE NUMBER 0
		END

		IF (@insert = 1)
		BEGIN
			INSERT INTO PODIUM(festival_number, tent_number, "name", construction_width, construction_length, construction_height, 
			                   floor_height, capacity, floor_load, free_span_width, free_span_length, free_span_height, environment)
			VALUES( @festival_number,
					@tent_number,
					@name,
					@construction_width,
					@construction_length,
					@construction_height,
					@floor_height,
					@capacity,
					@floor_load,
					@free_span_width,
					@free_span_length,
					@free_span_height,
					@environment)

		END
	ELSE 
		BEGIN
			IF (@podium_number IS NULL OR @podium_number = 0)
			BEGIN
				;THROW 50000, '@podium_number cannot be NULL or ZERO if an UPDATE is to be commenced.', 1
			END
			ELSE IF NOT EXISTS (SELECT * FROM PODIUM WHERE podium_number = @podium_number)
			BEGIN
				;THROW 50001, 'This podium does not exist.', 1
			END

					UPDATE PODIUM SET 
					festival_number = @festival_number,
					tent_number = @tent_number,
					"name" = @name,
					construction_width = @construction_width,
					construction_length = @construction_length,
					construction_height = @construction_height,
					floor_height = @floor_height,
					capacity = @capacity,
					floor_load = @floor_load,
				    free_span_width = @free_span_width,
					free_span_length = @free_span_length,
					free_span_height = @free_span_height,
					environment = @environment		
					WHERE podium_number = @podium_number
			END

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- Procedure and Constraint tests

/* Correct insert with a tent */
BEGIN TRAN
EXEC sp_add_or_update_podium 0, 1, 3, 'Tent 1', 1200, 600, 600, 100, 12000, 12, 1000, 450, 450, 'Veel ruimte', 1
ROLLBACK TRAN
GO

/* Correct insert without a tent */
BEGIN TRAN
EXEC sp_add_or_update_podium 0, 1, 0, 'Tent zonder podium', 1200, 600, 600, 100, 12000, 12, 1000, 450, 450, 'Weinig ruimte', 1
ROLLBACK TRAN
GO

/* Podium too wide for the tent */
BEGIN TRAN
EXEC sp_add_or_update_podium 0, 1, 3, 'Tent 10', 1400, 600, 600, 100, 12000, 12, 1000, 450, 450, 'Veel ruimte', 1
ROLLBACK TRAN
GO

BEGIN TRAN
EXEC sp_add_or_update_podium 0, 1, 3, 'Tent 10', 1400, 600, 600, 100, 12000, 12, 1000, 450, 450, 'Veel ruimte', 0
ROLLBACK TRAN
GO

/* Podium is too long for the tent */
BEGIN TRAN
EXEC sp_add_or_update_podium 0, 1, 3, 'Tent 10', 1200, 2200, 600, 100, 12000, 12, 1000, 450, 450, 'Veel ruimte', 1
ROLLBACK TRAN
GO

BEGIN TRAN
EXEC sp_add_or_update_podium 0, 1, 3, 'Tent 10', 1200, 2200, 600, 100, 12000, 12, 1000, 450, 450, 'Veel ruimte', 0
ROLLBACK TRAN
GO

/* Podium floor height is higher then the side height of the tent */
BEGIN TRAN
EXEC sp_add_or_update_podium 0, 1, 3, 'Tent 10', 1200, 600, 550, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 1
ROLLBACK TRAN
GO

BEGIN TRAN
EXEC sp_add_or_update_podium 0, 1, 3, 'Tent 10', 1200, 600, 550, 600, 12000, 12, 1000, 450, 450, 'Veel ruimte', 0
ROLLBACK TRAN
GO

/* Capacity from the podium is too high for the tent */
BEGIN TRAN
EXEC sp_add_or_update_podium 0, 1, 3, 'Tent 10', 1200, 600, 600, 100, 15000, 12, 1000, 450, 450, 'Veel ruimte', 1
ROLLBACK TRAN
GO

BEGIN TRAN
EXEC sp_add_or_update_podium 0, 1, 3, 'Tent 10', 1200, 600, 600, 100, 15000, 12, 1000, 450, 450, 'Veel ruimte', 0
ROLLBACK TRAN
GO

/* Not enough standing room (less then 3 meters) on the podium */
BEGIN TRAN
UPDATE TENT SET ridge_height = 750 WHERE tent_number = 3
EXEC sp_add_or_update_podium 0, 1, 3, 'Tent 10', 1200, 600, 499, 700, 12000, 12, 1000, 450, 450, 'Veel ruimte', 1
ROLLBACK TRAN
GO

BEGIN TRAN
UPDATE TENT SET ridge_height = 750 WHERE tent_number = 3
EXEC sp_add_or_update_podium 0, 1, 3, 'Tent 10', 1200, 600, 499, 700, 12000, 12, 1000, 450, 450, 'Veel ruimte', 0
ROLLBACK TRAN
GO

/* Podium is too high for the tent */
BEGIN TRAN
EXEC sp_add_or_update_podium 0, 1, 3, 'Tent 10', 1200, 600, 100, 1200, 12000, 12, 1000, 450, 450, 'Veel ruimte', 1
ROLLBACK TRAN
GO

BEGIN TRAN
EXEC sp_add_or_update_podium 0, 1, 3, 'Tent 10', 1200, 600, 100, 1200, 12000, 12, 1000, 450, 450, 'Veel ruimte', 0
ROLLBACK TRAN
GO

/* Update zonder tentnummer */
BEGIN TRAN
EXEC sp_add_or_update_podium 0, 1, 0, 'Tent 15', 1200, 600, 600, 100, 12000, 12, 1000, 450, 450, 'Veel ruimte', 0
ROLLBACK TRAN
GO

/* Correcte update */
BEGIN TRAN
EXEC sp_add_or_update_podium 1, 1, 3, 'Tent 1', 1200, 600, 600, 100, 12000, 12, 1000, 450, 450, 'Veel ruimte', 0
ROLLBACK TRAN
GO

/* update, wrong podium */
BEGIN TRAN
EXEC sp_add_or_update_podium 666, 1, 3, 'Tent 1', 1200, 600, 600, 100, 12000, 12, 1000, 450, 450, 'Veel ruimte', 0
ROLLBACK TRAN
GO