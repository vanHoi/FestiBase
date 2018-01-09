/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		09-01-2018									*/
/* Edited by:		Mariusz Blautzik							*/
/* Procedure:		Insert GENRE PREFERENCE VISITOR				*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure to add a GENRE PREFERENCE VISITOR
*/
DROP PROC IF EXISTS sp_add_genre_preference_visitor
GO
CREATE PROC sp_add_genre_preference_visitor
	@visitor_number				INT,
    @genre_number				INT
AS
BEGIN
	BEGIN TRY
			BEGIN
				INSERT INTO GENRE_preference_VISITOR (visitor_number, genre_number) VALUES
				(@visitor_number,
				 @genre_number
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
EXEC sp_add_genre_preference_visitor 1, 3
ROLLBACK TRAN
GO

-- INSERT SUCCESSFUL
BEGIN TRAN
EXEC sp_add_genre_preference_visitor 3, 2   
ROLLBACK TRAN
GO

-- INSERT FAILED
BEGIN TRAN
EXEC sp_add_genre_preference_visitor 3, 7   
ROLLBACK TRAN
GO

-- INSERT FAILED
BEGIN TRAN
EXEC sp_add_genre_preference_visitor 0, 1  
ROLLBACK TRAN
GO