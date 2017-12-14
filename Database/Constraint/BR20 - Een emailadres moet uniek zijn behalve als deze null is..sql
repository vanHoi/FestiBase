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

CREATE UNIQUE NONCLUSTERED INDEX UNCI_emailadres_is_uniek
ON VISITOR(email)
WHERE email IS NOT NULL


-- This is an insert and update stored procedures for the Visitor table 

DROP PROC IF EXISTS sp_emailadres_is_uniek
GO
CREATE PROC sp_emailadres_is_uniek
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

		ELSE IF @insert = 0 
			BEGIN
				UPDATE VISITOR SET 
				email = @email,
				first_name = @first_name,
				surname = @surname
				WHERE email = @email
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
EXEC sp_emailadres_is_uniek 'robertverkerk@hetnet.nl', 'Robert', 'Kerkaden' , 1
ROLLBACK TRAN

-- Test 2:
--This test succeeds because the email address has not been used before
BEGIN TRAN
EXEC sp_emailadres_is_uniek 'ditiseentestmail@gmail.com', 'Artur', 'Koning', 1 
ROLLBACK TRAN

-- Test 3
-- This test succeeds because the email address can be empty 
BEGIN TRAN
EXEC sp_emailadres_is_uniek NULL, 'Abatur', 'Lopers', 1 
ROLLBACK TRAN

-- Test 4
-- The first insert succeeds because it’s a valid input and the second one fails because the email address has been used before
BEGIN TRAN
EXEC sp_emailadres_is_uniek NULL, 'Darius', 'Nazgul' , 1
EXEC sp_emailadres_is_uniek 'mariusssss@gmail.com', 'Norbi', 'Longcheng' , 1
ROLLBACK TRAN