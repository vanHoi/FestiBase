/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		19-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Check performance constraints				*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure that checks the following:
	- An artist cannot have 2 performance at the same time.
	- 2 artists cannot be performing on the same stage at the same time.
	- The performancetime must be between the festivals duration time.
	- If the date of performance of an artist is unknown, the start time
	  must be unknown as well.
*/
DROP PROC IF EXISTS sp_check_performance;
GO
CREATE PROC sp_check_performance
	@performance_number		INT = NULL,
	@artist_number			INT,
	@podium_schedule_number	INT	= NULL,
	@festival_number		INT,
	@start_time				DATETIME = NULL,
	@play_time				INT,
	@min_prep_time			INT,
	@insert					BIT
AS
BEGIN
	DECLARE @break_time INT
	DECLARE @festival_start_date DATETIME = (SELECT start_date
											 FROM festival
											 WHERE festival_number = @festival_number)
	DECLARE @festival_end_date DATETIME = (SELECT end_date
											 FROM festival
											 WHERE festival_number = @festival_number)

	BEGIN TRY
		/* Is the date of performance not known? */
		IF @podium_schedule_number IS NULL
			/* Is the start_time known when it shouldn't be known? */
			IF @start_time IS NOT NULL
				BEGIN
					;THROW 50000, '@start_time must be NULL if the podium_schedule_number is NULL', 1
				END
		
		/* Is the date of performance known? */
		IF @podium_schedule_number IS NOT NULL
			
			IF @start_time IS NOT NULL
				BEGIN
					IF @min_prep_time > (SELECT break_time
										 FROM podium_schedule
									     WHERE podium_schedule_number = @podium_schedule_number)
						BEGIN
							;THROW 50000, '@min_prep_time cannot be higher than the break_time on this stage', 1
						END
					ELSE SET @break_time = (SELECT break_time
											FROM podium_schedule
											WHERE podium_schedule_number = @podium_schedule_number)
				END

		/* Is the artist already playing during that time? */
		ELSE IF EXISTS (SELECT 1
						FROM performance p INNER JOIN podium_schedule ps
							ON p.podium_schedule_number = ps.podium_schedule_number
						WHERE p.artist_number = @artist_number
						AND ps.start_date IN (SELECT start_date
											  FROM podium_schedule
											  WHERE podium_schedule_number = @podium_schedule_number)
						AND @start_time BETWEEN DATEADD(minute, 0 - @break_time, start_time) AND DATEADD(minute, play_time + @break_time, start_time))
			BEGIN
				;THROW 50000, 'This artist is already going to perform during that time', 1
			END

		/* Is there a different artist already playing on the same stage during that time? */
		ELSE IF EXISTS (SELECT 1
						FROM performance
						WHERE podium_schedule_number = @podium_schedule_number
						AND (@start_time BETWEEN DATEADD(minute, 0 - @break_time, start_time) AND DATEADD(minute, play_time + @break_time, start_time)
							OR DATEADD(minute, @play_time, @start_time) BETWEEN DATEADD(minute, 0 - @break_time, start_time) AND DATEADD(minute, play_time + @break_time, start_time)
							OR (@start_time < DATEADD(minute, 0 - @break_time, start_time) AND DATEADD(minute, @play_time, @start_time) > DATEADD(minute, play_time + break_time, start_time))))
			BEGIN
				;THROW 50000, 'An artist is already going to perfom on this stage during that time', 1
			END

		ELSE IF @start_time BETWEEN (
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO