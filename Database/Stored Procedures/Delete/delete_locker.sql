/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Delete LOCKER								*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_locker
GO
CREATE PROCEDURE sp_delete_locker
	@locker_number INT
AS
BEGIN
	BEGIN TRY

		IF NOT EXISTS (SELECT *
					   FROM LOCKER
				       WHERE locker_number = @locker_number)
			BEGIN
				;THROW 50000, 'This locker does not exist', 1
			END

		DELETE FROM LOCKER WHERE locker_number = @locker_number

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- TEST
BEGIN TRAN
EXEC sp_delete_locker 1
ROLLBACK TRAN
GO

-- TEST (does not exist)
BEGIN TRAN
EXEC sp_delete_locker 1000
ROLLBACK TRAN
GO