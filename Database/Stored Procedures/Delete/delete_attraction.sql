/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Delete ATTRACTION							*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_attraction
GO
CREATE PROCEDURE sp_delete_attraction
	@attraction_number INT
AS
BEGIN
	BEGIN TRY

		IF NOT EXISTS (SELECT *
					   FROM ATTRACTION
				       WHERE attraction_number = @attraction_number)
			BEGIN
				;THROW 50000, 'This attraction does not exist', 1
			END

		DELETE FROM ATTRACTION WHERE attraction_number = @attraction_number

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- TEST
BEGIN TRAN
EXEC sp_delete_attraction 1
ROLLBACK TRAN
GO

-- TEST (does not exist)
BEGIN TRAN
EXEC sp_delete_attraction 1000
ROLLBACK TRAN
GO