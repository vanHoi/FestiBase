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
	Procedure to add or update a PODIUM_SCHEDULE
*/
DROP PROC IF EXISTS sp_add_or_update_podium_schedule;
GO
CREATE PROC sp_add_or_update_podium_schedule
	@podium_schedule_number		INT = NULL,
	@podium_number				INT,
	@start_date					DATE,
	@start_time					TIME,
	@end_date					DATE,
	@end_time					TIME,
	@break_time					INT,
	@insert						BIT
AS
BEGIN
	BEGIN TRY
		EXEC sp_check_podium_schedule @podium_number, @start_date, @start_time, @end_date, @end_time, @break_time

		IF (@insert = 1)
			BEGIN
				INSERT INTO PODIUM_SCHEDULE (podium_number, "start_date", start_time, end_date, end_time, break_time) VALUES
				(@podium_number,
				 @start_date,
				 @start_time,
				 @end_date,
				 @end_time,
				 @break_time)
			END
		ELSE
			BEGIN
				IF (@podium_schedule_number IS NULL OR @podium_schedule_number = 0)
					BEGIN
						;THROW 50000, '@podium_schedule_number cannot be NULL if an UPDATE is to be commenced', 1
					END

				ELSE IF NOT EXISTS (SELECT *
									FROM podium_schedule
									WHERE podium_schedule_number = @podium_schedule_number)
					BEGIN
						;THROW 50000, 'This podium schedule does not exist', 1
					END

					UPDATE PODIUM_SCHEDULE SET 
					podium_number = @podium_number,
					"start_date" = @start_date,
					start_time = @start_time,
					end_date = @end_date,
					end_time = @end_time,
					break_time = @break_time
					WHERE podium_schedule_number = @podium_schedule_number
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- Test INSERT
BEGIN TRAN
EXEC sp_add_or_update_podium_schedule NULL, 1, '2017-04-15', '14:00:00', '2017-04-16', '02:00:00', 30, 1
ROLLBACK TRAN
GO

-- Test UPDATE
BEGIN TRAN
EXEC sp_add_or_update_podium_schedule 1, 1, '2017-04-15', '14:00:00', '2017-04-16', '02:00:00', 30, 0
ROLLBACK TRAN
GO

-- Test UPDATE (SK does not exist)
BEGIN TRAN
EXEC sp_add_or_update_podium_schedule 300, 1, '2017-04-15', '14:00:00', '2017-04-16', '02:00:00', 30, 0
ROLLBACK TRAN
GO

-- Test UPDATE (SK NULL)
BEGIN TRAN
EXEC sp_add_or_update_podium_schedule NULL, 1, '2017-04-15', '14:00:00', '2017-04-16', '02:00:00', 30, 0
ROLLBACK TRAN
GO

-- Test INSERT (fails the check)
BEGIN TRAN
EXEC sp_add_or_update_podium_schedule NULL, 1, '2017-04-16', '14:00:00', '2017-04-17', '02:00:00', 30, 1
ROLLBACK TRAN
GO

BEGIN TRAN
EXEC sp_add_or_update_podium_schedule NULL, 1, '2017-04-13', '14:00:00', '2017-04-14', '02:00:00', 30, 1
ROLLBACK TRAN
GO

-- Test INSERT (startdate before enddate)
BEGIN TRAN
EXEC sp_add_or_update_podium_schedule NULL, 1, '2017-04-15', '14:00:00', '2017-04-14', '02:00:00', 30, 1
ROLLBACK TRAN
GO

-- Test INSERT 
BEGIN TRAN
EXEC sp_add_or_update_podium_schedule NULL, 1, '2017-04-15', '14:00:00', '2017-04-15', '00:00:00', 30, 1
ROLLBACK TRAN
GO