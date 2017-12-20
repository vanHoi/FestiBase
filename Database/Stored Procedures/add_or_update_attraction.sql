/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		20-12-2017									*/
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
	@attraction_number			INT,
	@festival_company_number	INT,
	@name						varchar(50),
	@attraction_type			varchar(50),
	@insert						BIT
AS
BEGIN
	BEGIN TRY
		/* IF @insert = 1, THEN INSERT.		IF @insert = 0, THEN UPDATE */
		IF (@insert = 1)
			BEGIN
				/* INSERT */
				INSERT INTO ATTRACTION (festival_company_number, name, attraction_type) VALUES
				(@festival_company_number,
				 @name,
				 @attraction_type)
			END
		ELSE
			BEGIN
				IF (@attraction_number IS NULL)
					BEGIN
						;THROW 50000, '@attraction_number cannot be NULL if an UPDATE is to be commenced', 1
					END

				ELSE IF NOT EXISTS (SELECT *
									FROM attraction
									WHERE attraction_number = @attraction_number)
					BEGIN
						;THROW 50000, 'This attraction does not exist', 1
					END

				/* UPDATE */
				UPDATE ATTRACTION SET 
				festival_company_number = @festival_company_number,
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

-- Test INSERT
BEGIN TRAN
EXEC sp_add_or_update_attraction NULL, 1, 'Wannabe London Eye', 'Reuzen Rad', 1
ROLLBACK TRAN
GO

-- Test UPDATE
BEGIN TRAN
EXEC sp_add_or_update_attraction 1, 1, 'Wannabe London Eye', 'Reuzen Rad', 0
ROLLBACK TRAN
GO

-- Test UPDATE (SK does not exist)
BEGIN TRAN
EXEC sp_add_or_update_attraction 300, 1, 'Wannabe London Eye', 'Reuzen Rad', 0
ROLLBACK TRAN
GO

-- Test UPDATE (SK cannot be NULL)
BEGIN TRAN
EXEC sp_add_or_update_attraction NULL, 1, 'Wannabe London Eye', 'Reuzen Rad', 0
ROLLBACK TRAN
GO