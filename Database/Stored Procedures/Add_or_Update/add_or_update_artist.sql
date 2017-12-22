/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		20-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Insert + Update Artist						*/
/*==============================================================*/

USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_add_or_update_artist
GO
CREATE PROCEDURE sp_add_or_update_artist
	@artist_number	INT = NULL,
	@name			VARCHAR(50),
	@insert			BIT
AS
BEGIN
	BEGIN TRY
		IF (@insert = 1)
		BEGIN
			INSERT INTO ARTIST (name) VALUES 
			(@name)
		END
		ELSE 
		BEGIN
			IF (@artist_number IS NULL OR @artist_number = 0)
			BEGIN
				;THROW 50000, '@artist_number cannot be NULL if an UPDATE is to be commenced.', 1
			END
			IF NOT EXISTS (SELECT 1 FROM ARTIST WHERE artist_number = @artist_number)
			BEGIN
				;THROW 50001, 'This artist does not exist.', 1
			END

			UPDATE ARTIST SET 
			name = @name 
			WHERE artist_number = @artist_number
		END

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/*tests*/

/* insert */
BEGIN TRAN
EXEC sp_add_or_update_artist NULL, 'freek', 1
ROLLBACK TRAN
GO

/* update */
BEGIN TRAN
EXEC sp_add_or_update_artist 1, 'name', 0
ROLLBACK TRAN
GO

/* update key NULL */
BEGIN TRAN
EXEC sp_add_or_update_artist NULL, 'name', 0
ROLLBACK TRAN
GO

/* update, wrong artist */
BEGIN TRAN
EXEC sp_add_or_update_artist 9999, 'name', 0
ROLLBACK TRAN
GO