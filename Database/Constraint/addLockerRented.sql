/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version 4												*/	
/* Templates													*/
/*==============================================================*/

USE master
GO

USE FestiBase
GO

DROP PROC IF EXISTS addLockerRented
GO

CREATE PROCEDURE addLockerRented
	@locker_number int, --PK
	@start_date datetime, --PK
	@end_date datetime,
	@visitor_number int,
	@insert bit,
	@new_start_date datetime = NULL -- must be used for a new start date
AS
BEGIN
	BEGIN TRY
		DECLARE @start_date_to_check datetime

		IF (@locker_number IS NOT NULL)
		BEGIN
			SELECT @start_date_to_check = @start_date

			IF (@new_start_date IS NOT NULL)
			BEGIN
				SELECT @start_date_to_check = @new_start_date
			END

			/*check if startdate is na startdate van festival*/
			IF (@start_date_to_check < (SELECT start_date FROM FESTIVAL WHERE festival_number = (SELECT festival_number FROM LOCKER WHERE locker_number = @locker_number)))
			BEGIN	
				;THROW 50000, 'The startdate must be after the startdate of a festival', 1
			END
			/*check if enddate is voor endate van festival*/
			IF (@end_date > (SELECT end_date FROM FESTIVAL WHERE festival_number = (SELECT festival_number FROM LOCKER WHERE locker_number = @locker_number)))
			BEGIN	
				;THROW 50001, 'The enddate must be before the enddate of a festival', 1	
			END
		END

		IF EXISTS (	SELECT 1
					FROM LOCKER_RENTED
					WHERE locker_number = @locker_number
					AND visitor_number != @visitor_number
					AND (( @start_date_to_check BETWEEN start_date AND end_date ) OR
						( @end_date	BETWEEN start_date AND end_date ) ) )
		BEGIN
			;THROW 50002, 'This locker is already rented at the given start or end date.', 1
		END

		IF (@insert = 1)
		BEGIN
			IF EXISTS (	SELECT 1
			FROM LOCKER_RENTED
			WHERE locker_number = @locker_number
			--AND visitor_number != @visitor_number
			AND (( @start_date_to_check BETWEEN start_date AND end_date ) OR
				( @end_date	BETWEEN start_date AND end_date ) ) )
			BEGIN
				;THROW 50002, 'This locker is already rented at the given start or end date.', 1
			END
			INSERT INTO LOCKER_RENTED VALUES (@locker_number, @start_date_to_check, @end_date, @visitor_number)
		END
		ELSE
		BEGIN
			IF EXISTS (	SELECT 1
			FROM LOCKER_RENTED
			WHERE locker_number = @locker_number
			AND visitor_number != @visitor_number
			AND (( @start_date_to_check BETWEEN start_date AND end_date ) OR
				( @end_date	BETWEEN start_date AND end_date ) ) )
			BEGIN
				;THROW 50003, 'This locker is already rented at the given start or end date.', 1
			END

			IF (@locker_number IS NULL AND @start_date IS NULL)
			BEGIN
				;THROW 50004, 'You must supply the full key(locker_number and start_date with an update statement.', 1
			END
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
EXEC addLockerRented 3, '2017-07-15 00:00:00', '2017-07-18 00:00:00',  1, 1
ROLLBACK TRAN

/* startdate after startdate festival */
BEGIN TRAN
EXEC addLockerRented 3, '2017-07-14 00:00:00',  '2017-07-17 00:00:00', 1, 1
ROLLBACK TRAN

/* correct */
BEGIN TRAN
EXEC addLockerRented 3, '2017-07-15 00:00:00', '2017-07-15 20:00:00',  1, 1
ROLLBACK TRAN

/* new locker already rented */
BEGIN TRAN
EXEC addLockerRented 3, '2017-07-15 19:00:00', '2017-07-16 20:00:00', 2, 1
ROLLBACK TRAN
delete from LOCKER_RENTED where locker_number = 3 and start_date = '2017-07-15 19:00:00'

/* update locker */
BEGIN TRAN
EXEC addLockerRented 3, '2017-07-15 00:00:00', '2017-07-15 15:00:00', 1, 0
ROLLBACK TRAN

/* add locker then update locker */
BEGIN TRAN
EXEC addLockerRented 3, '2017-07-15 21:00:00', '2017-07-15 22:00:00', 2, 1
EXEC addLockerRented 3, '2017-07-15 21:00:00', '2017-07-16 15:00:00', 2, 0, '2017-07-15 22:00:00'
ROLLBACK TRAN

/* add locker update locker fail */
BEGIN TRAN
EXEC addLockerRented 3, '2017-07-15 21:00:00', '2017-07-15 22:00:00', 2, 1
EXEC addLockerRented 3, '2017-07-15 00:00:00', '2017-07-15 21:30:00', 1, 0
ROLLBACK TRAN