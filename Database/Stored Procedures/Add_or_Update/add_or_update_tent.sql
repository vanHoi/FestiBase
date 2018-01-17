/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		7											*/
/* Last edited:		21-12-2017									*/
/* Created by:		Ivo Reumkens								*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Insert + Update TENT						*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure to add or update a TENT
*/
DROP PROC IF EXISTS sp_add_or_update_tent;
GO
CREATE PROC sp_add_or_update_tent
	@tent_number INT = NULL,
	@festival_number INT,
	@name VARCHAR(50),
	@width INT,
	@length INT,
	@side_height INT,
	@ridge_height INT,
	@construction_width INT,
	@construction_length INT,
	@tent_type VARCHAR(50),
	@color VARCHAR(50),
	@floor_type VARCHAR(50),
	@capacity INT,
	@insert BIT
AS
BEGIN
	BEGIN TRY

		IF (@insert = 1)
			BEGIN
				INSERT INTO TENT (festival_number, name, width, length, side_height, ridge_height, construction_width, 
								  construction_length, tent_type, color, floor_type, capacity) VALUES
				(@festival_number, 
				 @name, 
				 @width, 
				 @length, 
				 @side_height, 
				 @ridge_height,
                 @construction_width, 
				 @construction_length, 
				 @tent_type, 
				 @color, 
				 @floor_type, 
				 @capacity)
			END
		ELSE 
			BEGIN
				IF (@tent_number IS NULL OR @tent_number = 0)
					BEGIN
						;THROW 50000, '@tent_number cannot be NULL if an UPDATE is to be commenced', 1
					END

				ELSE IF NOT EXISTS (SELECT *
									FROM tent
									WHERE tent_number = @tent_number)
					BEGIN
						;THROW 50000, 'This tent does not exist', 1
					END

					UPDATE TENT SET 
					festival_number = @festival_number, 
					name = @name, width = @width, 
					length =  @length, 
					side_height = @side_height, 
					ridge_height = @ridge_height,
                    construction_width = @construction_width, 
					construction_length = @construction_length, 
					tent_type = @tent_type, 
					color = @color, 
				    floor_type = @floor_type, 
					capacity = @capacity 
					WHERE tent_number = @tent_number
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- Test INSERT
BEGIN TRAN
EXEC sp_add_or_update_tent NULL, 1, 'Test Tent', 1200, 2000, 500, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000, 1
ROLLBACK TRAN
GO

-- Test UPDATE
BEGIN TRAN
EXEC sp_add_or_update_tent 1, 2, 'Test Tent', 1300, 2000, 500, 1000, 1500, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000, 0
ROLLBACK TRAN
GO

-- Width too wide
BEGIN TRAN
INSERT INTO TENT (festival_number, name, width, length, side_height, ridge_height, construction_width, construction_length, tent_type, color, floor_type, capacity) 
VALUES (1, 'Test Tent', 1200, 2000, 500, 1000, 1000, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000)
ROLLBACK TRAN

-- Length too long
BEGIN TRAN
INSERT INTO TENT (festival_number, name, width, length, side_height, ridge_height, construction_width, construction_length, tent_type, color, floor_type, capacity) 
VALUES (1, 'Test Tent', 1200, 2000, 500, 1000, 1400, 1800, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000)
ROLLBACK TRAN

-- Side height too high
BEGIN TRAN
INSERT INTO TENT (festival_number, name, width, length, side_height, ridge_height, construction_width, construction_length, tent_type, color, floor_type, capacity) 
VALUES (1, 'Test Tent', 1200, 2000, 1200, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000)
ROLLBACK TRAN

-- Test UPDATE (SK does not exist)
BEGIN TRAN
EXEC sp_add_or_update_tent 200, 2, 'Test Tent', 1300, 2000, 500, 1000, 1500, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000, 0
ROLLBACK TRAN
GO

-- Test UPDATE (SK NULL)
BEGIN TRAN
EXEC sp_add_or_update_tent NULL, 2, 'Test Tent', 1300, 2000, 500, 1000, 1500, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000, 0
ROLLBACK TRAN
GO