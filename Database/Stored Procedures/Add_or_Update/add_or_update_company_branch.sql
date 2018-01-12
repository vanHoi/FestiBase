/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		7											*/
/* Last edited:		11-01-2018									*/
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
	@street				VARCHAR(50),
	@house_number		VARCHAR(20),
	@town_name			VARCHAR(50),
	@country_name		VARCHAR(50),
	@insert				BIT
AS
BEGIN
	BEGIN TRY

		DECLARE @town_number INT

		IF (@insert = 1)
			BEGIN
					
				EXEC sp_check_if_town_exists 
				@country_name, 
				@town_name

				SET @town_number = (SELECT town_number
									FROM TOWN
									WHERE "name" = @town_name)

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

				ELSE
					BEGIN
						
						EXEC sp_check_if_town_exists 
						@country_name, 
						@town_name

						SET @town_number = (SELECT town_number
											FROM TOWN
											WHERE "name" = @town_name)

						UPDATE COMPANY_BRANCH SET 
						coc_number = @coc_number,
						town_number = @town_number,
						street = @street,
						house_number = @house_number
						WHERE branch_number = @branch_number
					END
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- Test INSERT
BEGIN TRAN
EXEC sp_add_or_update_company_branch NULL, 23456003, 'Zwanenveld', '332', 'Nijmegen', 'Nederland', 1
ROLLBACK TRAN
GO

-- Test INSERT (new town)
BEGIN TRAN
EXEC sp_add_or_update_company_branch NULL, 23456003, 'Zwanenveld', '332', 'Assen', 'Nederland', 1
ROLLBACK TRAN
GO

-- Test INSERT (new town and new country)
BEGIN TRAN
EXEC sp_add_or_update_company_branch NULL, 23456003, 'Zwanenveld', '332', 'Rome', 'Italië', 1
ROLLBACK TRAN
GO

-- Test UPDATE
BEGIN TRAN
EXEC sp_add_or_update_company_branch 9, 23456045, 'Coolestraatje', '332', 'Nijmegen', 'Nederland', 0
ROLLBACK TRAN
GO

-- Test UPDATE (SK does not exist)
BEGIN TRAN
EXEC sp_add_or_update_company_branch 200, 23456045, 'Zwanenveld', '332', 'Nijmegen', 'Nederland', 0
ROLLBACK TRAN
GO

-- Test UPDATE (SK NULL)
BEGIN TRAN
EXEC sp_add_or_update_company_branch NULL, 23456045, 'Bleustraat', '332', 'Nijmegen', 'Nederland', 0
ROLLBACK TRAN
GO