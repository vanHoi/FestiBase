/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version 4												*/	
/* Constraint													*/
/*==============================================================*/

/*
Mariusz Blautzik
Constraint:		
Een artiest kan maar een optreden tegelijk hebben.
*/

SET DATEFORMAT DMY

DROP PROC IF EXISTS sp_one_performances_at_a_time
GO
CREATE PROC sp_one_performances_at_a_time
@podium_number		INT,
@artist_number		INT,
@date				DATE,
@start_time			TIME,
@play_time			INT
AS
BEGIN
	BEGIN TRY
		IF EXISTS  (SELECT artist_number
					FROM PERFORMANCE
					WHERE artist_number = @artist_number
					AND date = @date
					AND (@start_time BETWEEN start_time AND DATEADD(minute, play_time, start_time)
					OR DATEADD(minute, @play_time, @start_time) BETWEEN start_time AND DATEADD(minute, play_time, start_time))
					)
		BEGIN
			;THROW 50001, 'This artist has already a performance. You can’t add second performance. ', 1
		END

		INSERT INTO PERFORMANCE 
		VALUES
			   (@podium_number,
				@artist_number,
				@date,
				@start_time,
				@play_time)

	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO



-- Test 1
-- Deze insert werk omdat deze artiest nog geen performace heeft gepland
BEGIN TRAN
EXEC sp_one_performances_at_a_time 1, 5, '11-05-2017', '15:00:00', 60
ROLLBACK TRAN

-- Test 2
-- Deze insert werk omdat deze artiest een performance heeft gepland op andere dag
BEGIN TRAN
EXEC sp_one_performances_at_a_time 1, 5, '03-01-2017', '15:00:00', 60
ROLLBACK TRAN

-- Test 3
-- Deze insert werk omdat de performance op een latere tijdstip is ingepland
BEGIN TRAN
EXEC sp_one_performances_at_a_time 1, 1, '04-01-2017', '19:55:00', 60
ROLLBACK TRAN

-- Test 4
-- Deze insert werk niet omdat deze optreden al reeds toevegoed is
BEGIN TRAN
EXEC sp_one_performances_at_a_time 1, 1, '04-01-2017', '15:00:00', 60
ROLLBACK TRAN

-- Test 5
-- Deze insert werk niet omdat de begintijd in een reeds geplande performance ligt
BEGIN TRAN
EXEC sp_one_performances_at_a_time 1, 1, '04-01-2017', '15:55:00', 60
ROLLBACK TRAN

-- Test 6
-- Deze insert werk niet omdat de eindtijd van deze performance tussen de tijd ligt van al reeds gepland performance
BEGIN TRAN
EXEC sp_one_performances_at_a_time 2, 1, '04-01-2017', '14:55:00', 60
ROLLBACK TRAN