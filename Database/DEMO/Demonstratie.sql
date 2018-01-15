/* ================================	*/
/*			Demonstratie			*/
/* ================================	*/

USE FestiBaseDEMO
GO


/*
	De volgende tests gelden voor alle add_or_update procedures. Deze
	tests triggeren namelijk een error bij een poging tot een update.

	De eerste test triggert een error die aangeeft dat er geen NULL waarden 
	aan de surrogaat sleutel variable meegegeven kan worden als er een update
	uitgevoerd moet worden.

	De tweede test triggert een error die aangeeft dat de meegeven surrogaat sleutel
	niet bestaat. Dat moet natuurlijk wel het geval zijn om een update uit te voeren.
*/

BEGIN TRAN
EXEC sp_add_or_update_tent NULL, 1, 'Test Tent', 1200, 2000, 500, 1000, 1400, 3300, 
	'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000, 0
ROLLBACK TRAN
GO

BEGIN TRAN
EXEC sp_add_or_update_tent 300, 1, 'Test Tent', 1200, 2000, 500, 1000, 1400, 3300, 
	'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000, 0
ROLLBACK TRAN
GO


/* ================================	*/
/*				TENT				*/
/* ================================	*/

/*
	De volgende tests triggeren de check constraints die aan de tabel TENT zijn toegevoegd.
*/

-- Correcte INSERT
BEGIN TRAN
EXEC sp_add_or_update_tent NULL, 1, 'Test Tent', 1200, 2000, 500, 1000, 1400, 3300, 
	'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000, 1
ROLLBACK TRAN
GO

-- Correcte UPDATE
BEGIN TRAN
EXEC sp_add_or_update_tent 1, 1, 'Test Tent', 1200, 2000, 500, 1000, 1400, 3300, 
	'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000, 0
ROLLBACK TRAN
GO

-- Foute INSERT (Constructiebreedte moet groter of gelijk zijn aan de breedte)
BEGIN TRAN
EXEC sp_add_or_update_tent NULL, 1, 'Test Tent', 4200, 2000, 500, 1000, 1400, 3300, 
	'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000, 1
ROLLBACK TRAN
GO

-- Foute INSERT (Constructielengte moet groter of gelijk zijn aan de lengte)
BEGIN TRAN
EXEC sp_add_or_update_tent NULL, 1, 'Test Tent', 1200, 4000, 500, 1000, 1400, 3300, 
	'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000, 1
ROLLBACK TRAN
GO

-- Foute INSERT (hoogte moet groter of gelijk zijn aan de zijhoogte)
BEGIN TRAN
EXEC sp_add_or_update_tent NULL, 1, 'Test Tent', 1200, 1200, 5000, 1000, 1400, 3300, 
	'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000, 1
ROLLBACK TRAN
GO


/* ================================	*/
/*				PODIUM				*/
/* ================================	*/

/*
	De volgende tests triggeren de check constraints die aan de tabel PODIUM zijn toegevoegd.
*/

-- Correcte INSERT
BEGIN TRAN
EXEC sp_add_or_update_podium NULL, 1, 2, 'TentDestructo', 2000,2000,500, 
	50, 5000, 50, 1900, 1700, 400, 'Leuke podium voor een leuke festival', 1    
ROLLBACK TRAN
GO

--Correcte UDPATE
BEGIN TRAN
EXEC sp_add_or_update_podium 1, 1, 2, 'TentDestructo', 2000,2000,500, 
	50, 5000, 50, 1900, 1700, 400, 'Leuke podium voor een leuke festival', 0 
ROLLBACK TRAN
GO

-- Foute INSERT (Constructiebreedte moet groter zijn dan de vrije overspanning breedte)
BEGIN TRAN
EXEC sp_add_or_update_podium NULL, 1, 2, 'TentDestructo', 200,2000,500, 
	50, 5000, 50, 1900, 1700, 400, 'Leuke podium voor een leuke festival', 1    
ROLLBACK TRAN
GO

-- Foute INSERT (Constructielengte moet groter zijn dan de vrije overspanning lengte)
BEGIN TRAN
EXEC sp_add_or_update_podium NULL, 1, 2, 'TentDestructo', 2000,200,500, 
	50, 5000, 50, 1900, 1700, 400, 'Leuke podium voor een leuke festival', 1    
ROLLBACK TRAN
GO

-- Foute INSERT (Podiumhoogte moet groter zijn dan de vrije overspanning hoogte)
BEGIN TRAN
EXEC sp_add_or_update_podium NULL, 1, 2, 'TentDestructo', 2000,2000,10, 
	50, 5000, 50, 1900, 1700, 400, 'Leuke podium voor een leuke festival', 1    
