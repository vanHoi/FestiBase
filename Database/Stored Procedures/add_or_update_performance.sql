/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		19-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Insert + Update PERFORMANCE					*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure to add or update a PERFORMANCE
*/
DROP PROC IF EXISTS sp_add_or_update_performance;
GO
CREATE PROC sp_add_or_update_performance
	@performance_number		INT = NULL,
	@artist_number			INT,
	@podium_schedule_number	INT	= NULL,
	@festival_number		INT,
	@start_time				TIME = NULL,
	@play_time				INT,
	@min_prep_time			INT,
	@insert					BIT
AS
BEGIN
	BEGIN TRY
		/* Checking the constraints on performance */
		EXEC sp_check_performance 
		@performance_number,
		@artist_number,
		@podium_schedule_number,
		@festival_number,
		@start_time,
		@play_time,
		@min_prep_time,
		@insert

		/* IF @insert = 1, THEN INSERT.		IF @insert = 0, THEN UPDATE */
		IF (@insert = 1)
			BEGIN
				/* INSERT */
				INSERT INTO PERFORMANCE (artist_number, podium_schedule_number, festival_number, start_time, play_time, min_prep_time) VALUES
				(@artist_number,
				 @podium_schedule_number,
				 @festival_number,
				 @start_time,
				 @play_time,
				 @min_prep_time)
			END
		ELSE
			BEGIN
				IF (@performance_number = null)
					BEGIN
						;THROW 50000, '@performance_number cannot be NULL if an UPDATE is to be commenced', 1
					END

					/* UPDATE */
					UPDATE PERFORMANCE SET
					artist_number = @artist_number,
					podium_schedule_number = @podium_schedule_number,
					festival_number = @festival_number,
					start_time = @start_time,
					play_time = @play_time,
					min_prep_time = @min_prep_time
					WHERE performance_number = @performance_number
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/*
	TEST
*/

SELECT * FROM podium_schedule

SELECT * FROM performance

SELECT * FROM artist

-- should work
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, 4, 2, '15:00:00', 90, 30, 1 
ROLLBACK TRAN

BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, NULL, 2, NULL, 90, 30, 1 
ROLLBACK TRAN

-- should NOT work
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, 4, 2, '22:00:00', 90, 30, 1 
ROLLBACK TRAN

BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, NULL, 2, '15:00:00', 90, 30, 1 
ROLLBACK TRAN

SELECT 1
FROM performance
WHERE podium_schedule_number = @podium_schedule_number
AND (@start_time BETWEEN DATEADD(minute, 0 - @break_time, start_time) AND DATEADD(minute, play_time + @break_time, start_time)
	OR DATEADD(minute, @play_time, @start_time) BETWEEN DATEADD(minute, 0 - @break_time, start_time) AND DATEADD(minute, play_time + @break_time, start_time)
	OR (@start_time < DATEADD(minute, 0 - @break_time, start_time) AND DATEADD(minute, @play_time, @start_time) > DATEADD(minute, play_time + @break_time, start_time)))
