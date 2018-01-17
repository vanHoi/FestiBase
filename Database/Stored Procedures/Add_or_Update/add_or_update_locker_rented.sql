/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last Edited:		19-12-2017									*/
/* Edited by:		Robert Verkerk								*/	
/* Procedure:		Insert + Update LOCKER_RENTED				*/
/*==============================================================*/

USE FestiBase
GO

DROP PROC IF EXISTS sp_add_or_update_locker_rented
GO

CREATE PROCEDURE sp_add_or_update_locker_rented
	@locker_number int,
	@start_date datetime,
	@end_date datetime,
	@visitor_number int,
	@insert bit,
	@new_start_date datetime = NULL -- must be used for a new start date
AS
BEGIN
	BEGIN TRY
		DECLARE @start_date_to_check datetime
		
			
		IF (@locker_number IS NULL OR @start_date IS NULL)
		BEGIN
			;THROW 50004, 'You must supply locker_number and start_date.', 1
		END

		IF (@new_start_date IS NOT NULL)
		BEGIN
			SELECT @start_date_to_check = @new_start_date
		END
		ELSE
		BEGIN
			SELECT @start_date_to_check = @start_date
		END

		EXEC sp_check_locker_rented_start_end_date @start_date_to_check, @end_date, @locker_number


		EXEC sp_check_visitor_rented @locker_number, @visitor_number, @start_date_to_check, @end_date, @insert

		IF (@insert = 1)
		BEGIN
			INSERT INTO LOCKER_RENTED VALUES (@locker_number, @start_date_to_check, @end_date, @visitor_number)
		END
		ELSE
		BEGIN
			UPDATE LOCKER_RENTED SET start_date = @start_date_to_check, end_date = @end_date, visitor_number = @visitor_number WHERE locker_number = @locker_number AND start_date = @start_date
		END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO


/* enddate before enddate festival */
BEGIN TRAN
EXEC sp_add_or_update_locker_rented 3, '2017-07-15 00:00:00', '2017-07-18 00:00:00',  1, 1
ROLLBACK TRAN
GO

/* startdate after startdate festival */
BEGIN TRAN
EXEC sp_add_or_update_locker_rented 3, '2017-03-14 00:00:00',  '2017-04-15 00:00:00', 1, 1
ROLLBACK TRAN
GO

/* correct */
BEGIN TRAN
EXEC sp_add_or_update_locker_rented 3, '2017-04-15 00:00:00', '2017-04-15 20:00:00',  1, 1
ROLLBACK TRAN
GO

/* new locker already rented */
BEGIN TRAN
EXEC sp_add_or_update_locker_rented 1, '2017-04-15 00:00:00', '2017-04-16 00:00:00', 2, 1
EXEC sp_add_or_update_locker_rented 1, '2017-04-15 19:00:00', '2017-04-16 20:00:00', 2, 1
ROLLBACK TRAN
GO

/* update locker */
BEGIN TRAN
EXEC sp_add_or_update_locker_rented 2, '2017-07-15 00:00:00', '2017-04-16 15:00:00', 1, 0, '2017-04-15 00:00:00'
ROLLBACK TRAN
GO

/* add locker then update locker */
BEGIN TRAN
EXEC sp_add_or_update_locker_rented 3, '2017-04-15 21:00:00', '2017-04-15 22:00:00', 2, 1
EXEC sp_add_or_update_locker_rented 3, '2017-04-15 21:00:00', '2017-04-16 15:00:00', 2, 0, '2017-04-15 22:00:00'
ROLLBACK TRAN
GO

/* add locker update locker fail */
BEGIN TRAN
EXEC sp_add_or_update_locker_rented 3, '2017-04-15 21:00:00', '2017-04-15 22:00:00', 2, 1
EXEC sp_add_or_update_locker_rented 3, '2017-04-15 00:00:00', '2017-04-15 21:30:00', 1, 0
ROLLBACK TRAN
GO
