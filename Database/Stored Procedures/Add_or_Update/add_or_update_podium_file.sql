/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		21-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Insert + Update PODIUM_FILE					*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_add_or_podium_file
GO
CREATE PROCEDURE sp_add_or_podium_file
	@file_number INT = NULL,
	@podium_number INT,
	@festival_company_number INT,
	@file VARCHAR(50),
	@description TEXT,
	@insert BIT
AS
BEGIN
	BEGIN TRY
		IF (@insert = 1)
		BEGIN
			INSERT INTO PODIUM_FILE (podium_number, festival_company_number, "file", "description") VALUES (@podium_number, @festival_company_number, @file, @description)
		END
		ELSE 
		BEGIN
			IF (@file_number IS NULL OR @file_number = 0)
			BEGIN
				;THROW 50000, '@file_number cannot be NULL if an UPDATE is to be commenced.', 1
			END
			IF NOT EXISTS (SELECT 1 FROM PODIUM_FILE WHERE file_number = @file_number)
			BEGIN
				;THROW 50001, 'This file does not exist.', 1
			END
			UPDATE PODIUM_FILE SET podium_number = @podium_number, festival_company_number = @festival_company_number, "file" = @file, "description" = @description WHERE file_number = @file_number
		END

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/*insert*/
BEGIN TRAN
EXEC sp_add_or_podium_file NULL, 1, 1, 'path', 'beschrijving', 1
ROLLBACK TRAN
GO

/*update*/
BEGIN TRAN
EXEC sp_add_or_podium_file 1, 1, 1, 'path', 'beschrijving', 0
ROLLBACK TRAN
GO

/* update, podium doesn't exist */
BEGIN TRAN
EXEC sp_add_or_podium_file 66, 1, 1, 'path', 'beschrijving', 0
ROLLBACK TRAN
GO

/*update, podium is null*/
BEGIN TRAN
EXEC sp_add_or_podium_file NULL, 1, 1, 'path', 'beschrijving', 0
ROLLBACK TRAN
GO