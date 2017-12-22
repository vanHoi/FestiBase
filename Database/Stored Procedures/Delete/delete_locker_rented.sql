/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Delete LOCKER_RENTED						*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_locker_rented
GO
CREATE PROCEDURE sp_delete_locker_rented
	@locker_number	INT,
	@start_date		DATETIME
AS
BEGIN
	BEGIN TRY

		IF NOT EXISTS (SELECT *
					   FROM LOCKER_RENTED
				       WHERE locker_number = @locker_number
					   AND "start_date" = @start_date)
			BEGIN
				;THROW 50000, 'This rented locker does not exist', 1
			END

		DELETE FROM LOCKER_RENTED WHERE locker_number = @locker_number 
						  AND "start_date" = @start_date

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- TEST
BEGIN TRAN
EXEC sp_delete_locker_rented 1, '2017-07-15 00:00:00'
ROLLBACK TRAN
GO

-- TEST (does not exist)
BEGIN TRAN
EXEC sp_delete_locker_rented 1000, '2017-07-15 00:00:00'
ROLLBACK TRAN
GO