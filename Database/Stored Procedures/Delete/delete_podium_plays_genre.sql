/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		20-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Delete PODIUM_plays_GENRE						*/
/*==============================================================*/
USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_podium_plays_genre
GO
CREATE PROCEDURE sp_delete_podium_plays_genre
	@genre_number INT,
	@podium_number INT
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT *
				   FROM PODIUM_plays_GENRE
				   WHERE genre_number = @genre_number
				   AND podium_number = @podium_number)
			BEGIN
				;THROW 50000, 'This record does not exist', 1
			END

		DELETE FROM PODIUM_plays_GENRE WHERE genre_number = @genre_number AND podium_number = @podium_number
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

select * from podium_plays_genre

/* tests */
/* delete success */
BEGIN TRAN
EXEC sp_delete_podium_plays_genre 1, 1
ROLLBACK TRAN
GO

/* delete fail */
BEGIN TRAN
EXEC sp_delete_podium_plays_genre 1, 2
ROLLBACK TRAN
GO