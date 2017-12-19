/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		18-12-2017									*/
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
	@town_number		INT = NULL,
	@email				VARCHAR(50) = NULL,
	@first_name			VARCHAR(50) = NULL,
	@surname			VARCHAR(50) = NULL,
	@telephone_number	VARCHAR(10) = NULL,
	@birthdate			datetime = NULL,
	@twitter_username	VARCHAR(15) = NULL,
	@facebook_username	VARCHAR(70) = NULL,
	@street				VARCHAR(50) = NULL,
	@house_number		VARCHAR(20) = NULL,
	@insert				BIT
AS
BEGIN
	BEGIN TRY
		/* IF @insert = 1, THEN INSERT.		IF @insert = 0, THEN UPDATE */
		IF (@insert = 1)
			BEGIN
				/* INSERT */
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
				IF (@visitor_number = null)
					BEGIN
						;THROW 50000, '@visitor_number cannot be NULL if an UPDATE is to be commenced', 1
					END

					/* UPDATE */
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
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO