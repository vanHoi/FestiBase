/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		18-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Insert + Update ATTRACTION					*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure to add or update an ATTRACTION
*/
DROP PROC IF EXISTS sp_add_or_update_attraction;
GO
CREATE PROC sp_add_or_update_attraction
	@attraction_number		INT,
	@festival_number		INT,
	@branch_time			INT,
	@name					varchar(50),
	@attraction_type		varchar(50),
	@insert					BIT
AS
BEGIN
	BEGIN TRY
		/* IF @insert = 1, THEN INSERT.		IF @insert = 0, THEN UPDATE */
		IF (@insert = 1)
			BEGIN
				/* INSERT */
				INSERT INTO ATTRACTION (festival_number, branch_number, name, attraction_type) VALUES
				(@festival_number,
				 @branch_number,
				 @name,
				 @attraction_type)
			END
		ELSE
			BEGIN
				IF (@attraction_number = null)
					BEGIN
						;THROW 50000, '@attraction_number cannot be NULL if an UPDATE is to be commenced', 1
					END

					/* UPDATE */
					UPDATE ATTRACTION SET 
					festival_number = @festival_number,
					branch_number = @branch_number,
					name = @name,
					attraction_type = @attraction_type
					WHERE attraction_number = @attraction_number
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO