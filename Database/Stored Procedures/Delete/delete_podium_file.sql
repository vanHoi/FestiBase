/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Delete podium_file 						*/
/*==============================================================*/
USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_podium_file
GO
CREATE PROCEDURE sp_delete_podium_file
	@file_number INT
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT *
				   FROM PODIUM_FILE
				   WHERE file_number = @file_number)
			BEGIN
				;THROW 50000, 'This podium file does not exist', 1
			END

		DELETE FROM PODIUM_FILE WHERE file_number = @file_number
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* tests */
/* delete FK constraint*/
BEGIN TRAN
EXEC sp_delete_podium_file 2
ROLLBACK TRAN
GO

/* delete genre doesn't exist */
BEGIN TRAN
EXEC sp_delete_podium_file 55
ROLLBACK TRAN
GO