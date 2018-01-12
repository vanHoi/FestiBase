/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		7											*/
/* Last edited:		12-01-2018									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Check performance constraints (C5)			*/
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
	- Start date and time are between festival start and end date
*/
DROP PROC IF EXISTS sp_check_performance;
GO
CREATE PROC sp_check_performance
	@performance_number		INT = NULL,
	@artist_number			INT,
	@podium_schedule_number	INT	= NULL,
	@festival_number		INT,
	@start_date				DATE,
	@start_time				TIME = NULL,
	@play_time				INT,
	@min_prep_time			INT = NULL,
	@insert					BIT
AS
BEGIN
	DECLARE @break_time INT

	BEGIN TRY
		IF @podium_schedule_number IS NULL
			BEGIN
				IF @start_time IS NOT NULL
					BEGIN
						;THROW 50000, '@start_time must be NULL if the podium_schedule_number is NULL', 1
					END
			END
		
		DECLARE @start_date_time DATETIME = CAST(@start_date AS DATETIME) + CAST(ISNULL(@start_time, '') AS DATETIME)
		PRINT @start_date_time
		IF ( @start_date_time NOT BETWEEN 
			(SELECT start_date FROM FESTIVAL WHERE festival_number = @festival_number) AND
			(SELECT end_date FROM FESTIVAL WHERE festival_number = @festival_number))
			BEGIN
				;THROW 500001, 'The start date and time must fit between the start and end dates of the festival', 1
			END
		IF @podium_schedule_number IS NOT NULL
			BEGIN
				SET @break_time = (SELECT break_time
								   FROM podium_schedule
								   WHERE podium_schedule_number = @podium_schedule_number)
				IF @start_time IS NOT NULL
					BEGIN
						IF @min_prep_time > @break_time
							BEGIN
								;THROW 50000, '@min_prep_time cannot be higher than the break_time on this stage', 1
							END

								/* BR15		Is the artist already playing during that time? */
								IF EXISTS (SELECT performance_number
										   FROM performance p INNER JOIN podium_schedule ps
											   ON p.podium_schedule_number = ps.podium_schedule_number
										   WHERE p.artist_number = @artist_number
										   AND ps.start_date IN (SELECT start_date
																 FROM podium_schedule
																 WHERE podium_schedule_number = @podium_schedule_number)
										   AND @start_time BETWEEN DATEADD(minute, 0 - @break_time, p.start_time) 
											   AND DATEADD(minute, p.play_time + @break_time, p.start_time))
									BEGIN
										;THROW 50000, 'This artist is already going to perform during that time', 1
									END

								/* BR14		Is there a different artist already playing on the same stage during that time? */
								ELSE IF EXISTS (SELECT performance_number
												FROM performance
												WHERE podium_schedule_number = @podium_schedule_number
												AND (@start_time BETWEEN DATEADD(minute, 0 - @break_time, start_time) 
													AND DATEADD(minute, play_time + @break_time, start_time)
													OR DATEADD(minute, @play_time, @start_time) BETWEEN DATEADD(minute, 0 - @break_time, start_time) 
														AND DATEADD(minute, play_time + @break_time, start_time)
													OR (@start_time < DATEADD(minute, 0 - @break_time, start_time) 
														AND DATEADD(minute, @play_time, @start_time) > DATEADD(minute, play_time + @break_time, start_time))))
									BEGIN
										;THROW 50000, 'An artist is already going to perfom on this stage during that time', 1
									END

								/* BR20		Does the inserted/updated performance fit within the start and endtime of that podium_schedule */
								ELSE IF (@start_time
											NOT BETWEEN (SELECT start_time 
														 FROM podium_schedule 
														 WHERE podium_schedule_number = @podium_schedule_number)
											AND (SELECT end_time 
												 FROM podium_schedule 
												 WHERE podium_schedule_number = @podium_schedule_number))
										OR (DATEADD(minute, @play_time, @start_time) 
											NOT BETWEEN (SELECT start_time 
														 FROM podium_schedule 
														 WHERE podium_schedule_number = @podium_schedule_number)
											AND (SELECT end_time 
												 FROM podium_schedule 
												 WHERE podium_schedule_number = @podium_schedule_number))
										OR (@start_time 
											< (SELECT start_time 
											   FROM podium_schedule 
											   WHERE podium_schedule_number = @podium_schedule_number))
											AND (DATEADD(minute, @play_time, @start_time) 
											> (SELECT end_time 
											   FROM podium_schedule 
											   WHERE podium_schedule_number = @podium_schedule_number))
									BEGIN
										;THROW 50000, 'The inserted or updated performance time does not fit within that podium_schedule', 1
									END
					END
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO