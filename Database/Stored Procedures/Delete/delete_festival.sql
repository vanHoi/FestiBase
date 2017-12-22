/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Delete Festival		 						*/
/*==============================================================*/
USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_festival
GO
CREATE PROCEDURE sp_delete_festival
	@festival_number INT
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT *
				   FROM FESTIVAL
				   WHERE festival_number = @festival_number)
			BEGIN
				;THROW 50000, 'This festival does not exist', 1
			END

		DELETE FROM FESTIVAL WHERE festival_number = @festival_number
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* tests */
/* delete success */
BEGIN TRAN
EXEC sp_delete_festival 4
ROLLBACK TRAN
GO

/* delete genre doesn't exist */
BEGIN TRAN
EXEC sp_delete_festival 55
ROLLBACK TRAN
GO