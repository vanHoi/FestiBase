/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		21-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Insert + Update PODIUM_SCHEDULE				*/
/*==============================================================*/

USE FestiBase
GO

/*
	This procedure checks the following:

	-	If the start date and time of a podium_schedule fits between the festival start and end datetime
	-	If the end date and time of a podium_schedule fits between the festival start and end datetime
*/
DROP PROC IF EXISTS sp_check_podium_schedule;
GO
CREATE PROC sp_check_podium_schedule
	@podium_number				INT,
	@start_date					DATE,
	@start_time					TIME,
	@end_date					DATE,
	@end_time					TIME,
	@break_time					INT
AS
BEGIN
	BEGIN TRY
		DECLARE @start_date_time DATETIME = CAST(@start_date AS DATETIME) + CAST(@start_time AS DATETIME)
		DECLARE @end_date_time DATETIME = CAST(@end_date AS DATETIME) + CAST(@end_time AS DATETIME)

		DECLARE @festival_start_date_time DATETIME = (SELECT f."start_date"
													  FROM festival f INNER JOIN podium p
													      ON f.festival_number = p.festival_number
													  WHERE p.podium_number = @podium_number)
		DECLARE @festival_end_date_time DATETIME = (SELECT f.end_date
													FROM festival f INNER JOIN podium p
													    ON f.festival_number = p.festival_number
													WHERE p.podium_number = @podium_number)
		
		/* Checks if the start date and time fits between the festival duration	*/
		IF (@start_date_time NOT BETWEEN @festival_start_date_time AND @festival_end_date_time)
			BEGIN
				;THROW 50000, 'The start date and time must fit between the start and end dates of the festival', 1
			END

		/* Checks if the end date and time fits between the festival duration */
		IF (@end_date_time NOT BETWEEN @festival_start_date_time AND @festival_end_date_time)
			BEGIN
				;THROW 50000, 'The end date and time must fit between the start and end dates of the festival', 1
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO