/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Delete FESTIVAL_COMPANY_FILE				*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_festival_company_file
GO
CREATE PROCEDURE sp_delete_festival_company_file
	@file_number INT
AS
BEGIN
	BEGIN TRY

		IF NOT EXISTS (SELECT *
					   FROM FESTIVAL_COMPANY_FILE
				       WHERE file_number = @file_number)
			BEGIN
				;THROW 50000, 'This record does not exist', 1
			END

		DELETE FROM FESTIVAL_COMPANY_FILE WHERE file_number = @file_number

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- TEST
BEGIN TRAN
EXEC sp_delete_festival_company_file 1
ROLLBACK TRAN
GO

-- TEST (does not exist)
BEGIN TRAN
EXEC sp_delete_festival_company_file 1000
ROLLBACK TRAN
GO