/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		7											*/
/* Last edited:		11-01-2018									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Check if country exists						*/
/*==============================================================*/

USE FestiBase
GO

/*
	This procedure checks if the COUNTRY that gets inserted/update with a TOWN
	exists or not. If it doesn't exist, it will insert a new COUNTRY
*/

DROP PROCEDURE IF EXISTS sp_check_if_country_exists
GO
CREATE PROCEDURE sp_check_if_country_exists
	@country_name	VARCHAR(50)
AS
BEGIN
	BEGIN TRY

		IF NOT EXISTS (SELECT "name"
					   FROM COUNTRY
				       WHERE "name" = @country_name)
			BEGIN
				EXEC sp_add_or_update_country NULL, @country_name, 1
			END

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO