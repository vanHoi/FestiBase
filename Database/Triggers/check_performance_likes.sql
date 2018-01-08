/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		8-1-2018									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Trigger on:		PERFORMANCE									*/
/*==============================================================*/

USE FestiBase
GO

/*
	Trigger that checks if the performance has a lot of likes when updating the podium_schedule_number
*/
DROP TRIGGER IF EXISTS trg_check_performance_likes
GO
CREATE TRIGGER trg_check_performance_likes ON PERFORMANCE
AFTER UPDATE
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
    BEGIN TRY
		IF (SELECT COUNT(*)
			FROM visitor_likes_performance
			WHERE performance_number = (SELECT performance_number
										FROM inserted))
		>
		   ((SELECT p.capacity
		     FROM podium p INNER JOIN podium_schedule ps
				ON p.podium_number = ps.podium_number
			 WHERE ps.podium_schedule_number = (SELECT podium_schedule_number
												FROM inserted))
			/ 10)
		BEGIN
			RAISERROR ('WARNING: The podium capacity might be too low for this performance', 10, 1);
		END
    END TRY
    BEGIN CATCH
        ;THROW
    END CATCH
END
GO