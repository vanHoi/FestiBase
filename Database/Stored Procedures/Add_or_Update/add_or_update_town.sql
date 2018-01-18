/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		7											*/
/* Last edited:		11-01-2018									*/
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
	@country_name		VARCHAR(50),
	@town_name			VARCHAR(50),
	@insert				BIT
AS
BEGIN
	BEGIN TRY
		
		EXEC sp_check_if_country_exists @country_name

		DECLARE @country_number INT = (SELECT country_number
									   FROM COUNTRY
									   WHERE "name" = @country_name)

		IF (@insert = 1)
			BEGIN
				INSERT INTO TOWN (country_number, "name") VALUES
				(@country_number,
				 @town_name)
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
					"name" = @town_name
					WHERE town_number = @town_number
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- Test INSERT successvol
BEGIN TRAN
EXEC sp_add_or_update_town NULL, 'Nederland', 'Groningen', 1
ROLLBACK TRAN
GO

-- Test INSERT successvol (new country)
BEGIN TRAN
EXEC sp_add_or_update_town NULL, 'Brazilië', 'Rio', 1
ROLLBACK TRAN
GO

-- Test UPDATE successvol
BEGIN TRAN
EXEC sp_add_or_update_town 1, 'Nederland', 'Groningen', 0
ROLLBACK TRAN
GO

-- Test UPDATE NIET successvol (Town does not exist)
BEGIN TRAN
EXEC sp_add_or_update_town 234, 'Nederland', 'Groningen', 0
ROLLBACK TRAN
GO

-- Test UPDATE NIET successvol (Town_Number is NULL)
BEGIN TRAN
EXEC sp_add_or_update_town NULL, 'Nederland', 'Groningen', 0
ROLLBACK TRAN
GO