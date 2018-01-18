/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		09-01-2018									*/
/* Edited by:		Mariusz Blautzik							*/
/* Procedure:		Insert + Update ARTIST_FILE					*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure to add or update a ARTIST_FILE
*/
DROP PROC IF EXISTS sp_add_or_update_artist_file
GO
CREATE PROC sp_add_or_update_artist_file
	@file_number 				INT = NULL,
	@artist_number 				INT,
	@festival_company_number	INT,
	@file						VARCHAR(50),
	@description				TEXT,
	@insert						BIT
AS
BEGIN
	BEGIN TRY		
		IF (@insert = 1)
			BEGIN
				INSERT INTO ARTIST_FILE(artist_number, festival_company_number, "file", "description") VALUES
				(@artist_number,
				 @festival_company_number,
				 @file,
				 @description
				 )
			END
		ELSE
			BEGIN
				IF (@file_number IS NULL OR @file_number = 0)
					BEGIN
						;THROW 50000, '@file_number cannot be NULL or ZERO if an update is to be commenced', 1
					END
				
				ELSE IF NOT EXISTS (SELECT *
									FROM ARTIST_FILE
									WHERE file_number = @file_number)
					BEGIN
						;THROW 50000, 'This file_number does not exist', 1
					END

				UPDATE ARTIST_FILE SET 
				artist_number = @artist_number,
				festival_company_number = @festival_company_number,
				"file" = @file,
				"description" = @description
				WHERE file_number = @file_number
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- INSERT SUCCESSFUL
BEGIN TRAN
EXEC sp_add_or_update_artist_file  NULL, 4, 5, 'Contract met Jannes', 'Contract met De Zingend Pool voor 2 uur optreden op zaterdag', 1
ROLLBACK TRAN
GO

-- UPDATE SUCCESSFUL
BEGIN TRAN
EXEC sp_add_or_update_artist_file  1, 1, 11, 'Contract 3ROBI Zondag', 'Het nieuwe contract van 3ROBI', 0
ROLLBACK TRAN
GO

-- INSERT FAILED (Festival Company doesn't exist)
BEGIN TRAN
EXEC sp_add_or_update_artist_file  NULL, 1, 999, 'Trackkzzz', 'Tracklist voor de radio', 1
ROLLBACK TRAN
GO

-- UPDATE FAILED (File_number does not exist)
BEGIN TRAN
EXEC sp_add_or_update_artist_file  999, 1, 11, 'Tracklist Hardwell', 'Het tracklist van Hardwell voor eindshow', 0
ROLLBACK TRAN
GO

-- UPDATE FAILED (Festival company number cannot be NULL)
BEGIN TRAN
EXEC sp_add_or_update_artist_file  NULL, 1, 11, 'Tiesto Liedjes Mixx', 'Het liedjes mixx van Tiestoooooooo', 0
ROLLBACK TRAN
GO
