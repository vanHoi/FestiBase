/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		18-12-2017									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Procedure:		Insert + Update LOCKER						*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure to add or update a LOCKER
*/
DROP PROC IF EXISTS sp_add_or_update_locker;
GO
CREATE PROC sp_add_or_update_locker
	@locker_number		INT = NULL,
	@festival_number	INT,
	@branch_number		INT,
	@insert				BIT
AS
BEGIN
	BEGIN TRY
		/* IF @insert = 1, THEN INSERT.		IF @insert = 0, THEN UPDATE */
		IF (@insert = 1)
			BEGIN
				/* INSERT */
				INSERT INTO LOCKER (festival_number, branch_number) VALUES
				(@festival_number,
				 @branch_number)
			END
		ELSE
			BEGIN
				IF (@locker_number = null)
					BEGIN
						;THROW 50000, '@locker_number cannot be NULL if an UPDATE is to be commenced', 1
					END

					/* UPDATE */
					UPDATE LOCKER SET 
					festival_number = @festival_number,
					branch_number = @branch_number
					WHERE locker_number = @locker_number
			END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO