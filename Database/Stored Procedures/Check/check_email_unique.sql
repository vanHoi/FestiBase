/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		7											*/
/* Last edited:		11-01-2018									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Check if email is UNIQUE					*/
/*==============================================================*/

USE FestiBase
GO

/*
	Checks if the email is unique.

	Reason for not using UNIQUE CONSTRAINT:
	-	When inserting a visitor with a new town, that town will be inserted
		into TOWN. If an error gets triggered during an insert/update of a visitor
		the town will still get added to TOWN, which should not be happening.
*/

DROP PROCEDURE IF EXISTS sp_check_email_unique
GO
CREATE PROCEDURE sp_check_email_unique
	@email			VARCHAR(50)
AS
BEGIN
	BEGIN TRY
		IF EXISTS (SELECT email
				   FROM visitor
				   WHERE email = @email)
			BEGIN
				;THROW 50200, 'An E-mail must be unique', 1 
			END

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO