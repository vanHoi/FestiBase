/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Delete genre	 						*/
/*==============================================================*/
USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_genre
GO
CREATE PROCEDURE sp_delete_genre
	@genre_number INT
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT *
				   FROM GENRE
				   WHERE genre_number = @genre_number)
			BEGIN
				;THROW 50000, 'This genre does not exist', 1
			END

		DELETE FROM GENRE WHERE genre_number = @genre_number
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* tests */
/* delete success */
BEGIN TRAN
insert into genre (genre) VALUES ('r&b')
EXEC sp_delete_genre 5
ROLLBACK TRAN
GO

/* delete genre doesn't exist */
BEGIN TRAN
EXEC sp_delete_genre 55
ROLLBACK TRAN
GO

/* delete forein key */
BEGIN TRAN
EXEC sp_delete_genre 1
ROLLBACK TRAN
GO
