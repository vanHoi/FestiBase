/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Delete genre	 						*/
/*==============================================================*/
USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_genre_preference_visitor
GO
CREATE PROCEDURE sp_delete_genre_preference_visitor
	@visitor_number INT,
	@genre_number INT
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT *
				   FROM GENRE_preference_VISITOR
				   WHERE genre_number = @genre_number
				   AND visitor_number = @visitor_number)
			BEGIN
				;THROW 50000, 'This genre preference does not exist', 1
			END

		DELETE FROM GENRE_preference_VISITOR WHERE genre_number = @genre_number AND visitor_number = @visitor_number
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* tests */
/* delete success */
BEGIN TRAN
EXEC sp_delete_genre_preference_visitor 1, 1
ROLLBACK TRAN
GO

/* delete */
BEGIN TRAN
EXEC sp_delete_genre_preference_visitor 55, 1
ROLLBACK TRAN
GO
