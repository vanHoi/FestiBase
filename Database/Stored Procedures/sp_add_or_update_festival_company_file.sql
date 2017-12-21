/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		21-12-2017									*/
/* Edited by:		Mariusz Blautzik							*/
/* Procedure:		Insert + Update Festival Company File		*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_add_or_update_festival_company_file
GO
CREATE PROCEDURE sp_add_or_update_festival_company_file
 @file_number				INT = NULL,
 @festival_company_number	INT,
 @file						VARCHAR(50),
 @description				TEXT,
 @insert					BIT

AS
BEGIN
	BEGIN TRY

		IF (@insert = 1)
		BEGIN
			INSERT INTO FESTIVAL_COMPANY_FILE(festival_company_number,"file","description")
			VALUES (@festival_company_number,
					@file,
					@description)

		END
	ELSE 
			BEGIN
					IF (@file_number = NULL OR @file_number = 0)
			BEGIN
				;THROW 50000, '@file_number cannot be NULL or ZERO if an UPDATE is to be commenced.', 1
			END
			IF NOT EXISTS (SELECT 1 FROM FESTIVAL_COMPANY_FILE WHERE file_number = @file_number)
			BEGIN
				;THROW 50001, 'This unit does not exist.', 1
			END
			ELSE IF NOT EXISTS (SELECT *
								FROM FESTIVAL_COMPANY_FILE
								WHERE file_number = @file_number)
			BEGIN
				;THROW 50000, 'This attribute does not exist', 1
			END

					/* UPDATE */
					UPDATE FESTIVAL_COMPANY_FILE SET 
					festival_company_number = @festival_company_number,
					"file" = @file,					
					"description" = @description
					WHERE file_number = @file_number
			END

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO



Select * from FESTIVAL_COMPANY_FILE

-- Test

-- Successful Insert
BEGIN TRAN
EXEC sp_add_or_update_festival_company_file NULL, 1, 'File/drive.com/firebook', 'Brandveiligheidsboek', 1
ROLLBACK TRAN

-- Successful Update
BEGIN TRAN
EXEC sp_add_or_update_festival_company_file 2,5, 'file/path/newjpgtent.jpg', 'Nieuwe afbeelding van de Draaimolen', 0 
ROLLBACK TRAN

-- Failed Insert 
BEGIN TRAN
EXEC sp_add_or_update_festival_company_file NULL, NULL, 'File/http.fire.com/firebook', 'Brandveiligheidsboek voor Defqon1', 1
ROLLBACK TRAN

-- Failed Update 
BEGIN TRAN
EXEC sp_add_or_update_festival_company_file 0, 1, 'File//fireworks', 'Fireworks for Mysteryland', 0
ROLLBACK TRAN

-- Failed Update 
BEGIN TRAN
EXEC sp_add_or_update_festival_company_file NULL, 5, 'File//Tent//HowItWorks', 'Tent Plattegrond for Mysteryland', 0
ROLLBACK TRAN

