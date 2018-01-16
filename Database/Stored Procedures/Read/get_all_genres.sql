/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		12-1-2018									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		get_all_genres								*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_get_all_genres
GO
CREATE PROCEDURE sp_get_all_genres
AS
BEGIN
	BEGIN TRY
		SELECT genre_number, genre FROM GENRE		
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO