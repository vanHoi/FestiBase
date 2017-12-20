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
	@country_name		INT,
	@insert				BIT
AS
BEGIN
	BEGIN TRY
		/* IF @insert = 1, THEN INSERT.		IF @insert = 0, THEN UPDATE */
		IF (@insert = 1)
			BEGIN
				/* INSERT */
				INSERT INTO COUNTRY (country_name) VALUES
				(@country_name)
			END
		ELSE
			BEGIN
				IF (@country_number = null)
					BEGIN
						;THROW 50000, '@country_number cannot be NULL if an UPDATE is to be commenced', 1
					END

					/* UPDATE */
					UPDATE COUNTRY SET 
					country_name = @country_name
					WHERE country_number = @country_number
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO