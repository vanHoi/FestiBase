/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		20-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Insert + Update TABEL						*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_
GO
CREATE PROCEDURE sp_
	@surrogate_key INT = NULL,
	@text VARCHAR(50),
	@number INT,
	@insert BIT
AS
BEGIN
	BEGIN TRY

		-- Enter checks here
		-->

		-- Inser or update start
		IF (@insert = 1)
		BEGIN
			-- insert code
		END
		ELSE 
		BEGIN
			IF (@surrogate_key = NULL OR @surrogate_key = 0)
			BEGIN
				;THROW 50000, '@surrogate_key cannot be NULL if an UPDATE is to be commenced.', 1
			END
			IF NOT EXISTS (SELECT 1 FROM table WHERE surrogate_key = @surrogate_key)
			BEGIN
				;THROW 50001, 'This unit does not exist.', 1
			END
			-- update code
		END

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO


/*
	Procedure naam begint met sp_
	Procedure naam niet in camelcases, maar kleine letters en _
	@surrogate_key moet ingevuld zijn voor een update, voor insert gebruik NULL.
	Gebruik een ;THROW, niet een RAISERROR.
*/