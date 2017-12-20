/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		18-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Insert + Update COUNTRY						*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure to add or update a COUNTRY
*/
DROP PROC IF EXISTS sp_add_or_update_country;
GO
CREATE PROC sp_add_or_update_country
	@country_number		INT = NULL,
	@name				VARCHAR(50),
	@insert				BIT
AS
BEGIN
	BEGIN TRY
		/* IF @insert = 1, THEN INSERT.		IF @insert = 0, THEN UPDATE */
		IF (@insert = 1)
			BEGIN
				/* INSERT */
				INSERT INTO COUNTRY (name) VALUES
				(@name)
			END
		ELSE
			BEGIN
				IF (@country_number IS NULL)
					BEGIN
						;THROW 50000, '@country_number cannot be NULL if an UPDATE is to be commenced', 1
					END

				ELSE IF NOT EXISTS (SELECT *
									FROM country
									WHERE country_number = @country_number)
					BEGIN
						;THROW 50000, 'This country does not exist', 1
					END

					/* UPDATE */
					UPDATE COUNTRY SET 
					name = @name
					WHERE country_number = @country_number
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- Test INSERT
BEGIN TRAN
EXEC sp_add_or_update_country NULL, 'Rusland', 1
ROLLBACK TRAN
GO

-- Test UPDATE
BEGIN TRAN
EXEC sp_add_or_update_country 1, 'Rusland', 0
ROLLBACK TRAN
GO

-- Test UPDATE (SK does not exist)
BEGIN TRAN
EXEC sp_add_or_update_country 234, 'Rusland', 0
ROLLBACK TRAN
GO

-- Test UPDATE (SK NULL)
BEGIN TRAN
EXEC sp_add_or_update_country NULL, 'Rusland', 0
ROLLBACK TRAN
GO