/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Delete podium		 						*/
/*==============================================================*/
USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_podium
GO
CREATE PROCEDURE sp_delete_podium
	@podium_number INT
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT *
				   FROM PODIUM
				   WHERE podium_number = @podium_number)
			BEGIN
				;THROW 50000, 'This podium  does not exist', 1
			END

		DELETE FROM PODIUM WHERE podium_number = @podium_number
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* tests */
/* delete*/
BEGIN TRAN
EXEC sp_delete_podium 1
ROLLBACK TRAN
GO

/* delete genre doesn't exist */
BEGIN TRAN
EXEC sp_delete_podium 55
ROLLBACK TRAN
GO