/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		7											*/
/* Last edited:		11-01-2018									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Check if town exists with visitor			*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_check_if_town_exists
GO
CREATE PROCEDURE sp_check_if_town_exists
	@country_name	 VARCHAR(50),
	@town_name		 VARCHAR(50)
AS
BEGIN
	BEGIN TRY

		IF NOT EXISTS (SELECT "name"
					   FROM TOWN
				       WHERE "name" = @town_name)
			BEGIN
				EXEC sp_add_or_update_town 
				NULL, 
				@country_name, 
				@town_name, 
				1
			END

		ELSE
			BEGIN
				EXEC sp_check_if_country_exists
				@country_name
			END

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO