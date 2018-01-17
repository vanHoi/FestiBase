/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		7											*/
/* Last edited:		17-01-2018									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Insert PODIUM PLAYS GENRE					*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure to add a genre to a podium
*/
DROP PROC IF EXISTS sp_add_podium_plays_genre
GO
CREATE PROC sp_add_podium_plays_genre
	@genre_number 			INT,
    @podium_number			INT
AS
BEGIN
	BEGIN TRY
			BEGIN
				INSERT INTO PODIUM_plays_GENRE(genre_number, podium_number) VALUES
				(@genre_number,
				 @podium_number
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
EXEC sp_add_podium_plays_genre 1, 3
ROLLBACK TRAN
GO

-- INSERT FAILED
BEGIN TRAN
EXEC sp_add_podium_plays_genre 8, 20   
ROLLBACK TRAN
GO