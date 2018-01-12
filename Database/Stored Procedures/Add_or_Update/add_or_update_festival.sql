/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		20-12-2017									*/
/* Edited by:		Mariusz Blautzik							*/
/* Procedure:		Insert + Update FESTIVAL					*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_add_or_update_festival
GO
CREATE PROCEDURE sp_add_or_update_festival
   @festival_number      INT = NULL,
   @organisation_number  INT,
   @name                 VARCHAR(50),
   @start_date           DATETIME,
   @end_date             DATETIME,
   @location             VARCHAR(50),
   @token_price          MONEY,
   @insert				 BIT
AS
BEGIN
	BEGIN TRY

		IF (@insert = 1)
		BEGIN
			INSERT INTO FESTIVAL (organisation_number, "name", "start_date", end_date, "location", token_price)
			VALUES (@organisation_number, 
					@name, 
					@start_date, 
					@end_date, 
					@location, 
					@token_price)

		END
	ELSE 
			BEGIN
				IF (@festival_number IS NULL OR @festival_number = 0)
					BEGIN
						;THROW 50000, '@festival_number cannot be NULL if an UPDATE is to be commenced', 1
					END

				IF NOT EXISTS (SELECT *
							   FROM festival
							   WHERE festival_number = @festival_number)
					BEGIN
						;THROW 50000, 'This festival does not exist', 1
					END

					UPDATE FESTIVAL SET 
					organisation_number = @organisation_number,
					"name" = @name,
					"start_date" = @start_date,
					end_date = @end_date,
					"location" = @location,
					token_price = @token_price
					WHERE festival_number = @festival_number
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
EXEC sp_add_or_update_festival null, 2, 'Defqon #1', '2018-06-24 19:00:00', '2018-06-27 23:59:00', 'Biddingshuizen', '2.75', 1
ROLLBACK TRAN

-- Update
BEGIN TRAN
EXEC sp_add_or_update_festival 3, 4, 'Mysteryland', '2018-07-05 11:30:00', '2018-07-07 22:00:00', 'Amsterdam', '3.50', 0
ROLLBACK TRAN

-- Update (SK does not exist)
BEGIN TRAN
EXEC sp_add_or_update_festival 300, 4, 'Mysteryland', '2018-07-05 11:30:00', '2018-07-07 22:00:00', 'Amsterdam', '3.50', 0
ROLLBACK TRAN

-- Update (SK cannot be NULL)
BEGIN TRAN
EXEC sp_add_or_update_festival NULL, 4, 'Mysteryland', '2018-07-05 11:30:00', '2018-07-07 22:00:00', 'Amsterdam', '3.50', 0
ROLLBACK TRAN

-- Insert (start date not before end date)
BEGIN TRAN
EXEC sp_add_or_update_festival null, 2, 'Defqon #1', '2018-06-27 19:00:00', '2018-06-24 23:59:00', 'Biddingshuizen', '2.75', 1
ROLLBACK TRAN

-- Insert (start date can't be the same as end date)
BEGIN TRAN
EXEC sp_add_or_update_festival null, 2, 'Defqon #1', '2018-06-24 23:59:00', '2018-06-24 23:59:00', 'Biddingshuizen', '2.75', 1
ROLLBACK TRAN