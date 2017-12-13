/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version 5												*/	
/* Constraint													*/
/*==============================================================*/

USE FestiBase
GO

/*
	Twee artiesten kunnen niet tegelijk optreden. IF oke, dan insert of update.
	@performance_number		(IF insert, geef NULL mee)
	@podium_number
	@artist_number
	@date
	@start_time
	@play_time
	@insert					(IF insert dan 1, IF update dan 0)
*/
DROP PROC IF EXISTS sp_check_performances
GO
CREATE PROC sp_check_performances
	@performance_number INT = NULL,
	@podium_number		INT,
	@artist_number		INT,
	@date				DATE,
	@start_time			TIME,
	@play_time			INT,
	@insert				BIT
AS
BEGIN
	BEGIN TRY
		IF EXISTS (SELECT podium_number
				   FROM performance
				   WHERE podium_number = @podium_number
				   AND date = @date
				   AND start_time BETWEEN @start_time AND DATEADD(minute, @play_time, @start_time))
		BEGIN
			;THROW 50001, 'There is already an artist playing on this stage at that time', 1
		END

		ELSE IF @insert = 1
			BEGIN
				INSERT INTO PERFORMANCE VALUES
				(@podium_number,
				 @artist_number,
				 @date,
				 @start_time,
				 @play_time)
			END
		
		ELSE IF @insert = 0 AND @performance_number != NULL
			BEGIN
				UPDATE PERFORMANCE SET 
				podium_number = @podium_number,
				artist_number = @artist_number,
				date = @date,
				start_time = @start_time,
				play_time = @play_time
				WHERE performance_number = @performance_number
			END
		ELSE IF @insert = 0 AND @performance_number = NULL
			BEGIN
				;THROW 50001, '@performance_number cannot be NULL if an update is to be commenced', 1
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO


--Deze insert werkt niet
BEGIN TRAN
EXEC sp_check_performances 0, 1, 2, '01-04-2017', '15:00:00', 60, 1
ROLLBACK TRAN

BEGIN TRAN
EXEC sp_check_performances 0, 1, 2, '01-04-2017', '14:00:00', 140, 1
ROLLBACK TRAN

--Deze insert werkt wel
BEGIN TRAN
EXEC sp_check_performances 0, 2, 3, '05-04-2017', '16:00:00', 110, 1
ROLLBACK TRAN

BEGIN TRAN
EXEC sp_check_performances 0, 1, 4, '08-04-2017', '17:00:00', 120, 1
ROLLBACK TRAN

---------------------------------------------------------------------

--Deze update werkt niet
BEGIN TRAN
EXEC sp_check_performances 2, 1, 3, '01-04-2017', '15:00:00', 60, 0
ROLLBACK TRAN

BEGIN TRAN
EXEC sp_check_performances 2, 1, 3, '01-04-2017', '14:00:00', 140, 0
ROLLBACK TRAN

--Deze update werkt niet
BEGIN TRAN
EXEC sp_check_performances 2, 2, 3, '02-04-2018', '15:00:00', 60, 0
ROLLBACK TRAN

BEGIN TRAN
EXEC sp_check_performances 2, 1, 4, '08-04-2017', '17:00:00', 120, 0
ROLLBACK TRAN
