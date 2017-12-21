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
	@min_prep_time			INT = NULL,
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

		IF (@insert = 1)
			BEGIN
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

-- INSERT
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, 4, 2, '15:00:00', 90, 30, 1 
ROLLBACK TRAN
GO

BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, NULL, 2, NULL, 90, NULL, 1 
ROLLBACK TRAN
GO

BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, NULL, 2, NULL, 90, 30, 1 
ROLLBACK TRAN
GO

-- UPDATE
BEGIN TRAN
EXEC sp_add_or_update_performance 10, 8, 4, 2, '15:00:00', 90, 30, 0 
ROLLBACK TRAN
GO

BEGIN TRAN
EXEC sp_add_or_update_performance 10, 8, NULL, 2, NULL, 90, 30, 0
ROLLBACK TRAN
GO


/*
	These tests should NOT work
*/

-- INSERT (An artist is already playing during that time)
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, 4, 2, '20:00:00', 90, 30, 1 
ROLLBACK TRAN
GO

-- INSERT (This artist is already going to perform during that time)
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 9, 4, 2, '21:00:00', 90, 30, 1 
ROLLBACK TRAN
GO

-- INSERT (The start_time cannot be known if the schedule is NULL)
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, NULL, 2, '15:00:00', 90, 30, 1 
ROLLBACK TRAN
GO

-- INSERT (This performance does not fit the schedule)
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, 4, 2, '13:59:00', 90, 30, 1 
ROLLBACK TRAN
GO

-- UPDATE (An artist is already playing during that time)
BEGIN TRAN
EXEC sp_add_or_update_performance 9, 8, 4, 2, '20:00:00', 90, 30, 0
ROLLBACK TRAN
GO

-- UPDATE (This artist is already going to perform during that time)
BEGIN TRAN
EXEC sp_add_or_update_performance 9, 9, 4, 2, '21:00:00', 90, 30, 0 
ROLLBACK TRAN
GO

-- UPDATE (The start_time cannot be known if the schedule is NULL)
BEGIN TRAN
EXEC sp_add_or_update_performance 9, 8, NULL, 2, '15:00:00', 90, 30, 0 
ROLLBACK TRAN
GO

-- UPDATE (This performance does not fit the schedule)
BEGIN TRAN
EXEC sp_add_or_update_performance 9, 8, 4, 2, '13:59:00', 90, 30, 0
ROLLBACK TRAN
GO

-- UPDATE (@performance_number cannot be NULL)
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, NULL, 2, '15:00:00', 90, 30, 0 
ROLLBACK TRAN
GO

-- UPDATE (This performance does not exist)
BEGIN TRAN
EXEC sp_add_or_update_performance 300, 8, 4, 2, '15:00:00', 90, 30, 0
ROLLBACK TRAN
GO