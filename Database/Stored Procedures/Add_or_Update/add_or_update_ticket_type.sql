/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		08-01-2018									*/
/* Edited by:		Mariusz Blautzik							*/
/* Procedure:		Insert + Update TICKET_TYPE					*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure to add or update a TICKET_TYPE
*/
DROP PROC IF EXISTS sp_add_or_update_ticket_type
GO
CREATE PROC sp_add_or_update_ticket_type
	@festival_company_number	INT,
	@ticket_type				VARCHAR(50),
	@price						MONEY,
	@date_valid_from			DATETIME,
	@date_valid_to				DATETIME = NULL,
	@insert						BIT
AS
BEGIN
	BEGIN TRY
		
		IF (@insert = 1)

			BEGIN

				EXEC sp_check_ticket_type_start_end_date 
				@festival_company_number, 
				@date_valid_from, 
				@date_valid_to

				INSERT INTO TICKET_TYPE (festival_company_number, ticket_type, price, date_valid_from, date_valid_to) VALUES
				(@festival_company_number,
				 @ticket_type,
				 @price,
				 @date_valid_from,
				 @date_valid_to
				 )
			END
		ELSE
			BEGIN
				IF (@festival_company_number IS NULL OR @festival_company_number = 0)
					BEGIN
						;THROW 50000, '@festival_company_number cannot be NULL or ZERO if an update is to be commenced', 1
					END
				
				ELSE IF NOT EXISTS (SELECT *
									FROM TICKET_TYPE
									WHERE festival_company_number = @festival_company_number
									AND ticket_type = @ticket_type)
					BEGIN
						;THROW 50000, 'This ticket_type does not exist', 1
					END

				EXEC sp_check_ticket_type_start_end_date 
				@festival_company_number, 
				@date_valid_from, 
				@date_valid_to

				UPDATE TICKET_TYPE SET 
				ticket_type = @ticket_type,
				price = @price,
				date_valid_from = @date_valid_from,
				date_valid_to = @date_valid_to
				WHERE festival_company_number = @festival_company_number AND ticket_type = @ticket_type
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- INSERT SUCCESSFUL
BEGIN TRAN
EXEC sp_add_or_update_ticket_type 13, 'Ultra Weekend Ticket Super Edition', 5000, '2018-03-30 00:00:01', '2018-04-01 23:59:00', 1
ROLLBACK TRAN
GO

-- UPDATE SUCCESSFUL
BEGIN TRAN
<<<<<<< HEAD
EXEC sp_add_or_update_ticket_type 13, 'Dagticket Vrijdag', 200, '2018-03-30 00:00:01', '2018-04-01 23:59:00', 0
ROLLBACK TRAN
GO

-- INSERT FAILED (dates doesn't match with the festival)
BEGIN TRAN
EXEC sp_add_or_update_ticket_type 13, 'Ultra Weekend Ticket Super Edition', 5000, '2017-03-30 00:00:01', '2017-04-01 23:59:00', 1
ROLLBACK TRAN
GO

-- INSERT FAILED (startdate before enddate, so start date doesn't match)
BEGIN TRAN
EXEC sp_add_or_update_ticket_type 1, 'Ultra Weekend Ticket Super Edition', 5000, '2018-03-30 13:59:00', '2018-03-30 12:00:01', 1
ROLLBACK TRAN
GO

-- INSERT FAILED (fesival_company doesn't exist, so start date doesn't match)
BEGIN TRAN
EXEC sp_add_or_update_ticket_type 999, 'Ultra Weekend Ticket Super Edition', 5000, '2018-03-30 00:00:01', '2018-04-01 23:59:00', 1
=======
EXEC sp_add_or_update_ticket_type 13, 'Dagticket', 200, '2018-03-30 00:00:01', '2018-04-01 23:59:00', 0
ROLLBACK TRAN
GO

-- INSERT FAILED (dates doesn't match with the festival)
BEGIN TRAN
EXEC sp_add_or_update_ticket_type 13, 'Ultra Weekend Ticket Super Edition', 5000, '2017-03-30 00:00:01', '2017-04-01 23:59:00', 1
ROLLBACK TRAN
GO

-- INSERT FAILED (startdate before enddate, so start date doesn't match)
BEGIN TRAN
EXEC sp_add_or_update_ticket_type 13, 'Ultra Weekend Ticket Super Edition', 5000, '2018-03-30 13:59:00', '2018-03-30 12:00:01', 1
>>>>>>> parent of beb7978... Revert "Merge branch 'test-fixes' of https://github.com/vanHoi/FestiBase into test-fixes"
ROLLBACK TRAN
GO

-- UPDATE FAILED (Ticket Type does not exist)
BEGIN TRAN
EXEC sp_add_or_update_ticket_type 13, 'PowerTicket', 90, '2018-03-30 00:00:01', '2018-04-01 23:59:00', 0
ROLLBACK TRAN
GO

-- UPDATE FAILED (Festival company number cannot be NULL)
BEGIN TRAN
EXEC sp_add_or_update_ticket_type NULL, 'Dagticket Vrijdag', 200, '2018-03-30 00:00:01', '2018-04-01 23:59:00', 0
ROLLBACK TRAN
<<<<<<< HEAD
GO
=======
GO
>>>>>>> parent of beb7978... Revert "Merge branch 'test-fixes' of https://github.com/vanHoi/FestiBase into test-fixes"
