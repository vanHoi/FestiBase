/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version 4												*/	
/* Templates													*/
/*==============================================================*/

DROP TRIGGER IF EXISTS dbo.TRG
GO
CREATE TRIGGER dbo.TRG ON TABLE
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

CREATE PROCEDURE prcMaatschappij_balie
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