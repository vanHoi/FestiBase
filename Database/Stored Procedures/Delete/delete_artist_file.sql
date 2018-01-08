/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Delete artist_file	 						*/
/*==============================================================*/
USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_artist_file
GO
CREATE PROCEDURE sp_delete_artist_file
	@file_number INT
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT *
				   FROM ARTIST_FILE
				   WHERE file_number = @file_number)
			BEGIN
				;THROW 50000, 'This file does not exist', 1
			END

		DELETE FROM ARTIST_FILE WHERE file_number = @file_number
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* tests */
/* delete success */
BEGIN TRAN
EXEC sp_delete_artist_file 1
ROLLBACK TRAN
GO

/* delete fail */
BEGIN TRAN
EXEC sp_delete_artist_file 55
ROLLBACK TRAN
GO