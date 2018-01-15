/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		08-01-2018									*/
/* Edited by:		Mariusz Blautzik							*/
/* Procedure:		Insert VISITOR VISITED PERFORMANCE			*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure to add a VISITOR VISITED PERFORMANCE
*/
DROP PROC IF EXISTS sp_add_visitor_visited_performance
GO
CREATE PROC sp_add_visitor_visited_performance
	@visitor_number				INT,
    @performance_number			INT
AS
BEGIN
	BEGIN TRY
			BEGIN
				INSERT INTO VISITOR_visited_PERFORMANCE(visitor_number, performance_number) VALUES
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
EXEC sp_add_visitor_visited_performance 1, 3
ROLLBACK TRAN
GO

-- INSERT SUCCESSFUL
BEGIN TRAN
EXEC sp_add_visitor_visited_performance 3, 7   
ROLLBACK TRAN
GO

