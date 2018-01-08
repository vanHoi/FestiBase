/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		08-01-2018									*/
/* Edited by:		Mariusz Blautzik							*/
/* Procedure:		Insert + Update BOUGHT_TICKET				*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure to add or update a BOUGHT_TICKET
*/
DROP PROC IF EXISTS sp_add_or_update_bought_ticket
GO
CREATE PROC sp_add_or_update_bought_ticket
	@ticket_number				INT = NULL,
	@festival_company_number	INT,
	@ticket_type				VARCHAR(50),
	@visitor_number				INT,
	@scan_date					DATETIME = NULL,
	@insert						BIT
AS
BEGIN
	BEGIN TRY
		IF (@insert = 1)
			BEGIN
				INSERT INTO BOUGHT_TICKET(festival_company_number, ticket_type, visitor_number, scan_date) VALUES
				(@festival_company_number,
				 @ticket_type,
				 @visitor_number,
				 @scan_date
				 )
			END
		ELSE
			BEGIN
				IF (@ticket_number IS NULL OR @ticket_number = 0)
					BEGIN
						;THROW 50000, 'ticket_number cannot be NULL or ZERO if an update is to be commenced', 1
					END
				
				ELSE IF NOT EXISTS (SELECT *
									FROM BOUGHT_TICKET
									WHERE ticket_number = @ticket_number)
					BEGIN
						;THROW 50000, 'This ticket_number does not exist', 1
					END

				UPDATE BOUGHT_TICKET SET 
				festival_company_number = @festival_company_number,
				ticket_type = @ticket_type,
				visitor_number = @visitor_number,
				scan_date = @scan_date
				WHERE ticket_number = @ticket_number
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- INSERT SUCCESSFUL
BEGIN TRAN
EXEC sp_add_or_update_bought_ticket  NULL, 10, 'dagticket', 2, '2018-06-01 15:05:20', 1       
ROLLBACK TRAN
GO

-- INSERT SUCCESSFUL
BEGIN TRAN
EXEC sp_add_or_update_bought_ticket  NULL, 10, 'VIP', 3, '2018-07-11 09:45:20', 1       
ROLLBACK TRAN
GO

-- UPDATE SUCCESSFUL
BEGIN TRAN
EXEC sp_add_or_update_bought_ticket  2, 10, 'dagticket', 1, '2018-01-08 19:24:38', 0       
ROLLBACK TRAN
GO

-- UPDATE FAILED (Ticket Number does not exist)
BEGIN TRAN
EXEC sp_add_or_update_bought_ticket  90, 10, 'dagticket', 1, '2018-01-08 19:24:38', 0       
ROLLBACK TRAN
GO

-- UPDATE FAILED (Ticket Number does not exist)
BEGIN TRAN
EXEC sp_add_or_update_bought_ticket  '100', 10, 'dagticket', 1, '2018-01-08 19:24:38', 0       
ROLLBACK TRAN
GO

-- UPDATE FAILED (Festival company number cannot be NULL)
BEGIN TRAN
EXEC sp_add_or_update_bought_ticket  NULL, 10, 'dagticket', 1, '2018-01-08 19:24:38', 0       
ROLLBACK TRAN
GO

-- UPDATE FAILED (Festival company number cannot be ZERO)
BEGIN TRAN
EXEC sp_add_or_update_bought_ticket  0, 10, 'VIP', 3, '2018-01-08 19:24:38', 0    
ROLLBACK TRAN
GO