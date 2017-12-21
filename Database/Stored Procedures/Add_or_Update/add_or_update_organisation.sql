/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		21-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Insert + Update ORGANISATION				*/
/*==============================================================*/
USE FestiBase
GO


DROP PROCEDURE IF EXISTS sp_add_or_update_organisation
GO
CREATE PROCEDURE sp_add_or_update_organisation
	@organisation_number INT = NULL,
	@name VARCHAR(50),
	@insert BIT
AS
BEGIN
	BEGIN TRY
		IF (@insert = 1)
		BEGIN
			INSERT INTO ORGANISATION (name) VALUES (@name)
		END
		ELSE 
		BEGIN
			IF (@organisation_number IS NULL OR @organisation_number = 0)
			BEGIN
				;THROW 50000, '@organisation_number cannot be NULL if an UPDATE is to be commenced.', 1
			END
			IF NOT EXISTS (SELECT 1 FROM ORGANISATION WHERE organisation_number = @organisation_number)
			BEGIN
				;THROW 50001, 'This organisation does not exist.', 1
			END
			UPDATE ORGANISATION set name = @name WHERE organisation_number = @organisation_number
		END

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/*insert*/
BEGIN TRAN
EXEC sp_add_or_update_organisation NULL, 'org1', 1
ROLLBACK TRAN
GO

/*update*/
BEGIN TRAN
EXEC sp_add_or_update_organisation 3, 'org2', 0
ROLLBACK TRAN
GO

/* update, org doesn't exist */
BEGIN TRAN
EXEC sp_add_or_update_organisation 5, 'org2', 0
ROLLBACK TRAN
GO

/*update, org is null*/
BEGIN TRAN
EXEC sp_add_or_update_organisation NULL, 'org2', 0
ROLLBACK TRAN
GO