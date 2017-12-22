/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Delete FESTIVAL_COMPANY						*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_festival_company
GO
CREATE PROCEDURE sp_delete_festival_company
	@festival_company_number INT
AS
BEGIN
	BEGIN TRY

		IF NOT EXISTS (SELECT *
					   FROM FESTIVAL_COMPANY
				       WHERE festival_company_number = @festival_company_number)
			BEGIN
				;THROW 50000, 'This festival company does not exist', 1
			END

		DELETE FROM FESTIVAL_COMPANY WHERE festival_company_number = @festival_company_number
			

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- TEST
BEGIN TRAN
EXEC sp_delete_festival_company 1
ROLLBACK TRAN
GO

-- TEST (does not exist)
BEGIN TRAN
EXEC sp_delete_festival_company 1000
ROLLBACK TRAN
GO