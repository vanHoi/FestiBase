*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version 4												*/	
/* Constraint													*/
/*==============================================================*/

/*
Mariusz Blautzik
Constraint:		
Een emailadres moet uniek zijn behalve als deze null is.
*/

-- This checks if an email address is unique

DROP INDEX  UNCI_emailadres_is_uniek ON VISITOR
GO
CREATE UNIQUE NONCLUSTERED INDEX UNCI_emailadres_is_uniek
ON VISITOR(email)
WHERE email IS NOT NULL


-- This is an insert and update stored procedures for the Visitor table 

DROP PROC IF EXISTS sp_emailadres_is_uniek
GO
CREATE PROC sp_emailadres_is_uniek
@visitor_number		INT = NULL,
@email				VARCHAR(50),
@first_name			VARCHAR(50),
@surname			VARCHAR(50),
@insert				BIT
AS
BEGIN
	BEGIN TRY
		 IF @insert = 1
			BEGIN
				INSERT INTO VISITOR VALUES
				(@email,				
				@first_name,		
				@surname)			
			END

		ELSE 
			BEGIN
				IF (@visitor_number = null)

				BEGIN
				;THROW 50000, 'You must supply a surrogate key with an update statement.', 1
				END

					UPDATE VISITOR SET 
					email = @email,
					first_name = @first_name,
					surname = @surname
					WHERE email = @email OR visitor_number = @visitor_number
			END
		
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO



/* TEST SECTION */

-- Test 1:
-- This test fails because the email address has been used before
BEGIN TRAN
EXEC sp_emailadres_is_uniek NULL, 'robertverkerk@hetnet.nl', 'Robert', 'Kerkaden' , 1
ROLLBACK TRAN

-- Test 2:
--This test succeeds because the email address has not been used before
BEGIN TRAN
EXEC sp_emailadres_is_uniek NULL, 'ditiseentestmail@gmail.com', 'Artur', 'Koning', 1 
ROLLBACK TRAN

-- Test 3
-- This test succeeds because the email address can be empty 
BEGIN TRAN
EXEC sp_emailadres_is_uniek NULL, NULL, 'Abatur', 'Lopers', 1 
ROLLBACK TRAN

-- Test 4
-- The first insert succeeds because it’s a valid input and the second one fails because the email address has been used before
BEGIN TRAN
EXEC sp_emailadres_is_uniek NULL, NULL, 'Darius', 'Nazgul' , 1
EXEC sp_emailadres_is_uniek NULL, 'mariusssss@gmail.com', 'Norbi', 'Longcheng' , 1
ROLLBACK TRAN