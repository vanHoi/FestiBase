/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Delete podium_schedule 						*/
/*==============================================================*/
USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_podium_schedule
GO
CREATE PROCEDURE sp_delete_podium_schedule
	@podium_schedule_number INT
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT *
				   FROM PODIUM_SCHEDULE
				   WHERE podium_schedule_number = @podium_schedule_number)
			BEGIN
				;THROW 50000, 'This podium schedule does not exist', 1
			END

		DELETE FROM PODIUM_SCHEDULE WHERE podium_schedule_number = @podium_schedule_number
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* tests */
/* delete FK constraint*/
BEGIN TRAN
EXEC sp_delete_podium_schedule 2
ROLLBACK TRAN
GO

/* delete genre doesn't exist */
BEGIN TRAN
EXEC sp_delete_podium_schedule 55
ROLLBACK TRAN
GO