﻿/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Delete COUNTRY								*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_country
GO
CREATE PROCEDURE sp_delete_country
	@country_number INT
AS
BEGIN
	BEGIN TRY

		IF NOT EXISTS (SELECT *
					   FROM COUNTRY
				       WHERE country_number = @country_number)
			BEGIN
				;THROW 50000, 'This country does not exist', 1
			END

		DELETE FROM COUNTRY WHERE country_number = @country_number

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* TEST (will trigger foreign key constraint) */
BEGIN TRAN
EXEC sp_delete_country 1
ROLLBACK TRAN
GO

-- TEST (does not exist)
BEGIN TRAN
EXEC sp_delete_country 1000
ROLLBACK TRAN
GO