/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Delete VISITOR								*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_visitor
GO
CREATE PROCEDURE sp_delete_visitor
	@visitor_number INT
AS
BEGIN
	BEGIN TRY

		IF NOT EXISTS (SELECT *
					   FROM VISITOR
				       WHERE visitor_number = @visitor_number)
			BEGIN
				;THROW 50000, 'This visitor does not exist', 1
			END

		DELETE FROM VISITOR WHERE visitor_number = @visitor_number

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- TEST
BEGIN TRAN
EXEC sp_delete_visitor 1
ROLLBACK TRAN
GO

-- TEST (does not exist)
BEGIN TRAN
EXEC sp_delete_visitor 1000
ROLLBACK TRAN
GO