/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		7											*/
/* Last edited:		12-01-2018									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Check performance date with podium_schedule	*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure that checks the following:
	-	When a performance gets linked to a podium_schedule,
		the start_date of both must match
*/

DROP PROCEDURE IF EXISTS sp_check_performance_date_with_podium_schedule
GO
CREATE PROCEDURE sp_check_performance_date_with_podium_schedule
	@start_date					DATE,
	@podium_schedule_number		INT
AS
BEGIN
	BEGIN TRY

		IF @start_date != (SELECT "start_date"
						   FROM PODIUM_SCHEDULE
						   WHERE podium_schedule_number = @podium_schedule_number)
			BEGIN
				;THROW 50000, 'The start_date of this podium_schedule does not match with the start_date of this performance', 1
			END

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO