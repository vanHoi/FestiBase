/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		8-1-2018									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		CHECK if the genre of an artist				*/
/*					is the same as the genre of the podium		*/
/*==============================================================*/

USE FestiBase
GO
	
DROP PROCEDURE IF EXISTS sp_check_podium_genre_with_artist_genre
GO
CREATE PROCEDURE sp_check_podium_genre_with_artist_genre
	@artist_number int,
	@podium_number int
AS
BEGIN
	BEGIN TRY
		-- check if podium has genres
		IF EXISTS (SELECT 1 FROM PODIUM_plays_GENRE WHERE podium_number = @podium_number)
		BEGIN
			-- check if artist has correct genres
			IF NOT EXISTS ( SELECT * FROM GENRE_of_ARTIST as g
							RIGHT JOIN PODIUM_plays_GENRE as p 
							on g.genre_number = p.genre_number
							WHERE artist_number = @artist_number
							AND podium_number = @podium_number	)
				BEGIN
				;THROW 50000, 'The artist cannot perform on this podium because the genres do not match', 1
				END

		END

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO


/*
	Procedure naam begint met sp_
	Procedure naam niet in camelcases, maar kleine letters en _
	@surrogate_key moet ingevuld zijn voor een update, voor insert gebruik NULL.
	Gebruik een ;THROW, niet een RAISERROR.
*/