﻿/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Delete CATERING								*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_catering
GO
CREATE PROCEDURE sp_delete_catering
	@catering_number INT
AS
BEGIN
	BEGIN TRY

		IF NOT EXISTS (SELECT *
					   FROM CATERING
				       WHERE catering_number = @catering_number)
			BEGIN
				;THROW 50000, 'This record does not exist', 1
			END

		DELETE FROM CATERING WHERE catering_number = @catering_number

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- TEST
BEGIN TRAN
EXEC sp_delete_catering 1
ROLLBACK TRAN
GO

-- TEST (does not exist)
BEGIN TRAN
EXEC sp_delete_catering 1000
ROLLBACK TRAN
GO