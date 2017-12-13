/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version 4												*/	
/* Templates													*/
/*==============================================================*/

/*
	Zet dit boven het DDL script
*/
USE master
GO

DROP DATABASE IF EXISTS FestiBase
GO

CREATE DATABASE FestiBase
GO

USE FestiBase
GO

/*
	Trigger naam begint met sp_
	Procedure naam niet in camelcases, maar kleine letters en _
	Gebruik een ;THROW, niet een RAISERROR.
	@@ROWCOUNT voor efficiëntie
*/
DROP TRIGGER IF EXISTS trg_
GO
CREATE TRIGGER trg_ ON TABLE
AFTER UPDATE
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
    BEGIN TRY
	-->
		BEGIN
			;THROW 50001, '', 1
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
	Roep een procedure aan met @insert = 1 als je een insert wilt uitvoeren.
	Roep een procedure aan met @insert = 0 als je een update wilt uitvoeren.
	@surrogate_key moet ingevuld zijn voor een update, voor insert gebruik NULL.
	Gebruik een ;THROW, niet een RAISERROR.
*/
DROP PROCEDURE IF EXISTS sp_
GO
CREATE PROCEDURE sp_
	@insert BIT,
	@surrogate_key INT = NULL,
	@text VARCHAR(50),
	@number INT
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
			IF (@surrogate_key = null)
			BEGIN
				;THROW 50000, 'You must supply a surrogate key with an update statement.', 1
			END
			-- update code
		END

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO