/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Delete Organisation	 						*/
/*==============================================================*/
USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_organisation
GO
CREATE PROCEDURE sp_delete_organisation
	@organisation_number INT
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT *
				   FROM ORGANISATION
				   WHERE organisation_number = @organisation_number)
			BEGIN
				;THROW 50000, 'This organisation does not exist', 1
			END

		DELETE FROM ORGANISATION WHERE organisation_number = @organisation_number
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* tests */
/* delete success */
BEGIN TRAN
EXEC sp_delete_organisation 3
ROLLBACK TRAN
GO

/* delete fail */
BEGIN TRAN
EXEC sp_delete_organisation 55
ROLLBACK TRAN
GO