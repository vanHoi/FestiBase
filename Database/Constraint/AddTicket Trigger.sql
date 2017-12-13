DROP TRIGGER if exists trg_valid_ticket
GO
CREATE TRIGGER trg_valid_ticket ON TICKET_TYPE
AFTER INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
		IF(
			NOT EXISTS(
				SELECT * FROM Festival f
				INNER JOIN Inserted i ON i.festival_number = f.festival_number
				WHERE i.date_valid_from BETWEEN f.start_date AND f.end_date AND
				i.date_valid_to BETWEEN f.start_date AND f.end_date
			)
		)
		BEGIN
			;THROW 50001, 'Ticket datums liggen niet tussen de start- en einddatum van het festival.', 1
		END
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

INSERT INTO FESTIVAL_COMPANY VALUES ('01010101', 3, 'L. Chen', 'Verkoopt tickets', '0612345678')

INSERT INTO TICKET_TYPE VALUES ('01010101', 3, 'Normale ticket', 500.00, '13-12-2017 11:00:00', '17-12-2017 23:00:00')