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
			;THROW 50001, 'Ticket datums liggen niet tussen de start- en einddatum van het festival.', 1
		END

		INSERT INTO TICKET_TYPE VALUES (@festival_number, @branch_number, @ticket_type, @price, @date_valid_from, @date_valid_to)
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

--Tests
SET DATEFORMAT dmy

INSERT INTO Organisation VALUES ('Organisatie Paaspop')

INSERT INTO Festival VALUES (1, 'Paaspop', '13-12-2017 12:00:00', '17-12-2017 23:00:00', 'Nijmegen', 2.99)

INSERT INTO Company VALUES ('01010101', 'TicketMaster')

INSERT INTO Country VALUES ('Nederland')

INSERT INTO Town VALUES (1, 'Nijmegen')

INSERT INTO COMPANY_BRANCH VALUES ('01010101', 1, 'Heyendaalseweg', 1)

INSERT INTO FESTIVAL_COMPANY VALUES (1, 1, 'L. Chen', 'Verkoopt tickets', '0612345678')

--Startdatum te vroeg
EXEC sp_valid_ticket 1, 1, 'VIP ticket', 500.00, '13-12-2017 11:00:00', '17-12-2017 22:00:00'

--Einddatum is te laat
EXEC sp_valid_ticket 1, 1, 'VIP ticket', 500.00, '13-12-2017 13:00:00', '17-12-2017 23:30:00'

--Goed
EXEC sp_valid_ticket 1, 1, 'VIP ticket', 500.00, '13-12-2017 13:00:00', '17-12-2017 22:00:00'

--INSERT INTO TICKET_TYPE VALUES (1, 1, 'Normale ticket', 500.00, '13-12-2017 13:00:00', '17-12-2017 22:30:00')