/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		18/12/2017									*/
/* Author:			Leon Chen									*/
/* Constraint													*/
/*==============================================================*/

/*
Leon Chen
Procedure to add a new ticket_type to the database
Constraint:	6
*/


DROP PROCEDURE if exists sp_add_ticket_type
GO
CREATE PROCEDURE sp_add_ticket_type
@festival_company_number INT,
@ticket_type VARCHAR(50),
@price money,
@date_valid_from DATETIME,
@date_valid_to DATETIME
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF(
			NOT EXISTS(
				SELECT * FROM Festival f
				INNER JOIN FESTIVAL_COMPANY fc ON f.festival_number = fc.festival_number
				WHERE fc.festival_company_number = @festival_company_number AND
				@date_valid_from BETWEEN start_date AND end_date AND
				@date_valid_to BETWEEN start_date AND end_date
			)
		)
		BEGIN
			;THROW 50001, 'The valid dates of the ticket are not between the start and enddate of the festival.', 1
		END

		INSERT INTO TICKET_TYPE VALUES (@festival_company_number, @ticket_type, @price, @date_valid_from, @date_valid_to)
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

--Tests
--Execute this first
SET DATEFORMAT DMY
GO

--date_valid_from is too early
BEGIN TRAN
EXEC sp_add_ticket_type 10, 'Super ticket', 500.00, '13-04-2017 23:30:00', '16-04-2017 23:50:00'
ROLLBACK TRAN

--date_valid_to is too late
BEGIN TRAN
EXEC sp_add_ticket_type 10, 'Super ticket', 500.00, '14-04-2017 02:00:00', '16-04-2017 23:59:30'
ROLLBACK TRAN

--Works, Date is exactly on the start and end-date of the festival
BEGIN TRAN
EXEC sp_add_ticket_type 10, 'Super ticket', 500.00, '14-04-2017 00:00:00', '16-04-2017 23:59:00'
ROLLBACK TRAN

--Works
BEGIN TRAN
EXEC sp_add_ticket_type 10, 'Superkoele ticket', 500.00, '14-04-2017 08:00:00', '16-04-2017 23:00:00'
ROLLBACK TRAN