
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
	
DROP PROCEDURE IF EXISTS sp_check_podium_performance_festival
GO
CREATE PROCEDURE sp_check_podium_performance_festival
	@podium_number INT,
	@festival_number INT
AS
BEGIN
	BEGIN TRY
		-- check if podium has genres
		IF (@festival_number != (select festival_number FROM PODIUM WHERE podium_number = @podium_number))
		BEGIN
		 ;THROW 500001, 'The festival number of the performance is not the same as the festival number of the podium.', 1
		END

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO
