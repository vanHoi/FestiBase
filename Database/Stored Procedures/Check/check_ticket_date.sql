/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		19-12-2017									*/
/* Edited by:		Leon Chen									*/
/* Constraint:		Check ticket dates							*/
/*==============================================================*/

/*
	This procedures checks the following:
	-	If the ticket date is between its festival dates
*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_check_ticket_type_start_end_date
GO
CREATE PROCEDURE sp_check_ticket_type_start_end_date
@festival_company_number INT,
@date_valid_from DATETIME,
@date_valid_to DATETIME
AS
BEGIN
	BEGIN TRY
		IF(
			NOT EXISTS(
				SELECT * FROM Festival f
				INNER JOIN FESTIVAL_COMPANY fc ON f.festival_number = fc.festival_number
				WHERE fc.festival_company_number = @festival_company_number AND
				@date_valid_from BETWEEN start_date AND end_date 
			)
		)
		BEGIN
			;THROW 50002, 'The start date of the ticket is not between the start and end date of the festival.', 1
		END

		IF(
			NOT EXISTS(
				SELECT * FROM Festival f
				INNER JOIN FESTIVAL_COMPANY fc ON f.festival_number = fc.festival_number
				WHERE fc.festival_company_number = @festival_company_number AND
				@date_valid_to BETWEEN start_date AND end_date
			)
		)
		BEGIN
			;THROW 50003, 'The end date of the ticket is not between the start and end date of the festival.', 1
		END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO