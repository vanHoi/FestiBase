/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last Edited:		19-12-2017									*/
/* Edited by:		Robert Verkerk								*/	
/* Procedure:		Check locker dates							*/
/*==============================================================*/

USE FestiBase
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
		IF (@start_date < (SELECT start_date FROM FESTIVAL WHERE festival_number = (SELECT festival_number FROM FESTIVAL_COMPANY WHERE festival_company_number  = (SELECT festival_company_number FROM LOCKER WHERE locker_number = @locker_number))))
		BEGIN	
			;THROW 50000, 'The startdate must be after the startdate of a festival', 1
		END
		/*check if enddate is voor endate van festival*/
		IF (@end_date > (SELECT end_date FROM FESTIVAL WHERE festival_number = (SELECT festival_number FROM FESTIVAL_COMPANY WHERE festival_company_number  = (SELECT festival_company_number FROM LOCKER WHERE locker_number = @locker_number))))
		BEGIN	
			;THROW 50001, 'The enddate must be before the enddate of a festival', 1	
		END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO