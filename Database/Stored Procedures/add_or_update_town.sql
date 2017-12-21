/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		21-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Insert + Update TOWN						*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure to add or update a TOWN
*/
DROP PROC IF EXISTS sp_add_or_update_town;
GO
CREATE PROC sp_add_or_update_town
	@town_number		INT = NULL,
	@country_number		INT,
	@name				VARCHAR(50),
	@insert				BIT
AS
BEGIN
	BEGIN TRY
		IF (@insert = 1)
			BEGIN
				INSERT INTO TOWN (country_number, name) VALUES
				(@country_number,
				 @name)
			END
		ELSE
			BEGIN
				IF (@town_number IS NULL OR @town_number = 0)
					BEGIN
						;THROW 50000, '@town_number cannot be NULL if an UPDATE is to be commenced', 1
					END

				ELSE IF NOT EXISTS (SELECT *
									FROM town
									WHERE town_number = @town_number)
					BEGIN
						;THROW 50000, 'This town does not exist', 1
					END

					UPDATE TOWN SET 
					country_number = @country_number,
					name = @name
					WHERE town_number = @town_number
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- Test INSERT
BEGIN TRAN
EXEC sp_add_or_update_town NULL, 1, 'Groningen', 1
ROLLBACK TRAN
GO

-- Test UPDATE
BEGIN TRAN
EXEC sp_add_or_update_town 1, 1, 'Groningen', 0
ROLLBACK TRAN
GO

-- Test UPDATE (SK does not exist)
BEGIN TRAN
EXEC sp_add_or_update_town 234, 1, 'Groningen', 0
ROLLBACK TRAN
GO

-- Test UPDATE (SK NULL)
BEGIN TRAN
EXEC sp_add_or_update_town NULL, 1, 'Groningen', 0
ROLLBACK TRAN
GO