﻿/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Delete visitor_likes_performance			*/
/*==============================================================*/
USE FestiBase
GO

DROP PROCEDURE IF EXISTS sp_delete_visitor_likes_performance
GO
CREATE PROCEDURE sp_delete_visitor_likes_performance
	@visitor_number INT,
	@performance_number INT
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT *
				   FROM VISITOR_likes_PERFORMANCE
				   WHERE performance_number = @performance_number
				   AND visitor_number = @visitor_number)
			BEGIN
				;THROW 50000, 'This visitor performance does not exist', 1
			END

		DELETE FROM VISITOR_likes_PERFORMANCE WHERE performance_number = @performance_number AND visitor_number = @visitor_number
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/* tests */
/* delete success */
BEGIN TRAN
EXEC sp_delete_visitor_likes_performance 1, 1
ROLLBACK TRAN
GO

/* delete */
BEGIN TRAN
EXEC sp_delete_visitor_likes_performance 55, 1
ROLLBACK TRAN
GO
