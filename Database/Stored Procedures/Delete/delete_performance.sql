/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Delete Performance	 						*/
/*==============================================================*/
USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_performance
GO
CREATE PROCEDURE sp_delete_performance
	@performance_number INT
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT *
				   FROM PERFORMANCE
				   WHERE performance_number = @performance_number)
			BEGIN
				;THROW 50000, 'This performance does not exist', 1
			END

		DELETE FROM PERFORMANCE WHERE performance_number = @performance_number
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* tests */
/* delete success */
BEGIN TRAN
EXEC sp_delete_performance 11
ROLLBACK TRAN
GO

/* delete fail */
BEGIN TRAN
EXEC sp_delete_performance 55
ROLLBACK TRAN
GO