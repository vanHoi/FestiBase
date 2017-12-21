/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		21-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Insert + Update FESTIVAL_COMPANY			*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure to add or update a FESTIVAL_COMPANY
*/
DROP PROC IF EXISTS sp_add_or_update_festival_company;
GO
CREATE PROC sp_add_or_update_festival_company
	@festival_company_number	INT = NULL,
	@festival_number			INT,
	@branch_number				INT,
	@contact_person				VARCHAR(50),
	@description				TEXT,
	@telephone_number			VARCHAR(15),
	@insert						BIT
AS
BEGIN
	BEGIN TRY
		IF (@insert = 1)
			BEGIN
				INSERT INTO FESTIVAL_COMPANY (festival_number, branch_number, contact_person, description, telephone_number) VALUES
				(@festival_number,
				 @branch_number,
				 @contact_person,
				 @description,
				 @telephone_number)
			END
		ELSE
			BEGIN
				IF (@festival_company_number IS NULL OR @festival_company_number = 0)
					BEGIN
						;THROW 50000, '@festival_company_number cannot be NULL if an update is to be commenced', 1
					END
				
				ELSE IF NOT EXISTS (SELECT *
									FROM festival_company
									WHERE festival_company_number = @festival_company_number)
					BEGIN
						;THROW 50000, 'This festival_company does not exist', 1
					END

				UPDATE FESTIVAL_COMPANY SET 
				festival_number = @festival_number,
				branch_number = @branch_number,
				contact_person = @contact_person,
				description = @description,
				telephone_number = @telephone_number
				WHERE festival_company_number = @festival_company_number
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- INSERT
BEGIN TRAN
EXEC sp_add_or_update_festival_company NULL, 1, 12, 'Kees Kroket', 'Beschrijving', '0612312312', 1
ROLLBACK TRAN
GO

-- UPDATE
BEGIN TRAN
EXEC sp_add_or_update_festival_company 12, 1, 12, 'Kees Kroket', 'Beschrijving', '0612312312', 0
ROLLBACK TRAN
GO

-- UPDATE (SK does not exist)
BEGIN TRAN
EXEC sp_add_or_update_festival_company 300, 1, 12, 'Kees Kroket', 'Beschrijving', '0612312312', 0
ROLLBACK TRAN
GO

-- UPDATE (SK cannot be NULL)
BEGIN TRAN
EXEC sp_add_or_update_festival_company NULL, 1, 12, 'Kees Kroket', 'Beschrijving', '0612312312', 0
ROLLBACK TRAN
GO

BEGIN TRAN
EXEC sp_add_or_update_festival_company 0, 1, 12, 'Kees Kroket', 'Beschrijving', '0612312312', 0
ROLLBACK TRAN
GO