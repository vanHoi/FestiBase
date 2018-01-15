/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		12-1-2018									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		get_genres_of_visitor						*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_get_genres_of_visitor
GO
CREATE PROCEDURE sp_get_genres_of_visitor
@visitor_number INT
AS
BEGIN
	BEGIN TRY
		SELECT genre_number, genre 
		FROM GENRE
		WHERE genre_number IN (SELECT genre_number FROM GENRE_preference_VISITOR WHERE visitor_number = @visitor_number)		
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO