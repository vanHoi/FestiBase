/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		20-12-2017									*/
/* Edited by:		Mariusz Blautzik							*/
/* Procedure:		Insert + Update PODIUM						*/
/*==============================================================*/

DROP PROCEDURE IF EXISTS sp_add_or_update_podium
GO
CREATE PROCEDURE sp_add_or_update_podium
   @insert				 BIT,
   @podium_number		 INT = NULL,
   @festival_number      INT,
   @tent_number			 INT,
   @name				 VARCHAR(50),
   @construction_width	 INT,
   @construction_length	 INT,
   @construction_height	 INT,
   @floor_height		 INT,
   @capacity			 INT,
   @floor_load			 INT,
   @free_span_width		 INT,
   @free_span_length	 INT,
   @free_span_height	 INT,
   @environment			 TEXT

AS
BEGIN
	BEGIN TRY

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
				IF (@podium_number is null)
					BEGIN
						;THROW 50000, '@podium_number cannot be NULL if an UPDATE is to be commenced', 1
					END

					/* UPDATE */
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

-- Test

-- Insert
BEGIN TRAN
EXEC sp_add_or_update_podium 1, NULL, 1, 2, 'TentDestructo', 2000,2000,500, 50, 5000, 50, 1900, 1700, 400, 'Leuke podium voor een leuke festival'    
ROLLBACK TRAN

-- Update
BEGIN TRAN
EXEC sp_add_or_update_podium 0, 2, 1, 2, 'Rock-Podium 2000', 4000,4000,700, 10, 5000, 100, 3500, 3500, 500, 'Rock-Podium 2000 voor Paaspop 2019'    
ROLLBACK TRAN
