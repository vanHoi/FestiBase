/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/	
/* Last edited:		20-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Insert + Update locker						*/
/*==============================================================*/
USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_add_or_update_locker
GO
CREATE PROCEDURE sp_add_or_update_locker
	@locker_number				INT = NULL,
	@festival_company_number	INT,
	@insert						BIT
AS
BEGIN
	BEGIN TRY
		IF (@insert = 1)
		BEGIN
			INSERT INTO LOCKER (festival_company_number) VALUES 
			(@festival_company_number)
		END
		ELSE 
		BEGIN
			IF (@locker_number IS null OR @locker_number = 0)
			BEGIN
				;THROW 50000, '@locker_number cannot be NULL if an update is to be commerced.', 1
			END
			ELSE IF NOT EXISTS (SELECT * FROM locker WHERE locker_number = @locker_number)
			BEGIN
				;THROW 50000, 'This locker does not exist', 1
			END

			UPDATE LOCKER SET 
			festival_company_number = @festival_company_number 
			WHERE locker_number = @locker_number
		END

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* insert */
BEGIN TRAN
EXEC sp_add_or_update_locker NULL, 10, 1
ROLLBACK TRAN
GO

/* insert failed - wrong company */
BEGIN TRAN
EXEC sp_add_or_update_locker NULL, 999, 1
ROLLBACK TRAN
GO

/* update */
BEGIN TRAN
EXEC sp_add_or_update_locker 2, 10, 0
ROLLBACK TRAN
GO

/* update failed - locker_number can't be NULL */
BEGIN TRAN
EXEC sp_add_or_update_locker NULL, 10, 0
ROLLBACK TRAN
GO

/* update failed - festival_company_number can't be NULL */
BEGIN TRAN
EXEC sp_add_or_update_locker 2, NULL, 0
ROLLBACK TRAN
GO

/* update failed - locker doesn't exists */
BEGIN TRAN
EXEC sp_add_or_update_locker 9999, 10, 0
ROLLBACK TRAN
GO
