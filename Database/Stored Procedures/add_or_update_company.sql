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
	@name				VARCHAR(50),
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
				IF NOT EXISTS (SELECT *
							   FROM company
							   WHERE coc_number = @coc_number)
					BEGIN
						;THROW 50000, 'This visitor does not exist', 1
					END

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

-- Test INSERT
BEGIN TRAN
EXEC sp_add_or_update_company 23456080, 'Hans Hamburgers', 1
ROLLBACK TRAN
GO

-- Test UPDATE
BEGIN TRAN
EXEC sp_add_or_update_company 23456001, 'Hans Hamburgers', 0
ROLLBACK TRAN
GO

-- Test UPDATE (PK does not exist)
BEGIN TRAN
EXEC sp_add_or_update_company 23456090, 'Hans Hamburgers', 0
ROLLBACK TRAN
GO