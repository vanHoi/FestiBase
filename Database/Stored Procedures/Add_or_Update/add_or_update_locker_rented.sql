﻿/*==============================================================*/
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

DROP PROC IF EXISTS sp_check_locker_rented_start_end_date
GO

CREATE PROC sp_check_locker_rented_start_end_date
	@start_date datetime,
	@end_date datetime,
	@locker_number int
AS
BEGIN
	BEGIN TRY
		IF (@start_date < (SELECT start_date FROM FESTIVAL WHERE festival_number = (SELECT festival_number FROM LOCKER WHERE locker_number = @locker_number)))
		BEGIN	
			;THROW 50000, 'The startdate must be after the startdate of a festival', 1
		END
		/*check if enddate is voor endate van festival*/
		IF (@end_date > (SELECT end_date FROM FESTIVAL WHERE festival_number = (SELECT festival_number FROM LOCKER WHERE locker_number = @locker_number)))
		BEGIN	
			;THROW 50001, 'The enddate must be before the enddate of a festival', 1	
		END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

DROP PROC IF EXISTS sp_check_visitor_rented
GO

CREATE PROC sp_check_visitor_rented
	@locker_number int,
	@visitor_number int,
	@start_date datetime,
	@end_date datetime,
	@insert bit
AS
BEGIN
	BEGIN TRY
	IF (@insert = 1)
		BEGIN
			IF EXISTS (	SELECT 1
						FROM LOCKER_RENTED
						WHERE locker_number = @locker_number
						AND (( @start_date BETWEEN start_date AND end_date ) 
						OR 	( @end_date	BETWEEN start_date AND end_date ) ) )
			BEGIN
				;THROW 50002, 'This locker is already rented at the given start or end date.', 1
			END
		END
		ELSE
		BEGIN
			IF EXISTS (	SELECT 1
						FROM LOCKER_RENTED
						WHERE locker_number = @locker_number
						AND visitor_number != @visitor_number
						AND (( @start_date BETWEEN start_date AND end_date ) 
						OR	( @end_date	BETWEEN start_date AND end_date ) ) )
			BEGIN
				;THROW 50003, 'This locker is already rented at the given start or end date.', 1
			END

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

/* startdate after startdate festival */
BEGIN TRAN
EXEC sp_add_or_update_locker_rented 3, '2017-07-14 00:00:00',  '2017-07-17 00:00:00', 1, 1
ROLLBACK TRAN

/* correct */
BEGIN TRAN
EXEC sp_add_or_update_locker_rented 3, '2017-07-15 00:00:00', '2017-07-15 20:00:00',  1, 1
ROLLBACK TRAN

/* new locker already rented */
BEGIN TRAN
EXEC sp_add_or_update_locker_rented 3, '2017-07-15 19:00:00', '2017-07-16 20:00:00', 2, 1
ROLLBACK TRAN

/* update locker */
BEGIN TRAN
EXEC sp_add_or_update_locker_rented 3, '2017-07-15 00:00:00', '2017-07-15 15:00:00', 1, 0
ROLLBACK TRAN

/* add locker then update locker */
BEGIN TRAN
EXEC sp_add_or_update_locker_rented 3, '2017-07-15 21:00:00', '2017-07-15 22:00:00', 2, 1
EXEC sp_add_or_update_locker_rented 3, '2017-07-15 21:00:00', '2017-07-16 15:00:00', 2, 0, '2017-07-15 22:00:00'
ROLLBACK TRAN

/* add locker update locker fail */
BEGIN TRAN
EXEC sp_add_or_update_locker_rented 3, '2017-07-15 21:00:00', '2017-07-15 22:00:00', 2, 1
EXEC sp_add_or_update_locker_rented 3, '2017-07-15 00:00:00', '2017-07-15 21:30:00', 1, 0
ROLLBACK TRAN