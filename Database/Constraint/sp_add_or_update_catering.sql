/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version 4												*/	
/* Constraint													*/
/* Robert Verkerk												*/
/* Procedure to add or update catering							*/
/*==============================================================*/

USE FestiBase
GO

DROP PROC IF EXISTS sp_add_or_update_catering;
GO

CREATE PROC sp_add_or_update_catering
	@insert BIT,
	@catering_number INT = NULL,
	@festival_company_number INT,
	@name VARCHAR(50),
	@electricity BIT
AS
BEGIN
	BEGIN TRY
		IF (@insert = 1)
		BEGIN
			INSERT INTO CATERING (festival_company_number, name, electricity) VALUES (@festival_company_number, @name, @electricity)
		END
		ELSE 
		BEGIN
			IF (@catering_number IS NULL)
			BEGIN
				;THROW 50000, '@catering_number cannot be NULL if an UPDATE is to be commenced.', 1
			END
			IF NOT EXISTS (SELECT 1 FROM CATERING WHERE catering_number = @catering_number)
			BEGIN
				;THROW 50001, 'This catering does not exist.', 1
			END
			UPDATE CATERING SET festival_company_number = @festival_company_number, name = @name, electricity = @electricity WHERE catering_number = @catering_number
		END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* Tests */

/*insert*/
BEGIN TRAN
EXEC sp_add_or_update_catering 1, NULL, 1, 'Bier', 1
ROLLBACK TRAN

/*update*/
BEGIN TRAN
EXEC sp_add_or_update_catering 0, 4, 8, 'bier', 0
ROLLBACK TRAN

/*update fail*/
BEGIN TRAN
EXEC sp_add_or_update_catering 0, 5, 5, 'bier', 0
ROLLBACK TRAN