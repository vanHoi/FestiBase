/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		09-01-2018									*/
/* Edited by:		Mariusz Blautzik							*/
/* Procedure:		Insert GENRE OF ARTIST						*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure to add a GENRE OF ARTIST
*/
DROP PROC IF EXISTS sp_add_genre_of_artist
GO
CREATE PROC sp_add_genre_of_artist
	@genre_number 			INT,
    @artist_number			INT
AS
BEGIN
	BEGIN TRY
			BEGIN
				INSERT INTO GENRE_of_ARTIST(genre_number, artist_number) VALUES
				(@genre_number,
				 @artist_number
				 )
			END
	END TRY
	BEGIN CATCH
		;THROW 
	END CATCH
END
GO

-- INSERT SUCCESSFUL
BEGIN TRAN
EXEC sp_add_genre_of_artist 1, 3
ROLLBACK TRAN
GO

-- INSERT SUCCESSFUL
BEGIN TRAN
EXEC sp_add_genre_of_artist 3, 7   
ROLLBACK TRAN
GO

-- INSERT FAILED
BEGIN TRAN
EXEC sp_add_genre_of_artist 8, 20   
ROLLBACK TRAN
GO

-- INSERT FAILED
BEGIN TRAN
EXEC sp_add_genre_of_artist 0, 5   
ROLLBACK TRAN
GO