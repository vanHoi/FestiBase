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
									WHERE festival_company_number = @festival_company_number)
					BEGIN
						;THROW 50000, 'This ticket_type does not exist', 1
					END

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

select * from FESTIVAL_COMPANY

Select * from TICKET_TYPE

-- INSERT SUCCESSFUL
BEGIN TRAN
EXEC sp_add_or_update_ticket_type 10, 'Ultra Weekend Ticket', 5000, '2018-07-20 10:00:00', '2018-07-23 23:00:00', 1
ROLLBACK TRAN
GO

-- INSERT SUCCESSFUL
BEGIN TRAN
EXEC sp_add_or_update_ticket_type 10, 'VIP 2018', 290, '2018-05-20 10:00:00', '2018-05-23 23:30:00', 1 
ROLLBACK TRAN
GO

-- UPDATE SUCCESSFUL
BEGIN TRAN
EXEC sp_add_or_update_ticket_type 10, 'VIP', 175, '2014-04-14 00:00:00', '2014-04-16 23:59:00', 0
ROLLBACK TRAN
GO

-- UPDATE FAILED (Ticket Type does not exist)
BEGIN TRAN
EXEC sp_add_or_update_ticket_type 5, 'PowerTicket', 90, '2015-05-20 09:00:00', '2015-05-23 23:59:00', 0
ROLLBACK TRAN
GO

-- UPDATE FAILED (Festival company number cannot be NULL)
BEGIN TRAN
EXEC sp_add_or_update_ticket_type NULL, 'Weekend BackstagePass', 50, '2018-03-20 09:00:00', '2018-03-23 23:59:00', 0
ROLLBACK TRAN
GO

-- UPDATE FAILED (Festival company number cannot be ZERO)
BEGIN TRAN
EXEC sp_add_or_update_ticket_type 0, 'Zondag Ticket', 25, '2018-08-10 11:00:00', NULL, 0
ROLLBACK TRAN
GO