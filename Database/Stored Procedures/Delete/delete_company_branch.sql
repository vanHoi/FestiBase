/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Delete COMPANY_BRANCH						*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_company_branch
GO
CREATE PROCEDURE sp_delete_company_branch
	@branch_number INT
AS
BEGIN
	BEGIN TRY

		IF NOT EXISTS (SELECT *
					   FROM COMPANY_BRANCH
				       WHERE branch_number = @branch_number)
			BEGIN
				;THROW 50000, 'This company branch does not exist', 1
			END

		DELETE FROM COMPANY_BRANCH WHERE branch_number = @branch_number

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- TEST
BEGIN TRAN
EXEC sp_delete_company_branch 1
ROLLBACK TRAN
GO

-- TEST (does not exist)
BEGIN TRAN
EXEC sp_delete_company_branch 1000
ROLLBACK TRAN
GO