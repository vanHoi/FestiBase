/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		21-12-2017									*/
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
		IF (@insert = 1)
			BEGIN
				INSERT INTO COMPANY (coc_number, name) VALUES
				(@coc_number,
				 @name)
			END
		ELSE
			BEGIN
				IF (@coc_number IS NULL OR @coc_number = 0)
					BEGIN
						;THROW 50000, '@coc_number cannot be NULL if an UPDATE is to be commenced', 1
					END
				ELSE IF NOT EXISTS (SELECT *
							   FROM company
							   WHERE coc_number = @coc_number)
					BEGIN
						;THROW 50000, 'This company does not exist', 1
					END

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

-- Test UPDATE (SK NULL)
BEGIN TRAN
EXEC sp_add_or_update_company NULL, 'Hans Hamburgers', 0
ROLLBACK TRAN
GO

BEGIN TRAN
EXEC sp_add_or_update_company 0, 'Hans Hamburgers', 0
ROLLBACK TRAN
GO
