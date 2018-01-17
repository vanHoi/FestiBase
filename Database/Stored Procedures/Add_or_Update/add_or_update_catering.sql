/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/	
/* Last edited:		20-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Insert + Update catering					*/
/*==============================================================*/

USE FestiBase
GO

DROP PROC IF EXISTS sp_add_or_update_catering
GO

CREATE PROC sp_add_or_update_catering
	@catering_number			INT = NULL,
	@festival_company_number	INT,
	@electricity				BIT,
	@name						VARCHAR(50),
	@insert						BIT
AS
BEGIN
	BEGIN TRY
		IF (@insert = 1)
		BEGIN
			INSERT INTO CATERING (festival_company_number, name, electricity) VALUES 
			(@festival_company_number, 
			 @name, 
			 @electricity)
		END
		ELSE 
		BEGIN
			IF (@catering_number IS NULL OR @catering_number = 0)
			BEGIN
				;THROW 50000, '@catering_number cannot be NULL if an UPDATE is to be commenced.', 1
			END
			IF NOT EXISTS (SELECT 1 FROM CATERING WHERE catering_number = @catering_number)
			BEGIN
				;THROW 50001, 'This catering does not exist.', 1
			END

			UPDATE CATERING SET 
			festival_company_number = @festival_company_number, 
			name = @name, 
			electricity = @electricity 
			WHERE catering_number = @catering_number
		END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* Tests */

/*insert*/
BEGIN TRAN
EXEC sp_add_or_update_catering 0, 2, 1, 'Bier', 1
ROLLBACK TRAN
GO

/*update*/
BEGIN TRAN
EXEC sp_add_or_update_catering 1, 4, 8, 'bier', 0
ROLLBACK TRAN
GO

/*update fail*/
BEGIN TRAN
EXEC sp_add_or_update_catering 0, 5, 5, 'bier', 0
ROLLBACK TRAN
GO

/*update fail*/
BEGIN TRAN
EXEC sp_add_or_update_catering 0, NULL, 5, 'bier', 0
ROLLBACK TRAN
GO
