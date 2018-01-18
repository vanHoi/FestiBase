/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		7											*/
/* Last edited:		11-01-2018									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Insert + Update VISITOR						*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure to add or update a VISITOR
*/
DROP PROC IF EXISTS sp_add_or_update_visitor;
GO
CREATE PROC sp_add_or_update_visitor
	@visitor_number		INT = NULL,
	@email				VARCHAR(50) = NULL,
	@first_name			VARCHAR(50) = NULL,
	@surname			VARCHAR(50) = NULL,
	@telephone_number	VARCHAR(10) = NULL,
	@birthdate			DATE = NULL,
	@twitter_username	VARCHAR(15) = NULL,
	@facebook_username	VARCHAR(70) = NULL,
	@street				VARCHAR(50) = NULL,
	@house_number		VARCHAR(20) = NULL,
	@town_name			VARCHAR(50) = NULL,
	@country_name		VARCHAR(50) = NULL,
	@insert				BIT
AS
BEGIN
	BEGIN TRY

		IF (@town_name IS NULL)
			BEGIN
				IF (@country_name IS NOT NULL)
					BEGIN
						;THROW 50100, '@town_name and @country_name should be either both NULL or both NOT NULL', 1
					END
			END

		IF (@town_name IS NOT NULL)
			BEGIN
				IF (@country_name IS NULL)
					BEGIN
						;THROW 50101, '@town_name and @country_name should be either both NULL or both NOT NULL', 1
					END				
			END

		EXEC sp_check_email_unique 
		@email
		
		DECLARE @town_number INT

		IF (@insert = 1)
			BEGIN
				IF (@town_name IS NOT NULL AND @country_name IS NOT NULL)
					BEGIN
						EXEC sp_check_if_town_exists 
						@country_name, 
						@town_name

						SET @town_number = (SELECT town_number
										FROM TOWN
										WHERE "name" = @town_name)
					END
				ELSE
					BEGIN
						SET @town_number = NULL
					END

				INSERT INTO VISITOR (town_number, email, first_name, surname, telephone_number, birthdate, 
									 twitter_username, facebook_username, street, house_number) VALUES
				(@town_number,
				 @email,
				 @first_name,
				 @surname,
				 @telephone_number,
				 @birthdate,
				 @twitter_username,
				 @facebook_username,
				 @street,
				 @house_number)
			END
		ELSE
			BEGIN
				IF (@visitor_number IS NULL OR @visitor_number = 0)
					BEGIN
						;THROW 50000, '@visitor_number cannot be NULL if an UPDATE is to be commenced', 1
					END

				ELSE IF NOT EXISTS (SELECT *
									FROM visitor
									WHERE visitor_number = @visitor_number)
					BEGIN
						;THROW 50000, 'This visitor does not exist', 1
					END

				ELSE
					BEGIN
						IF (@town_name IS NOT NULL AND @country_name IS NOT NULL)
							BEGIN
								EXEC sp_check_if_town_exists 
								@country_name, 
								@town_name

								SET @town_number = (SELECT town_number
												FROM TOWN
												WHERE "name" = @town_name)
							END
						ELSE
							BEGIN
								SET @town_number = NULL
							END

						UPDATE VISITOR SET 
						town_number = @town_number,
						email = @email,
						first_name = @first_name,
						surname = @surname,
						telephone_number = @telephone_number,
						birthdate = @birthdate,
						twitter_username = @twitter_username,
						facebook_username = @facebook_username,
						street = @street,
						house_number = @house_number
						WHERE visitor_number = @visitor_number
					END
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

-- Test INSERT succesvol
BEGIN TRAN
EXEC sp_add_or_update_visitor NULL, 'yuriz@live.nl', 'Yuri', 'Vannisselroy', '0682006373', '1996-09-25', 'NULL', 'NULL', 'NULL', 'NULL', 'Nijmegen', 'Nederland', 1
ROLLBACK TRAN
GO

-- Test INSERT succesvol
BEGIN TRAN
EXEC sp_add_or_update_visitor NULL, 'yuriz@live.nl', 'Yuri', 'Vannisselroy', '0682006373', '1996-09-25', 'NULL', 'NULL', 'NULL', 'NULL', NULL, NULL, 1
ROLLBACK TRAN
GO

-- Test INSERT succesvol (new town)
BEGIN TRAN
EXEC sp_add_or_update_visitor NULL, 'yuriz@live.nl', 'Yuri', 'Vannisselroy', '0682006373', '1996-09-25', 'NULL', 'NULL', 'NULL', 'NULL', 'Amstelveen', 'Nederland', 1
ROLLBACK TRAN
GO

-- Test INSERT succesvol (new town and country)
BEGIN TRAN
EXEC sp_add_or_update_visitor NULL, 'yuriz@live.nl', 'Yuri', 'Vannisselroy', '0682006373', '1996-09-25', 'NULL', 'NULL', 'NULL', 'NULL', 'Madrid', 'Spanje', 1
ROLLBACK TRAN
GO

-- Test INSERT NIET succesvol (cannot insert duplicate email)
BEGIN TRAN
EXEC sp_add_or_update_visitor NULL, 'robertverkerk@hetnet.nl', 'Yuri', 'Vannisselroy', '0682006373', '1996-09-25', 'NULL', 'NULL', 'NULL', 'NULL', 'Amstelveen', 'Nederland', 1
ROLLBACK TRAN
GO

-- Test INSERT NIET succesvol (must have both town and country either NULL or NOT NULL)
BEGIN TRAN
EXEC sp_add_or_update_visitor NULL, 'yuriz@live.nl', 'Yuri', 'Vannisselroy', '0682006373', '1996-09-25', 'NULL', 'NULL', 'NULL', 'NULL', NULL, 'Nederland', 1
ROLLBACK TRAN
GO

-- Test INSERT NIET succesvol (must have both town and country either NULL or NOT NULL)
BEGIN TRAN 
EXEC sp_add_or_update_visitor NULL, 'yuriz@live.nl', 'Yuri', 'Vannisselroy', '0682006373', '1996-09-25', 'NULL', 'NULL', 'NULL', 'NULL', 'Nijmegen', NULL, 1
ROLLBACK TRAN
GO

-- Test UPDATE succesvol
BEGIN TRAN
EXEC sp_add_or_update_visitor 1, 'yuriz@live.nl', 'Yuri', 'Vannisselroy', '0682006373', '1996-09-25', 'NULL', 'NULL', 'NULL', 'NULL', 'Amstelveen', 'Nederland', 0
ROLLBACK TRAN
GO

-- Test UPDATE NIET succesvol (visitor_number does not exist)
BEGIN TRAN
EXEC sp_add_or_update_visitor 300, 'yuriz@live.nl', 'Yuri', 'Vannisselroy', '0682006373', '1996-09-25', 'NULL', 'NULL', 'NULL', 'NULL', 'Amstelveen', 'Nederland', 0
ROLLBACK TRAN
GO

-- Test UPDATE NIET succesvol (visitor_number NULL)
BEGIN TRAN
EXEC sp_add_or_update_visitor NULL, 'yuriz@live.nl', 'Yuri', 'Vannisselroy', '0682006373', '1996-09-25', 'NULL', 'NULL', 'NULL', 'NULL', 'Amstelveen', 'Nederland', 0
ROLLBACK TRAN
GO