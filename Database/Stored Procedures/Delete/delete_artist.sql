/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Delete artist	 						*/
/*==============================================================*/
USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_artist
GO
CREATE PROCEDURE sp_delete_artist
	@artist_number INT
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT *
				   FROM ARTIST
				   WHERE artist_number = @artist_number)
			BEGIN
				;THROW 50000, 'This artist does not exist', 1
			END

		DELETE FROM ARTIST WHERE artist_number = @artist_number
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* tests */
/* delete success */
BEGIN TRAN
EXEC sp_delete_artist 1
ROLLBACK TRAN
GO

/* delete fail */
BEGIN TRAN
EXEC sp_delete_artist 55
ROLLBACK TRAN
GO