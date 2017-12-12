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
	@ CHAR(2),
	@ INT
AS
BEGIN
	BEGIN TRY

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO