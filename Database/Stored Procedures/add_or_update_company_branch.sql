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
		/* IF @insert = 1, THEN INSERT.		IF @insert = 0, THEN UPDATE */
		IF (@insert = 1)
			BEGIN
				/* INSERT */
				INSERT INTO COMPANY_BRANCH (coc_number, town_number, street, house_number) VALUES
				(@coc_number,
				 @town_number,
				 @street,
				 @house_number)
			END
		ELSE
			BEGIN
				IF (@branch_number = null)
					BEGIN
						;THROW 50000, '@branch_number cannot be NULL if an UPDATE is to be commenced', 1
					END

					/* UPDATE */
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