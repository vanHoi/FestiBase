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
		SELECT G.genre_number, G.genre, GPV.visitor_number
		FROM GENRE as G FULL OUTER JOIN GENRE_preference_VISITOR AS GPV
		ON G.genre_number = GPV.genre_number
		AND GPV.visitor_number = @visitor_number
		WHERE G.genre_number IS NOT NULL
		ORDER BY GPV.visitor_number DESC, G.genre ASC
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO