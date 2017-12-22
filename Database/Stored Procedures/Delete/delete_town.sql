/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Delete TOWN									*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_town
GO
CREATE PROCEDURE sp_delete_town
	@town_number INT
AS
BEGIN
	BEGIN TRY

		IF NOT EXISTS (SELECT *
					   FROM TOWN
					   WHERE town_number = @town_number)
			BEGIN
				;THROW 50000, 'This record does not exist', 1
			END

		DELETE FROM TOWN WHERE town_number = @town_number

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* TEST (will trigger foreign key constraint) */
BEGIN TRAN
EXEC sp_delete_town 1
ROLLBACK TRAN
GO