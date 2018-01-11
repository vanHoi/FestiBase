/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		7											*/
/* Last edited:		11-01-2018									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Check if exists town with visitor			*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete
GO
CREATE PROCEDURE sp_delete
	@surrogate_key INT
AS
BEGIN
	BEGIN TRY

		IF NOT EXISTS (SELECT *
					   FROM tabel
				       WHERE kolom = @surrogate_key)
			BEGIN
				;THROW 50000, 'This record does not exist', 1
			END

		DELETE FROM tabel WHERE kolom = @surrogate_key

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- TEST
BEGIN TRAN
EXEC sp_delete 1
ROLLBACK TRAN
GO

-- TEST (does not exist)
BEGIN TRAN
EXEC sp_delete 1000
ROLLBACK TRAN
GO