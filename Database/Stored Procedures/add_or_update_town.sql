/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		18-12-2017									*/
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
	@town_name			VARCHAR(50),
	@insert				BIT
AS
BEGIN
	BEGIN TRY
		/* IF @insert = 1, THEN INSERT.		IF @insert = 0, THEN UPDATE */
		IF (@insert = 1)
			BEGIN
				/* INSERT */
				INSERT INTO TOWN (country_number, town_name) VALUES
				(@country_number,
				 @town_name)
			END
		ELSE
			BEGIN
				IF (@town_number = null)
					BEGIN
						;THROW 50000, '@town_number cannot be NULL if an UPDATE is to be commenced', 1
					END

					/* UPDATE */
					UPDATE TOWN SET 
					country_number = @country_number,
					town_name = @town_name
					WHERE town_number = @town_number
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO