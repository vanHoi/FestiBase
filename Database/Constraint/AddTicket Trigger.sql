CREATE TRIGGER TRG_VALID_TICKET ON TICKET_TYPE
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


--Tests
