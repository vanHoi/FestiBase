/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		09-01-2018									*/
/* Edited by:		Mariusz Blautzik							*/
/* Procedure:		Insert VISITOR LIKES PERFORMANCE			*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure to add a VISITOR LIKES PERFORMANCE
*/
DROP PROC IF EXISTS sp_add_visitor_likes_performance
GO
CREATE PROC sp_add_visitor_likes_performance
	@visitor_number				INT,
    @performance_number			INT
AS
BEGIN
	BEGIN TRY
			BEGIN
				INSERT INTO VISITOR_likes_PERFORMANCE(visitor_number, performance_number) VALUES
				(@visitor_number,
				 @performance_number
				 )
			END
	END TRY
	BEGIN CATCH
		;THROW 
	END CATCH
END
GO

-- INSERT SUCCESSFUL
BEGIN TRAN
EXEC sp_add_visitor_likes_performance 1, 3
ROLLBACK TRAN
GO

-- INSERT FAILED - INCORRECT PERFORMANCE_NUMBER
BEGIN TRAN
EXEC sp_add_visitor_likes_performance 3, 20  
ROLLBACK TRAN
GO
