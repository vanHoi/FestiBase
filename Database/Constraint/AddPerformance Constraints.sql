/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version 4												*/	
/* Constraint													*/
/*==============================================================*/

/*
Constraint:		
Twee artiesten kunnen niet tegelijk een optreden hebben op hetzelfde podium.
*/

USE FestiBase
GO

DROP PROC IF EXISTS spInsertPerformance
GO
CREATE PROC spInsertPerformance
	@podium_number INT,
	@artist_number INT,
	@date		   DATE,
	@start_time	   TIME,
	@play_time	   INT
AS
BEGIN
	BEGIN TRY
		INSERT INTO PERFORMANCE VALUES
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

DROP TRIGGER IF EXISTS trg_artists_on_podium
GO
CREATE TRIGGER trg_artists_on_podium ON PERFORMANCE
AFTER INSERT, UPDATE
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
    BEGIN TRY
		IF EXISTS (SELECT *
				   FROM performance
				   WHERE podium_number = (SELECT podium_number
										  FROM inserted)
				   AND start_time BETWEEN (SELECT start_time FROM inserted) AND (SELECT DATEADD(hour, play_time, start_time) FROM inserted)
				   OR DATEADD(hour, play_time, start_time) BETWEEN (SELECT start_time FROM inserted) AND (SELECT DATEADD(hour, play_time, start_time) FROM inserted))
		BEGIN
			;THROW 50001, 'There is already an artist playing on this stage at that time', 1
		END

		IF EXISTS (SELECT *
				   FROM performance
				   WHERE podium_number = (SELECT podium_number
										  FROM inserted)
				   AND start_time < (SELECT start_time FROM inserted) 
				   AND DATEADD(hour, play_time, start_time) > (SELECT DATEADD(hour, play_time, start_time) FROM inserted))
		BEGIN
			;THROW 50001, 'There is already an artist playing on this stage at that time', 1
		END
    END TRY
    BEGIN CATCH
        ;THROW
    END CATCH
END
GO