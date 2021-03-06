﻿/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Delete TABEL								*/
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