ROLLBACK TRAN
GO


/* ================================	*/
/*			PERFORMANCE				*/
/* ================================	*/


/*
	De constraints op performance checken het volgende:
	-	Of de artiest al een optreden
	-	Of er al een artiest op dat moment op hetzelfde podium speelt
	-	De starttijd van het optreden mag niet bekend zijn als het podium ook niet bekend is
	-	Of het optreden past in dat podium schema (na een update)
*/

/* 
	These tests should work
*/

-- INSERT
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, 4, 2, '15:00:00', 90, 30, 1 
ROLLBACK TRAN
GO

BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, NULL, 2, NULL, 90, NULL, 1 
ROLLBACK TRAN
GO

BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, NULL, 2, NULL, 90, 30, 1 
ROLLBACK TRAN
GO

-- UPDATE
BEGIN TRAN
EXEC sp_add_or_update_performance 10, 8, 4, 2, '15:00:00', 90, 30, 0 
ROLLBACK TRAN
GO

BEGIN TRAN
EXEC sp_add_or_update_performance 10, 8, NULL, 2, NULL, 90, 30, 0
ROLLBACK TRAN
GO


/*
	These tests should NOT work
*/

-- INSERT (An artist is already playing during that time)
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, 4, 2, '20:00:00', 90, 30, 1 
ROLLBACK TRAN
GO

-- INSERT (This artist is already going to perform during that time)
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 9, 4, 2, '21:00:00', 90, 30, 1 
ROLLBACK TRAN
GO

-- INSERT (The start_time cannot be known if the schedule is NULL)
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, NULL, 2, '15:00:00', 90, 30, 1 
ROLLBACK TRAN
GO

-- INSERT (This performance does not fit the schedule)
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 8, 4, 2, '13:59:00', 90, 30, 1 
ROLLBACK TRAN
GO

-- INSERT (The artist has the wrong genre for this podium)
BEGIN TRAN
EXEC sp_add_or_update_performance NULL, 2, 1, 2, '14:00:00', 30, 5, 1
ROLLBACK TRAN
GO

-- UPDATE (An artist is already playing during that time)
BEGIN TRAN
EXEC sp_add_or_update_performance 9, 8, 4, 2, '20:00:00', 90, 30, 0
ROLLBACK TRAN
GO

-- UPDATE (This artist is already going to perform during that time)
BEGIN TRAN
EXEC sp_add_or_update_performance 9, 9, 4, 2, '21:00:00', 90, 30, 0 
ROLLBACK TRAN
GO

-- UPDATE (The start_time cannot be known if the schedule is NULL)
BEGIN TRAN
EXEC sp_add_or_update_performance 9, 8, NULL, 2, '15:00:00', 90, 30, 0 
ROLLBACK TRAN
GO

-- UPDATE (This performance does not fit the schedule)
BEGIN TRAN
EXEC sp_add_or_update_performance 9, 8, 4, 2, '13:59:00', 90, 30, 0
ROLLBACK TRAN
GO

-- UPDATE (The artist has the wrong genre for this podium)
BEGIN TRAN
EXEC sp_add_or_update_performance 2, 2, 1, 2, '14:00:00', 30, 5, 1
ROLLBACK TRAN
GO


/* ================================	*/
/*			PODIUM_SCHEDULE			*/
/* ================================	*/

/*
	De volgende constraints checken het volgende:
	- Of de startdatum van een podium schema binnen de festivals datums vallen
	- Of de einddatum van een podium schema binnen de festivals datums vallen
*/


-- Correcte INSERT
BEGIN TRAN
EXEC sp_add_or_update_podium_schedule NULL, 1, '2017-04-15', '14:00:00', '2017-04-16', '02:00:00', 30, 1
ROLLBACK TRAN
GO

-- Correcte UPDATE
BEGIN TRAN
EXEC sp_add_or_update_podium_schedule 1, 1, '2017-04-15', '14:00:00', '2017-04-16', '02:00:00', 30, 0
ROLLBACK TRAN
GO

-- Test INSERT (end date not valid)
BEGIN TRAN
EXEC sp_add_or_update_podium_schedule NULL, 1, '2017-04-16', '14:00:00', '2017-04-17', '02:00:00', 30, 1
ROLLBACK TRAN
GO

-- Test INSERT (start date not valid)
BEGIN TRAN
EXEC sp_add_or_update_podium_schedule NULL, 1, '2017-04-13', '14:00:00', '2017-04-14', '02:00:00', 30, 1
ROLLBACK TRAN
GO