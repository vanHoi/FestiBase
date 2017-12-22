/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Delete bought_ticket			*/
/*==============================================================*/
USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_bought_ticket
GO
CREATE PROCEDURE sp_delete_bought_ticket
	@ticket_number INT
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT *
				   FROM BOUGHT_TICKET
				   WHERE ticket_number = @ticket_number)
			BEGIN
				;THROW 50000, 'This ticket does not exist', 1
			END

		DELETE FROM BOUGHT_TICKET WHERE ticket_number = @ticket_number
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* tests */
/* delete success */
BEGIN TRAN
EXEC sp_delete_bought_ticket 1
ROLLBACK TRAN
GO

/* delete */
BEGIN TRAN
EXEC sp_delete_bought_ticket 55
ROLLBACK TRAN
GO
