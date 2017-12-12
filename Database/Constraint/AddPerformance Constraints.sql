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

/*
	Insert into performance
*/
DROP PROC IF EXISTS sp_insert_performance
GO
CREATE PROC sp_insert_performance
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

/*
	Update performance
*/
DROP PROC IF EXISTS sp_update_performance
GO
CREATE PROC sp_update_performance
	@performance_number INT,
	@podium_number INT,
	@artist_number INT,
	@date		   DATE,
	@start_time	   TIME,
	@play_time	   INT
AS
BEGIN
	BEGIN TRY
		UPDATE PERFORMANCE SET 
		podium_number = @podium_number,
		artist_number = @artist_number,
		date = @date,
		start_time = @start_time,
		play_time = @play_time
		WHERE performance_number = @performance_number
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/*
	Twee artiesten kunnen niet tegelijk een optreden hebben op hetzelfde podium.
*/
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
		IF EXISTS (SELECT podium_number
				   FROM performance
				   WHERE podium_number IN (SELECT podium_number
										  FROM inserted)
				   AND artist_number IN (SELECT artist_number
										FROM inserted)
				   AND date IN (SELECT date
							   FROM inserted)
				   AND start_time BETWEEN (SELECT start_time FROM inserted) AND (SELECT DATEADD(minute, play_time, start_time) FROM inserted))
		BEGIN
			SELECT * FROM inserted
			--;THROW 50001, 'There is already an artist playing on this stage at that time', 1
		END
		/*
		IF EXISTS (SELECT *
				   FROM performance
				   WHERE podium_number IN (SELECT podium_number
										  FROM inserted)
				   AND artist_number IN (SELECT artist_number
										FROM inserted)
				   AND date IN (SELECT date
							   FROM inserted)
				   AND start_time BETWEEN (SELECT start_time FROM inserted) AND (SELECT DATEADD(minute, play_time, start_time) FROM inserted))
		BEGIN
			;THROW 50001, 'There is already an artist playing on this stage at that time', 1
		END
		*/
		/*
		IF EXISTS (SELECT p.*
				   FROM performance p INNER JOIN inserted i
				   ON p.podium_number = i.podium_number
				   WHERE p.podium_number = i.podium_number
				   AND p.artist_number = i.artist_number
				   AND p.date = i.date
				   AND p.start_time BETWEEN i.start_time AND DATEADD(minute, i.play_time, i.start_time))
		BEGIN
			;THROW 50001, 'There is already an artist playing on this stage at that time', 1
		END
		*/
		/*
		IF EXISTS (SELECT *
				   FROM performance
				   WHERE podium_number = (SELECT podium_number
										  FROM inserted)
				   AND artist_number = (SELECT artist_number
										FROM inserted)
				   AND date = (SELECT date
									 FROM inserted)
				   AND DATEADD(minute, play_time, start_time) BETWEEN (SELECT start_time FROM inserted) AND (SELECT DATEADD(minute, play_time, start_time) FROM inserted))
		BEGIN
			;THROW 50001, 'There is already an artist playing on this stage at that time 22', 1
		END

		IF EXISTS (SELECT *
				   FROM performance
				   WHERE podium_number = (SELECT podium_number
										  FROM inserted)
				   AND artist_number = (SELECT artist_number
									    FROM inserted)
				   AND date = (SELECT date
									 FROM inserted)
				   AND start_time < (SELECT start_time FROM inserted) 
				   AND DATEADD(minute, play_time, start_time) > (SELECT DATEADD(minute, play_time, start_time) FROM inserted))
		BEGIN
			;THROW 50001, 'There is already an artist playing on this stage at that time 33', 1
		END
		*/
    END TRY
    BEGIN CATCH
        ;THROW
    END CATCH
END
GO

--test
SELECT * FROM PERFORMANCE

SELECT * FROM PODIUM

--Werkt niet
BEGIN TRAN
EXEC sp_insert_performance 1, 2, '01-04-2017', '15:00:00', 60
ROLLBACK TRAN

BEGIN TRAN
EXEC sp_insert_performance 1, 2, '01-04-2017', '14:00:00', 140
ROLLBACK TRAN

--Werkt wel
BEGIN TRAN
EXEC sp_insert_performance 2, 3, '05-04-2017', '16:00:00', 110
ROLLBACK TRAN

BEGIN TRAN
EXEC sp_insert_performance 1, 4, '02-04-2017', '17:00:00', 120
ROLLBACK TRAN

insert into PERFORMANCE values (2, 3, '05-04-2017', '16:00:00', 110)

SELECT *
				   FROM performance
				   WHERE podium_number IN (SELECT podium_number FROM performance WHERE podium_number = 2)
				   AND artist_number IN (SELECT artist_number FROM performance WHERE artist_number = 4)
				   AND date IN (SELECT date FROM performance WHERE date = '05-04-2017')
				   --AND p.start_time BETWEEN '16:00:00' AND DATEADD(minute, 110, '16:00:00')