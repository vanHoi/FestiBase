/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Delete ticket_type							*/
/*==============================================================*/
USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_ticket_type
GO
CREATE PROCEDURE sp_delete_ticket_type
	@festival_company_number INT,
	@ticket_type varchar(50)
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT *
				   FROM TICKET_TYPE
				   WHERE festival_company_number = @festival_company_number
				   AND ticket_type = @ticket_type)
			BEGIN
				;THROW 50000, 'This visitor did not visit this performance does not exist', 1
			END

		DELETE FROM TICKET_TYPE WHERE festival_company_number = @festival_company_number AND ticket_type = @ticket_type
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* tests */
/* delete success */
BEGIN TRAN
EXEC sp_delete_ticket_type 10, 'dagticket'
ROLLBACK TRAN
GO

/* delete */
BEGIN TRAN
EXEC sp_delete_ticket_type 55, 'dagticket'
ROLLBACK TRAN
GO
