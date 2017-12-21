/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		18-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Insert + Update COMPANY_BRANCH				*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure to add or update a COMPANY_BRANCH
*/
DROP PROC IF EXISTS sp_add_or_update_company_branch;
GO
CREATE PROC sp_add_or_update_company_branch
	@branch_number		INT = NULL,
	@coc_number			INT,
	@town_number		INT,
	@street				VARCHAR(50),
	@house_number		VARCHAR(20),
	@insert				BIT
AS
BEGIN
	BEGIN TRY
		IF (@insert = 1)
			BEGIN
				INSERT INTO COMPANY_BRANCH (coc_number, town_number, street, house_number) VALUES
				(@coc_number,
				 @town_number,
				 @street,
				 @house_number)
			END
		ELSE
			BEGIN
				IF (@branch_number IS NULL OR @branch_number = 0)
					BEGIN
						;THROW 50000, '@branch_number cannot be NULL if an UPDATE is to be commenced', 1
					END

				ELSE IF NOT EXISTS (SELECT *
									FROM company_branch
									WHERE branch_number = @branch_number)
					BEGIN
						;THROW 50000, 'This company branch does not exist', 1
					END

					UPDATE COMPANY_BRANCH SET 
					coc_number = @coc_number,
					town_number = @town_number,
					street = @street,
					house_number = @house_number
					WHERE branch_number = @branch_number
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- Test INSERT
BEGIN TRAN
EXEC sp_add_or_update_company_branch NULL, 23456003, 3, 'Zwanenveld', '332', 1
ROLLBACK TRAN
GO

-- Test UPDATE
BEGIN TRAN
EXEC sp_add_or_update_company_branch 9, 23456045, 3, 'Coolestraatje', '332', 0
ROLLBACK TRAN
GO

-- Test UPDATE (SK does not exist)
BEGIN TRAN
EXEC sp_add_or_update_company_branch 200, 23456045, 3, 'Zwanenveld', '332', 0
ROLLBACK TRAN
GO

-- Test UPDATE (SK NULL)
BEGIN TRAN
EXEC sp_add_or_update_company_branch NULL, 23456045, 3, 'Bleustraat', '332', 0
ROLLBACK TRAN
GO