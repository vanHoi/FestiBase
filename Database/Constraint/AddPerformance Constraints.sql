/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version 5												*/
/* Yuri Vannisselroy											*/	
/* 14-12-2017													*/
/* Constraint													*/
/*==============================================================*/

USE FestiBase
GO

SET DATEFORMAT DMY
GO

/*
	Two artists cannot have a performance at the same time (or during someone elses build-up time).
	An artist cannot have 2 performance at the same time.
	A performance can only be done within the duration of a festival.
	@performance_number		(IF insert, 0)
	@podium_number
	@artist_number
	@festival_number
	@date
	@start_time
	@play_time
	@override				(time_between_performances_override)
	@insert					(IF insert THEN 1, IF update THEN 0)
*/
DROP PROC IF EXISTS sp_insert_performances
GO
CREATE PROC sp_insert_performances
	@performance_number INT = NULL,
	@podium_number		INT,
	@artist_number		INT,
	@festival_number	INT,
	@date				DATE,
	@start_time			TIME,
	@play_time			INT,
	@preparation_time	INT,
	@insert				BIT
AS
BEGIN
	DECLARE @builduptime INT = @preparation_time - (@preparation_time * 2)

	BEGIN TRY
		/* Check if a performance already exists within the inserted date and time on the inserted stage */
		IF EXISTS (SELECT podium_number
				   FROM performance
				   WHERE podium_number = @podium_number
				   AND festival_number = @festival_number
				   AND date = @date
				   AND (@start_time BETWEEN DATEADD(start_time AND DATEADD(minute, @play_time, @start_time)) 
				   OR DATEADD(minute, play_time, start_time) BETWEEN DATEADD(minute, @builduptime, @start_time) AND DATEADD(minute, @play_time, @start_time)
				   OR (DATEADD(minute, time_between_performances_override, start_time) < @start_time AND DATEADD(minute, play_time, start_time) > DATEADD(minute, @play_time, @start_time)))		   
		BEGIN
			;THROW 50001, 'An artist is already going to perform on this stage at that time', 1
		END

		/* Check if the artist already has a performance within the inserted date and time */
		DECLARE @downtime INT;
		IF (@preparation_time = 0)
		BEGIN
			SELECT time_between_performance FROM PODIUM WHERE podium_number = @podium_number AND festival_number = @festival_number
		ELSE
			@downtime = @preparation_time


		IF EXISTS  (SELECT artist_number
					FROM PERFORMANCE
					WHERE artist_number = @artist_number
					AND date = @date
					AND (DATEADD(minute, time_between_performances_override, start_time) BETWEEN DATEADD(minute, @builduptime, @start_time) AND DATEADD(minute, @play_time, @start_time)) 
				    OR DATEADD(minute, play_time, start_time) BETWEEN DATEADD(minute, @builduptime, @start_time) AND DATEADD(minute, @play_time, @start_time)
				    OR (DATEADD(minute, time_between_performances_override, start_time) < DATEADD(minute, @builduptime, @start_time) AND DATEADD(minute, play_time, start_time) > DATEADD(minute, @play_time, @start_time)))
		BEGIN
			;THROW 50001, 'This artist is already performing at that time', 1
		END

		/* Check if the start_time and date of a performance fits between the start_date and end_date of a festival */
		IF CAST(@date AS DATETIME) + CAST(DATEADD(minute, @builduptime, @start_time) AS DATETIME) 
		NOT BETWEEN (SELECT start_date
					 FROM FESTIVAL
					 WHERE festival_number = @festival_number)
			    AND (SELECT end_date
				     FROM FESTIVAL
					 WHERE festival_number = @festival_number)
		BEGIN
			;THROW 50001, 'A performance must start between the festivals start_date and end_date', 1
		END

		/* Check if the end_time and date of a performance fits between the start_date and end_date of a festival */
		IF CAST(@date AS DATETIME) + CAST(DATEADD(minute, @play_time, @start_time) AS DATETIME) 
		NOT BETWEEN (SELECT start_date
					 FROM FESTIVAL
					 WHERE festival_number = @festival_number)
				AND (SELECT end_date
					 FROM FESTIVAL
					 WHERE festival_number = @festival_number)
		BEGIN
			;THROW 50001, 'A performance must end between the festivals start_date and end_date', 1
		END

		/* if all of the above has been checked, check if @insert is 1 (insert) or 0 (update). Also check if performance isn't 0 when updating */
		ELSE IF @insert = 1
			BEGIN
				INSERT INTO PERFORMANCE VALUES
				(@podium_number,
				 @artist_number,
				 @festival_number,
				 @date,
				 @start_time,
				 @play_time,
				 @preparation_time)
			END
		ELSE IF @insert = 0 AND @performance_number != 0
			BEGIN
				UPDATE PERFORMANCE SET 
				podium_number = @podium_number,
				artist_number = @artist_number,
				festival_number = @festival_number,
				date = @date,
				start_time = @start_time,
				play_time = @play_time,
				time_between_performances_override = @preparation_time
				WHERE performance_number = @performance_number
			END
		ELSE IF @insert = 0 AND @performance_number = 0
			BEGIN
				;THROW 50001, '@performance_number cannot be NULL if an update is to be commenced', 1
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

SELECT * FROM festival

SELECT * FROM performance


--These inserts should NOT work
BEGIN TRAN
EXEC sp_insert_performances 0, 1, 5, 1, '15-07-2017', '12:30:00', 120, 60, 1
ROLLBACK TRAN

BEGIN TRAN
EXEC sp_insert_performances 0, 1, 5, 1, '15-07-2017', '11:40:00', 4, 60, 1
ROLLBACK TRAN

--These inserts should work
BEGIN TRAN
EXEC sp_insert_performances 0, 1, 4, 1, '01-04-2017', '20:00:00', 110, 60, 1
ROLLBACK TRAN

BEGIN TRAN
EXEC sp_insert_performances 0, 1, 5, 1, '02-04-2017', '17:00:00', 120, 60, 1
ROLLBACK TRAN

---------------------------------------------------------------------

--These updates should NOT work
BEGIN TRAN
EXEC sp_check_performances 2, 1, 3, 1, '01-04-2017', '17:00:00', 60, 60, 0
ROLLBACK TRAN

BEGIN TRAN
EXEC sp_check_performances 2, 1, 3, 1, '01-04-2017', '14:00:00', 140, 60, 0
ROLLBACK TRAN

--These updates should work
BEGIN TRAN
EXEC sp_check_performances 2, 2, 3, 1, '02-04-2018', '15:00:00', 60, 60, 0
ROLLBACK TRAN

BEGIN TRAN
EXEC sp_check_performances 2, 1, 4, 1, '08-04-2017', '17:00:00', 120, 60, 0
ROLLBACK TRAN
