/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		18-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Insert + Update COMPANY						*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure to add or update a COMPANY
*/
DROP PROC IF EXISTS sp_add_or_update_company;
GO
CREATE PROC sp_add_or_update_company
	@coc_number			INT,
	@name				INT,
	@insert				BIT
AS
BEGIN
	BEGIN TRY
		/* IF @insert = 1, THEN INSERT.		IF @insert = 0, THEN UPDATE */
		IF (@insert = 1)
			BEGIN
				/* INSERT */
				INSERT INTO COMPANY (coc_number, name) VALUES
				(@coc_number,
				 @name)
			END
		ELSE
			BEGIN
				/* UPDATE */
				UPDATE COMPANY SET 
				name = @name
				WHERE coc_number = @coc_number
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO