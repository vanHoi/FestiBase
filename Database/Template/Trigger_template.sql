/*
	Trigger naam begint met sp_
	Procedure naam niet in camelcases, maar kleine letters en _
	Gebruik een ;THROW, niet een RAISERROR.
	@@ROWCOUNT voor efficiëntie
	Voeg de bovenstaande doc toe
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