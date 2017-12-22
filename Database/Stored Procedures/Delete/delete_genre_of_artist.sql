/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Delete genre_of_artist 						*/
/*==============================================================*/
USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_genre_of_artist
GO
CREATE PROCEDURE sp_delete_genre_of_artist
	@genre_number INT,
	@artist_number INT
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT *
				   FROM GENRE_OF_ARTIST
				   WHERE genre_number = @genre_number 
				   AND artist_number = @artist_number)
			BEGIN
				;THROW 50000, 'This genre with artist does not exist', 1
			END

		DELETE FROM GENRE_OF_ARTIST WHERE genre_number = @genre_number AND artist_number = @artist_number
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* tests */
/* delete success */
BEGIN TRAN
EXEC sp_delete_genre_of_artist 1, 1
ROLLBACK TRAN
GO

/* delete fail */
BEGIN TRAN
EXEC sp_delete_genre_of_artist 55, 1
ROLLBACK TRAN
GO