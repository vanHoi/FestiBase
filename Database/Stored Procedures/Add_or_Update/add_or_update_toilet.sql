/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/	
/* Last edited:		20-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Insert + Update toilet						*/
/*==============================================================*/
USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_add_or_update_toilet
GO
CREATE PROCEDURE sp_add_or_update_toilet
	@toilet_number				INT = NULL,
	@festival_company_number	INT,
	@name						VARCHAR(50),
	@capacity					INT,
	@insert						BIT
AS
BEGIN
	BEGIN TRY
		IF (@insert = 1)
			BEGIN
				INSERT INTO TOILET (festival_company_number, name, capacity) VALUES 
				(@festival_company_number, 
				 @name, 
				 @capacity)
			END
		ELSE 
			BEGIN
				IF (@toilet_number IS NULL OR @toilet_number = 0)
				BEGIN
					;THROW 50000, '@toilet_number cannot be NULL if an update is to be commerced.', 1
				END
				ELSE IF NOT EXISTS (SELECT * FROM TOILET WHERE toilet_number = @toilet_number)
				BEGIN
					;THROW 50000, 'This toilet does not exist', 1
				END

				UPDATE TOILET SET 
				festival_company_number = @festival_company_number, 
				name = @name, 
				capacity = @capacity 
				WHERE toilet_number = @toilet_number
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* add new toilet */
BEGIN TRAN
EXEC sp_add_or_update_toilet 1, NULL, 1, 'Toilet 3', 500
ROLLBACK TRAN
GO

/* add toilet, wrong company */
BEGIN TRAN
EXEC sp_add_or_update_toilet 1, NULL, 999, 'Toilet 3', 100
ROLLBACK TRAN
GO

/*update toilet*/
BEGIN TRAN
EXEC sp_add_or_update_toilet 0, 2, 7, 'Toilet 3', 250
ROLLBACK TRAN
GO

/*update toilet NULL*/
BEGIN TRAN
EXEC sp_add_or_update_toilet 0, NULL, 7, 'Toilet 3', 205
ROLLBACK TRAN
GO

/* update toilet toilet does not exists */
BEGIN TRAN
EXEC sp_add_or_update_toilet 0, 9999, 8, 'Toilet 3', 205
ROLLBACK TRAN
GO