/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Trigger on:		TABEL										*/
/*==============================================================*/

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