/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version 6												*/	
/* Robert Verkerk												*/
/* Last edited: 20-12-2017										*/
/* Procedure: Insert + Update locker							*/
/*==============================================================*/
USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_add_or_update_locker
GO
CREATE PROCEDURE sp_add_or_update_locker
	@insert BIT,
	@locker_number INT = NULL,
	@festival_company_number INT
AS
BEGIN
	BEGIN TRY
		-- Inser or update start
		IF (@insert = 1)
		BEGIN
			INSERT INTO LOCKER (festival_company_number) VALUES (@festival_company_number)
			-- insert code
		END
		ELSE 
		BEGIN
			IF (@locker_number IS null)
			BEGIN
				;THROW 50000, '@locker_number cannot be NULL if an update is to be commerced.', 1
			END
			ELSE IF EXISTS (SELECT * FROM locker WHERE locker_number = @locker_number)
			BEGIN
				;THROW 50000, 'This locker does not exist', 1
			END
			UPDATE LOCKER SET festival_company_number = @festival_company_number WHERE locker_number = @locker_number
			-- update code
		END

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* add new locker */
BEGIN TRAN
EXEC sp_add_or_update_locker 1, NULL, 8
ROLLBACK TRAN
GO

/* add locker, wrong company */
BEGIN TRAN
EXEC sp_add_or_update_locker 1, NULL, 999
ROLLBACK TRAN
GO

/*update locker*/
BEGIN TRAN
EXEC sp_add_or_update_locker 0, 15, 7
ROLLBACK TRAN
GO

/*update locker NULL*/
BEGIN TRAN
EXEC sp_add_or_update_locker 0, NULL, 8
ROLLBACK TRAN
GO

/* update locker locker does not exists */
BEGIN TRAN
EXEC sp_add_or_update_locker 0, 9999, 8
ROLLBACK TRAN
GO