/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		7											*/
/* Last edited:		12-01-2018									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Insert + Update PERFORMANCE					*/
/*==============================================================*/

USE FestiBase
GO

SET DATEFORMAT DMY
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
	@start_date				DATE,
	@start_time				TIME = NULL,
	@play_time				INT,
	@min_prep_time			INT = NULL,
	@insert					BIT
AS
BEGIN
	BEGIN TRY
		IF (@podium_schedule_number IS NOT NULL OR @podium_schedule_number != 0)
			BEGIN
				/* Checking if the start_date matches the schedules start_date */
				EXEC sp_check_performance_date_with_podium_schedule
				@start_date,
				@podium_schedule_number
			END

		/* Checking the constraints on performance */
		EXEC sp_check_performance 
		@performance_number,
		@artist_number,
		@podium_schedule_number,
		@festival_number,
		@start_date,
		@start_time,
		@play_time,
		@min_prep_time,
		@insert

		DECLARE @podium_number INT
 		SET @podium_number = (SELECT podium_number FROM PODIUM_SCHEDULE where podium_schedule_number = @podium_schedule_number)

 		EXEC sp_check_podium_genre_with_artist_genre
		@artist_number,
 		@podium_number

		EXEC sp_check_podium_performance_festival
		@podium_number,
		@festival_number

		IF (@insert = 1)
			BEGIN
				INSERT INTO PERFORMANCE (artist_number, podium_schedule_number, festival_number, "start_date", start_time, play_time, min_prep_time) VALUES
				(@artist_number,
				 @podium_schedule_number,
				 @festival_number,
				 @start_date,
				 @start_time,
				 @play_time,
				 @min_prep_time)
			END
		ELSE
			BEGIN
				IF (@performance_number IS NULL OR @performance_number = 0)
					BEGIN
						;THROW 50000, '@performance_number cannot be NULL if an UPDATE is to be commenced', 1
					END

				ELSE IF NOT EXISTS (SELECT *
								   FROM performance	
								   WHERE performance_number = @performance_number)
					BEGIN
						;THROW 50000, 'This performance does not exist', 1
					END

					UPDATE PERFORMANCE SET
					artist_number = @artist_number,
					podium_schedule_number = @podium_schedule_number,
					festival_number = @festival_number,
					"start_date" = @start_date,
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
	These tests should work
*/

SET DATEFORMAT DMY
GO

-- INSERT
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, 3, 3, '15-06-2018','15:00:00', 90, 15, 1 
ROLLBACK TRAN
GO

BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, NULL, 1, '14-04-2017', NULL, 90, NULL, 1 
ROLLBACK TRAN
GO

BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, NULL, 3, '16-06-2018', NULL, 90, 30, 1 
ROLLBACK TRAN
GO

BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 1, 2, 2, '31-03-2018', '14:30:00', 90, 10, 1 
ROLLBACK TRAN
GO

-- UPDATE
BEGIN TRAN
EXEC sp_add_or_update_performance 10, 1, 2, 2, '31-03-2018', '14:30:00', 90, 10, 0 
ROLLBACK TRAN
GO

BEGIN TRAN
EXEC sp_add_or_update_performance 10, 8, NULL, 1, '14-04-2017', NULL, 90, 30, 0
ROLLBACK TRAN
GO


/*
	These tests should NOT work
*/

-- INSERT (An artist is already playing during that time)
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, 4, 2, '16-06-2018', '20:00:00', 90, 15, 1 
ROLLBACK TRAN
GO

-- INSERT (This artist is already going to perform during that time)
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 9, 4, 2, '16-06-2018', '21:00:00', 90, 15, 1 
ROLLBACK TRAN
GO

-- INSERT (The start_time cannot be known if the schedule is NULL)
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, NULL, 2, '30-03-2018', '15:00:00', 90, 15, 1 
ROLLBACK TRAN
GO

-- INSERT (This performance does not fit the schedule)
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, 4, 2, '16-06-2018', '13:59:00', 90, 15, 1 
ROLLBACK TRAN
GO

--  INSERT ( Podium of wrong festival )
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, 3, 1, '15-06-2018', NULL, 90, 30, 1
ROLLBACK TRAN
GO

-- INSERT (The artist has the wrong genre for this podium)
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 3, 1, 1, '30-03-2018', '14:00:00', 30, 5, 1
ROLLBACK TRAN
GO

-- INSERT (Wrong starttime)
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 1, 1, 1, '30-03-2018', '09:00:00', 10, 5, 1
ROLLBACK TRAN
GO

-- INSERT (dates do not match)
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 1, 1, 1, '30-03-2014', '14:00:00', 30, 5, 1
ROLLBACK TRAN
GO

-- UPDATE (An artist is already playing during that time)
BEGIN TRAN
EXEC sp_add_or_update_performance 9, 8, 4, 2, '16-06-2018', '20:00:00', 90, 15, 0
ROLLBACK TRAN
GO

-- UPDATE (This artist is already going to perform during that time)
BEGIN TRAN
EXEC sp_add_or_update_performance 9, 9, 4, 2, '16-06-2018', '21:00:00', 90, 15, 0 
ROLLBACK TRAN
GO

-- UPDATE (The start_time cannot be known if the schedule is NULL)
BEGIN TRAN
EXEC sp_add_or_update_performance 9, 8, NULL, 2, '30-03-2018', '15:00:00', 90, 15, 0 
ROLLBACK TRAN
GO

-- UPDATE (This performance does not fit the schedule)
BEGIN TRAN
EXEC sp_add_or_update_performance 9, 8, 1, 1, '30-03-2018', '13:59:00', 90, 15, 0
ROLLBACK TRAN
GO

-- UPDATE (@performance_number cannot be NULL)
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, NULL, 1, '30-03-2018', NULL, 90, 15, 0 
ROLLBACK TRAN
GO

-- UPDATE (This performance does not exist)
BEGIN TRAN
EXEC sp_add_or_update_performance 300, 1, 1, 1, '30-03-2018', '15:00:00', 90, 15, 0
ROLLBACK TRAN
GO

-- UPDATE (WARNING - PODIUM TOO SMALL)
BEGIN TRAN 
EXEC sp_add_or_update_performance 9, 8, 3, 3, '15-06-2015', '14:00:00', 90,  15, 0
ROLLBACK TRAN
GO

-- UPDATE (The artist has the wrong genre for this podium)
BEGIN TRAN
EXEC sp_add_or_update_performance 2, 5, 1, 1, '30-03-2018', '14:00:00', 30, 5, 1
ROLLBACK TRAN
GO

-- UPDATE (Podium of wrong festival)
BEGIN TRAN
EXEC sp_add_or_update_performance 10, 8, 3, 2, '30-03-2018', NULL, 90, 30, 0
ROLLBACK TRAN
GO

-- UPDATE (wrong endtime)
BEGIN TRAN
EXEC sp_add_or_update_performance 2, 1, 1, 1, '30-03-2018', '23:01:00', 30, 5,  0
ROLLBACK TRAN
GO

SELECT * FROM dbo.PODIUM_SCHEDULE

SELECT * FROM dbo.FESTIVAL

SELECT * FROM dbo.PERFORMANCE WHERE podium_schedule_number = 2