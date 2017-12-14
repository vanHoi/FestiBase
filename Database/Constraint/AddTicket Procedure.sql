DROP PROCEDURE if exists sp_valid_ticket
GO
CREATE PROCEDURE sp_valid_ticket
@festival_number INT,
@branch_number INT,
@ticket_type VARCHAR(50),
@price money,
@date_valid_from DATETIME,
@date_valid_to DATETIME
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF(
			NOT EXISTS(
				SELECT * FROM Festival
				WHERE festival_number = @festival_number AND
				@date_valid_from BETWEEN start_date AND end_date AND
				@date_valid_to BETWEEN start_date AND end_date
			)
		)
		BEGIN
			;THROW 50001, 'The valid dates of the ticket are not between the start and enddate of the festival.', 1
		END

		INSERT INTO TICKET_TYPE VALUES (@festival_number, @branch_number, @ticket_type, @price, @date_valid_from, @date_valid_to)
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

--Tests
--Execute this statement first
SET DATEFORMAT ymd

--date_valid_from is too early
EXEC sp_valid_ticket 1, 10, 'VIP ticket', 500.00, '2017-07-14 23:00:00', '2017-07-17 00:00:00'

--date_valid_to is too late
EXEC sp_valid_ticket 1, 10, 'VIP ticket', 500.00, '2017-07-15 00:00:00', '2017-07-17 01:00:00'

--Works, Date is exactly on the start and end-date of the festival
EXEC sp_valid_ticket 1, 10, 'VIP ticket', 500.00, '2017-07-15 00:00:00', '2017-07-17 00:00:00'

--Works
EXEC sp_valid_ticket 1, 10, 'Normal ticket', 500.00, '2017-07-15 05:00:00', '2017-07-16 23:00:00'