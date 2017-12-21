/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		20-12-2017									*/
/* Edited by:		Mariusz Blautzik							*/
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
			IF NOT EXISTS (SELECT 1 FROM PODIUM WHERE podium_number = @podium_number)
			BEGIN
				;THROW 50001, 'This unit does not exist.', 1
			END
			ELSE IF NOT EXISTS (SELECT *
								FROM PODIUM
								WHERE podium_number = @podium_number)
			BEGIN
				;THROW 50000, 'This attribute does not exist', 1
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
Select * from PODIUM
-- Successful Insert
BEGIN TRAN
EXEC sp_add_or_update_podium NULL, 1, 2, 'TentDestructo', 2000,2000,500, 50, 5000, 50, 1900, 1700, 400, 'Leuke podium voor een leuke festival', 1    
ROLLBACK TRAN

-- Successful Insert 2
BEGIN TRAN
EXEC sp_add_or_update_podium NULL, 1, NULL, 'TerroDrang', 4500, 4500, NULL, NULL, 3500, 100, 4000, 4000, NULL, 'Open Stage Defqon 1', 1
ROLLBACK TRAN

-- Successful Update
BEGIN TRAN
EXEC sp_add_or_update_podium 2, 1, 2, 'Rock-Podium vol2', 4000,4000,700, 10, 5000, 100, 3500, 3500, 500, 'Rock-Podium 2000 voor Paaspop 2019', 0    
ROLLBACK TRAN

-- Successful Update 2
BEGIN TRAN
EXEC sp_add_or_update_podium 2, 1, 3, 'TerroDrangDangDang', 5000, 5000, 300, 10,1590, 50,4700, 4700,270, 'Leuke Bomen en Lichten', 0   
ROLLBACK TRAN

-- Failed Insert
BEGIN TRAN
EXEC sp_add_or_update_podium NULL, 1, 0, 'TentDestructo', 2000,2000,500, 50, 5000, 50, 1900, 1700, 400, 'Leuke podium voor een leuke festival', 1    
ROLLBACK TRAN

-- Failed Update
BEGIN TRAN
EXEC sp_add_or_update_podium 0, 1, 2, 'House Stage', 4000,4000,700, 10, 5000, 100, 3500, 3500, 500, 'House Music Elektro City', 0    
ROLLBACK TRAN

-- Failed Update 2
BEGIN TRAN
EXEC sp_add_or_update_podium 99999, 1, 2, 'Dragon Ball Super Stage', 4000,4000,700, 10, 5000, 100, 3500, 3500, 500, 'KA-ME-HA-ME-HAAAAAAAAAAAAAAAAAAAAAAA', 0    
ROLLBACK TRAN