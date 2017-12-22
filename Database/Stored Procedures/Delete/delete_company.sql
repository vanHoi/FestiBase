/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Delete COMPANY								*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_company
GO
CREATE PROCEDURE sp_delete_company
	@coc_number INT
AS
BEGIN
	BEGIN TRY

		IF NOT EXISTS (SELECT *
					   FROM COMPANY
				       WHERE coc_number = @coc_number)
			BEGIN
				;THROW 50000, 'This record does not exist', 1
			END

		DELETE FROM COMPANY WHERE coc_number = @coc_number

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- TEST
BEGIN TRAN
EXEC sp_delete_company 23456003
ROLLBACK TRAN
GO

-- TEST (does not exist)
BEGIN TRAN
EXEC sp_delete_company 1000
ROLLBACK TRAN
GO