/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		09-01-2018									*/
/* Edited by:		Mariusz Blautzik							*/
/* Procedure:		Insert + Update GENRE						*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure to add or update a GENRE
*/
DROP PROC IF EXISTS sp_add_or_update_genre
GO
CREATE PROC sp_add_or_update_genre
    @genre_number			INT = NULL,
    @genre					VARCHAR(50),
	@insert					BIT
AS
BEGIN
	BEGIN TRY
		IF (@insert = 1)
			BEGIN
				INSERT INTO GENRE(genre) VALUES
				(@genre
				 )
			END
		ELSE
			BEGIN
				IF (@genre_number IS NULL OR @genre_number = 0)
					BEGIN
						;THROW 50000, '@genre_number cannot be NULL or ZERO if an update is to be commenced', 1
					END
				
				ELSE IF NOT EXISTS (SELECT *
									FROM GENRE
									WHERE genre_number = @genre_number)
					BEGIN
						;THROW 50000, 'This genre does not exist', 1
					END

				UPDATE GENRE SET 
				genre = @genre
				WHERE genre_number = @genre_number
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO


-- INSERT SUCCESSFUL
BEGIN TRAN
EXEC sp_add_or_update_genre NULL, 'Hardcore', 1
ROLLBACK TRAN
GO

-- INSERT SUCCESSFUL
BEGIN TRAN
EXEC sp_add_or_update_genre NULL, 'Trash', 1
ROLLBACK TRAN
GO

-- UPDATE SUCCESSFUL
BEGIN TRAN
EXEC sp_add_or_update_genre 2, 'Hardcore', 0
ROLLBACK TRAN
GO

-- UPDATE FAILED (Genre does not exist)
BEGIN TRAN
EXEC sp_add_or_update_genre 20, 'Nederlandse Classics', 0
ROLLBACK TRAN
GO

-- UPDATE FAILED (Genre cannot be NULL)
BEGIN TRAN
EXEC sp_add_or_update_genre NULL, 'Rock', 0
ROLLBACK TRAN
GO

-- UPDATE FAILED (Genre cannot be ZERO)
BEGIN TRAN
EXEC sp_add_or_update_genre 0, 'Kinderliedtjes', 0
ROLLBACK TRAN
GO