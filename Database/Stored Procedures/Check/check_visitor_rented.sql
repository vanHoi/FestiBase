/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last Edited:		19-12-2017									*/
/* Edited by:		Robert Verkerk								*/	
/* Procedure:		Check visitor rented						*/
/*==============================================================*/

USE FestiBase
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