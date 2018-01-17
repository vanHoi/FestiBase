/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		21-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Insert + Update tent_file					*/
/*==============================================================*/
USE FestiBase
GO


DROP PROCEDURE IF EXISTS sp_add_or_update_tent_file
GO
CREATE PROCEDURE sp_add_or_update_tent_file
	@file_number INT = NULL,
	@tent_number INT,
	@festival_company_number INT,
	@file VARCHAR(50),
	@description TEXT,
	@insert BIT
AS
BEGIN
	BEGIN TRY
		IF (@insert = 1)
		BEGIN
			INSERT INTO TENT_FILE (tent_number, festival_company_number, "file", description) VALUES (@tent_number, @festival_company_number, @file, @description)
		END
		ELSE 
		BEGIN
			IF (@file_number IS NULL OR @file_number = 0)
			BEGIN
				;THROW 50000, '@file_number cannot be NULL if an UPDATE is to be commenced.', 1
			END
			IF NOT EXISTS (SELECT 1 FROM TENT_FILE WHERE file_number = @file_number)
			BEGIN
				;THROW 50001, 'This file does not exist.', 1
			END
			UPDATE TENT_FILE SET tent_number = @tent_number, festival_company_number = @festival_company_number, "file" = @file, "description" = @description WHERE file_number = @file_number
		END

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/*insert*/
BEGIN TRAN
EXEC sp_add_or_update_tent_file NULL, 1, 1, 'path', 'beschrijving', 1
ROLLBACK TRAN
GO

/*update*/
BEGIN TRAN
EXEC sp_add_or_update_tent_file 1, 1, 1, 'path', 'beschrijving', 0
ROLLBACK TRAN
GO

/* update, tent doesn't exist */
BEGIN TRAN
EXEC sp_add_or_update_tent_file 66, 1, 1, 'path', 'beschrijving', 0
ROLLBACK TRAN
GO

/*update, tent is null*/
BEGIN TRAN
EXEC sp_add_or_update_tent_file NULL, 1, 1, 'path', 'beschrijving', 0
ROLLBACK TRAN
GO