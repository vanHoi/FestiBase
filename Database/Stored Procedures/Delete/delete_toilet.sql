/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Delete TOILET								*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_toilet
GO
CREATE PROCEDURE sp_delete_toilet
	@toilet_number INT
AS
BEGIN
	BEGIN TRY

		IF NOT EXISTS (SELECT *
					   FROM TOILET
				       WHERE toilet_number = @toilet_number)
			BEGIN
				;THROW 50000, 'This record does not exist', 1
			END

		DELETE FROM TOILET WHERE toilet_number = @toilet_number

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- TEST
BEGIN TRAN
EXEC sp_delete_toilet 1
ROLLBACK TRAN
GO

-- TEST (does not exist)
BEGIN TRAN
EXEC sp_delete_toilet 1000
ROLLBACK TRAN
GO