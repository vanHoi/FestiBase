/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version		6											*/
/* Last edited:		19-12-2017									*/
/* Created by:		Robert Verkerk								*/
/* Edited by:		Yuri Vannisselroy & Ivo Reumkens		    */
/* Converted to procedures by:	Ivo Reumkens					*/
/* Script:			DML											*/
/*==============================================================*/

USE FestiBase
GO

SET DATEFORMAT DMY
GO

-- Town and Country get inserted automagically

-- Organisation
EXEC sp_add_or_update_organisation NULL, 'Paaspop', 1
EXEC sp_add_or_update_organisation NULL, 'Pinkpop', 1
EXEC sp_add_or_update_organisation NULL, 'Emporium', 1
EXEC sp_add_or_update_organisation NULL, 'Rock Am', 1
EXEC sp_add_or_update_organisation NULL, 'Yuri B.V.', 1
GO

-- Festival
EXEC sp_add_or_update_festival null, 1, 'Paaspop 2017', '14-04-2017 00:00:00', '16-04-2017 23:59:00', 'Schijndel', '2.50', 1
EXEC sp_add_or_update_festival null, 1, 'Paaspop 2018', '30-03-2018 00:00:00', '01-04-2018 23:59:00', 'Schijndel', '3.00', 1
EXEC sp_add_or_update_festival null, 2, 'Pinkpop 2018', '15-06-2018 00:00:00', '17-06-2018 23:59:00', 'Megaland Landgraaf', '3.00', 1
EXEC sp_add_or_update_festival null, 4, 'Rock Am Ring 2018', '01-06-2018 00:00:00', '03-06-2018 23:59:00', 'Nürburgring', '3.00', 1
EXEC sp_add_or_update_festival null, 5, 'The Iron iYuriZ Fest', '30-03-2018 00:00:00', '01-04-2018 23:59:00', 'Goffertpark', '4.00', 1
GO

-- Company
EXEC sp_add_or_update_company 23456001, 'Hans Hamburgers', 1
EXEC sp_add_or_update_company 23456002, 'Leons Wilde Rit', 1
EXEC sp_add_or_update_company 23456003, 'Roberts Neef Tent Verhuur', 1
EXEC sp_add_or_update_company 23456004, 'Ivos Podiums', 1
EXEC sp_add_or_update_company 23456005, 'Heineken', 1
EXEC sp_add_or_update_company 23456006, 'Chris Attracties', 1
EXEC sp_add_or_update_company 23456007, 'Tentencompany', 1
EXEC sp_add_or_update_company 23456008, 'Mac Donalds', 1
EXEC sp_add_or_update_company 23456009, 'Burger King', 1
EXEC sp_add_or_update_company 23456010, 'Marios Inbreekservices', 1
EXEC sp_add_or_update_company 23456011, 'Leons Kaartjes Oplichterijen', 1
EXEC sp_add_or_update_company 23456012, 'D-Records', 1
EXEC sp_add_or_update_company 23456013, 'Maiks Mooie Maikletten', 1
GO

-- Company Branch
EXEC sp_add_or_update_company_branch NULL, 23456001, 'Aleidestraat', '15', 'Nijmegen', 'Nederland', 1
EXEC sp_add_or_update_company_branch NULL, 23456002, 'Leonstraat', '15', 'Roermond', 'Nederland', 1
EXEC sp_add_or_update_company_branch NULL, 23456003, 'Hatertseweg', '123', 'Cuijk', 'Nederland', 1
EXEC sp_add_or_update_company_branch NULL, 23456004, 'Schijndelseweg', '5A', 'Schijndel', 'Nederland', 1
EXEC sp_add_or_update_company_branch NULL, 23456005, 'Schijndelseweg', '5B', 'Schijndel', 'Nederland', 1
EXEC sp_add_or_update_company_branch NULL, 23456006, 'Maaskantjeseweg', '5', 'Maaskantje', 'Nederland', 1
EXEC sp_add_or_update_company_branch NULL, 23456007, 'Grotestraat', '2', 'Landgraaf', 'Nederland', 1
EXEC sp_add_or_update_company_branch NULL, 23456008, 'Hondenkaas', '25', 'Arnhem', 'Nederland', 1
EXEC sp_add_or_update_company_branch NULL, 23456009, 'Datdorp', '27', 'Landgraaf', 'Nederland', 1
EXEC sp_add_or_update_company_branch NULL, 23456010, 'Oplichtersstraat', '1', 'Cuijk', 'Nederland', 1
EXEC sp_add_or_update_company_branch NULL, 23456011, 'Coolestraat', '28', 'Landgraaf', 'Nederland', 1
EXEC sp_add_or_update_company_branch NULL, 23456012, 'Lankforst', '29', 'Nürburg', 'Duitsland', 1
EXEC sp_add_or_update_company_branch NULL, 23456012, 'Lakforst', '28', 'Norberg', 'Nederland', 1
EXEC sp_add_or_update_company_branch NULL, 23456013, 'Maikweg', '45', 'Cuijk', 'Nederland', 1
GO

-- Festival Company
EXEC sp_add_or_update_festival_company NULL, 1, 1, 'Hans G.', 'De beste hamburgers ter wereld!', 0612312312, 1
EXEC sp_add_or_update_festival_company NULL, 1, 2, 'Leon Chen', 'Voor de beste wilde ritjes!', 0612314514, 1
EXEC sp_add_or_update_festival_company NULL, 1, 3, 'Robert Verkerk', 'Tent verhuur', 0612345678, 1
EXEC sp_add_or_update_festival_company NULL, 1, 4, 'Ivo Reumkens', 'De beste podias!', 0612345678, 1
EXEC sp_add_or_update_festival_company NULL, 1, 5, 'Freddie Heineken', 'Ja, bier!!', 0271234567, 1
EXEC sp_add_or_update_festival_company NULL, 2, 6, 'Chris S.', 'Attracties van Chris', 0698765432, 1
EXEC sp_add_or_update_festival_company NULL, 1, 7, 'Jan', 'Tentverhuur', 0698765432, 1
EXEC sp_add_or_update_festival_company NULL, 1, 8, 'Mac Donalds', 'Voedselcatering', 0624577885, 1
EXEC sp_add_or_update_festival_company NULL, 2, 9, 'Ham Burgers', 'Hamburgerbar', 0687433772, 1
EXEC sp_add_or_update_festival_company NULL, 1, 10, 'Mario De Inbreker', 'Kluisjesverhuurdbedrijf', 0654188745, 1
EXEC sp_add_or_update_festival_company NULL, 2, 10, 'Mario De Inbreker', 'Kluisjesverhuurdbedrijf', 0654188745, 1
EXEC sp_add_or_update_festival_company NULL, 1, 11, 'Leon De Oplichter', 'Ticket bedrijf', 0654788412, 1
EXEC sp_add_or_update_festival_company NULL, 2, 11, 'Leon De Oplichter', 'Ticket bedrijf', 0654788412, 1
EXEC sp_add_or_update_festival_company NULL, 1, 12, 'Dirk Records',  'Manager 3ROBI', 0689702314, 1
EXEC sp_add_or_update_festival_company NULL, 2, 12, 'Dirk Records',  'Manager 3ROBI', 0689702314, 1
EXEC sp_add_or_update_festival_company NULL, 2, 3, 'Claudia Verkerk', 'Tent verhuur', 0612345671, 1
EXEC sp_add_or_update_festival_company NULL, 2, 4, 'Ivo Reumkens', 'De beste podias!', 0612345678, 1
EXEC sp_add_or_update_festival_company NULL, 1, 14, 'Maik C.', 'De mooiste toiletten!', 0612345678, 1
EXEC sp_add_or_update_festival_company NULL, 3, 3, 'Roberta Verkerk', 'Tent verhuur', 0612345679, 1
EXEC sp_add_or_update_festival_company NULL, 3, 4, 'Joost Reumkens', 'De beste podias!', 0612345678, 1
GO

-- Artist
EXEC sp_add_or_update_artist NULL, 'Rapper Sjors', 1
EXEC sp_add_or_update_artist NULL, 'Darude', 1
EXEC sp_add_or_update_artist NULL, 'Donald Trump', 1
EXEC sp_add_or_update_artist NULL, 'PSY', 1
EXEC sp_add_or_update_artist NULL, 'Rapper Boef', 1
EXEC sp_add_or_update_artist NULL, 'Je Broer', 1
EXEC sp_add_or_update_artist NULL, 'Je Moeder', 1
EXEC sp_add_or_update_artist NULL, 'Gordon', 1
EXEC sp_add_or_update_artist NULL, 'Gerard Joling', 1
EXEC sp_add_or_update_artist NULL, 'Geer VS Goor', 1
EXEC sp_add_or_update_artist NULL, 'Vitas', 1
EXEC sp_add_or_update_artist NULL, 'Ylvis', 1
EXEC sp_add_or_update_artist NULL, 'Zanger Rinus', 1
EXEC sp_add_or_update_artist NULL, 'Mark Rutte', 1
EXEC sp_add_or_update_artist NULL, 'Günther', 1
GO

-- Artist File
EXEC sp_add_or_update_artist_file  NULL, 2, 14, 'Contract Darude', 'Het contract van Darude', 1
EXEC sp_add_or_update_artist_file  NULL, 7, 15, 'Contract Je Moeder', 'Het contract van Je Moeder', 1
EXEC sp_add_or_update_artist_file  NULL, 1, 15, 'Setlist Rapper Sjors', 'De setlist van de Rapper Sjors', 1
GO

-- Visitor
EXEC sp_add_or_update_visitor NULL, 'robertverkerk@hetnet.nl', 'Robert', 'Verkerk', 0612345678, '15-07-1995', 'robert_verkerk', 'robert.verkerk', 'Robertstraat', 16, 'Cuijk', 'Nederland', 1
EXEC sp_add_or_update_visitor NULL, 'mario@hotmail.com', 'Mariusz', 'Blautzik', 0632165487, '07-08-1991', NULL, 'mariuszBlautzik', 'Mariostraat', 1, 'Cuijk', 'Nederland', 1
EXEC sp_add_or_update_visitor NULL, 'ivoreum@gmail.com', 'Ivo', 'Reumkens', 0632141587, '16-07-1996', NULL, NULL, 'Ivostraat', 2, 'Vlijmen', 'Nederland', 1
EXEC sp_add_or_update_visitor NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1
GO

-- Ticket Type
EXEC sp_add_or_update_ticket_type 12, 'Premium Ticket', 75, '14-04-2017 00:00:00', '16-04-2017 23:59:00', 1
EXEC sp_add_or_update_ticket_type 12, 'Ultra Weekend Ticket', 5000, '14-04-2017 00:00:00', '16-04-2017 23:59:00', 1
EXEC sp_add_or_update_ticket_type 12, 'Normaal Ticket', 50, '14-04-2017 00:00:00', '16-04-2017 23:59:00', 1
EXEC sp_add_or_update_ticket_type 13, 'VIP Ticket', '120', '30-03-2018 00:00:00', '01-04-2018 23:59:00', 1
EXEC sp_add_or_update_ticket_type 13, 'Dagticket', '50', '30-03-2018 00:00:00', '01-04-2018 23:59:00', 1
EXEC sp_add_or_update_ticket_type 13, 'Weekendticket', '50', '30-03-2018 00:00:00', '01-04-2018 23:59:00', 1
EXEC sp_add_or_update_ticket_type 13, 'Weekendticket incl Camping', '50', '30-03-2018 00:00:00', '01-04-2018 23:59:00', 1
GO

-- Bought Ticket
EXEC sp_add_or_update_bought_ticket NULL, 12, 'Premium Ticket', 1, NULL, 1
EXEC sp_add_or_update_bought_ticket NULL, 12, 'Normaal Ticket', 2, NULL, 1
EXEC sp_add_or_update_bought_ticket NULL, 12, 'Ultra Weekend Ticket', 3, NULL, 1
EXEC sp_add_or_update_bought_ticket NULL, 12, 'Premium Ticket', NULL, NULL, 1
EXEC sp_add_or_update_bought_ticket NULL, 12, 'Normaal Ticket', NULL, NULL, 1
EXEC sp_add_or_update_bought_ticket NULL, 12, 'Ultra Weekend Ticket', NULL, NULL, 1
EXEC sp_add_or_update_bought_ticket NULL, 13, 'Dagticket', 1, NULL, 1
EXEC sp_add_or_update_bought_ticket NULL, 13, 'Weekendticket', 2, NULL, 1
EXEC sp_add_or_update_bought_ticket NULL, 13, 'Weekendticket incl Camping', 3, NULL, 1
EXEC sp_add_or_update_bought_ticket NULL, 13, 'Dagticket', NULL, NULL, 1
EXEC sp_add_or_update_bought_ticket NULL, 13, 'Weekendticket', NULL, NULL, 1
EXEC sp_add_or_update_bought_ticket NULL, 13, 'Weekendticket incl Camping', NULL, NULL, 1
GO

-- Catering
EXEC sp_add_or_update_catering 0, 1, 1, 'Hamburgerbar', 1
EXEC sp_add_or_update_catering 0, 2, 1, 'Hamburgertent', 1
EXEC sp_add_or_update_catering 0, 7, 1, 'Hamburgertent', 1
EXEC sp_add_or_update_catering 0, 8, 0, 'Bierkar', 1
GO

-- Festival Company File
EXEC sp_add_or_update_festival_company_file NULL, 1, 'path/to/file.pdf', 'Recept Beste Hamburger Ooit!', 1
EXEC sp_add_or_update_festival_company_file NULL, 2, 'file/path.jpg', 'Afbeelding wilde attractie', 1
GO

-- Genre
EXEC sp_add_or_update_genre NULL, 'Rock', 1
EXEC sp_add_or_update_genre NULL, 'Klassiek', 1
EXEC sp_add_or_update_genre NULL, 'Rap', 1
EXEC sp_add_or_update_genre NULL, 'Metal', 1
EXEC sp_add_or_update_genre NULL, 'Hardstyle', 1
EXEC sp_add_or_update_genre NULL, 'Trance', 1
EXEC sp_add_or_update_genre NULL, 'Pop', 1
EXEC sp_add_or_update_genre NULL, 'HipHop', 1
EXEC sp_add_or_update_genre NULL, 'Electric', 1
EXEC sp_add_or_update_genre NULL, 'Dance', 1
EXEC sp_add_or_update_genre NULL, 'Dubstep', 1
EXEC sp_add_or_update_genre NULL, 'House', 1
EXEC sp_add_or_update_genre NULL, 'Techno', 1
EXEC sp_add_or_update_genre NULL, 'Drum & Bass', 1
GO

-- Genre of Artist
EXEC sp_add_genre_of_artist 1, 1
EXEC sp_add_genre_of_artist 2, 3
EXEC sp_add_genre_of_artist 3, 3
GO

-- Genre preference Visitor
EXEC sp_add_genre_preference_visitor 1, 1
EXEC sp_add_genre_preference_visitor 1, 2
EXEC sp_add_genre_preference_visitor 2, 3
EXEC sp_add_genre_preference_visitor 3, 4
GO

-- Locker
EXEC sp_add_or_update_locker NULL, 10, 1
EXEC sp_add_or_update_locker NULL, 10, 1
EXEC sp_add_or_update_locker NULL, 10, 1
EXEC sp_add_or_update_locker NULL, 10, 1
EXEC sp_add_or_update_locker NULL, 10, 1
EXEC sp_add_or_update_locker NULL, 10, 1
EXEC sp_add_or_update_locker NULL, 10, 1
EXEC sp_add_or_update_locker NULL, 10, 1
EXEC sp_add_or_update_locker NULL, 10, 1
EXEC sp_add_or_update_locker NULL, 10, 1
EXEC sp_add_or_update_locker NULL, 11, 1
EXEC sp_add_or_update_locker NULL, 11, 1
EXEC sp_add_or_update_locker NULL, 11, 1
EXEC sp_add_or_update_locker NULL, 11, 1
GO

-- Locker Rented
EXEC sp_add_or_update_locker_rented 1, '14-04-2017 08:12:23', '16-04-2017 22:59:17', 1, 1
EXEC sp_add_or_update_locker_rented 2, '14-04-2017 10:00:43', NULL, 2, 1
EXEC sp_add_or_update_locker_rented 11, '30-03-2018 14:37:23', NULL, 3, 1
EXEC sp_add_or_update_locker_rented 12, '31-03-2018 10:37:12', '31-03-2018 23:23:56', 4, 1
GO

-- Tent
EXEC sp_add_or_update_tent NULL, 1, 'Tent 1', 1800, 2500, 900, 1500, 1900, 2700, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000, 1
EXEC sp_add_or_update_tent NULL, 1, 'Tent 2', 5000, 3000, 400, 800, 5200, 3200, 'Pagode', 'wit', 'cassetevloer', 10000, 1
EXEC sp_add_or_update_tent NULL, 2, 'Hele Grote Tent', 3000, 2500, 500, 1000, 3100, 3000, 'Grote Tent voor meerdere podiums', 'Blauw-wit', 'Systeemvloer', 12000, 1
GO

-- Podium
EXEC sp_add_or_update_podium 0, 1, NULL, 'Heineken Stage', 1500, 1000, 700, 100, 12000, 100, 1400, 800, 600, 'description of environment', 1
EXEC sp_add_or_update_podium 0, 1, 1, 'PopPodium', 1500, 1200, 700, null, 9000, 50, 1300, 1000, 600, 'beautiful trees', 1
EXEC sp_add_or_update_podium 0, 2, 3, 'Tent Stage Main', 1900, 1200, 800, 150, 30, 120, 1800, 1100, 600, 'Krappe tent', 1
EXEC sp_add_or_update_podium 0, 2, 3, 'Tent Stage Small', 1600, 1300, 800, 150, 30, 120, 1500, 1200, 600, 'Krappe tent', 1
EXEC sp_add_or_update_podium 0, 3, NULL, 'Main Stage', 3500, 1200, 800, 150, 30, 120, 800, 700, 600, 'Hele grote open ruimte', 1
GO

-- Podium Schedule
EXEC sp_add_or_update_podium_schedule NULL, 1, '14-04-2017', '14:00:00', '14-04-2017', '23:00:00', 15, 1
EXEC sp_add_or_update_podium_schedule NULL, 2, '14-04-2017', '10:00:00', '14-04-2017', '23:30:00', 30, 1
EXEC sp_add_or_update_podium_schedule NULL, 3, '31-03-2018', '10:00:00', '31-03-2018', '23:30:00', 60, 1
EXEC sp_add_or_update_podium_schedule NULL, 5, '15-06-2018', '14:00:00', '15-06-2018', '22:30:00', 60, 1
EXEC sp_add_or_update_podium_schedule NULL, 5, '16-06-2018', '14:00:00', '16-06-2018', '23:00:00', 60, 1
EXEC sp_add_or_update_podium_schedule NULL, 5, '17-06-2018', '10:00:00', '17-06-2018', '23:00:00', 0, 1
GO

-- Performance
EXEC sp_add_or_update_performance NULL, 1, 1, 1, '14-04-2017', '14:00:00', 60,  15, 1
EXEC sp_add_or_update_performance NULL, 2, NULL, 1, '14-04-2017', NULL, 30,  30, 1
EXEC sp_add_or_update_performance NULL, 3, 2, 1, '14-04-2017', NULL, 60, 15, 1
EXEC sp_add_or_update_performance NULL, 4, 2, 1, '14-04-2017', NULL, 75, 60, 1
EXEC sp_add_or_update_performance NULL, 5, 2, 1, '14-04-2017', '10:00:00', 60,  15, 1
EXEC sp_add_or_update_performance NULL, 6, 3, 2, '31-03-2018', '18:00:00', 60, 15, 1
EXEC sp_add_or_update_performance NULL, 7, 3, 2, '31-03-2018', '20:15:00', 45, 15, 1
EXEC sp_add_or_update_performance NULL, 8, 4, 3, '15-06-2018', '21:15:00', 75, 15, 1
EXEC sp_add_or_update_performance NULL, 9, 5, 3, '16-06-2018', NULL, 90, 30, 1
EXEC sp_add_or_update_performance NULL, 10, 5, 3, '16-06-2018','21:00:00', 120,  30, 1
EXEC sp_add_or_update_performance NULL, 11, 6, 3, '17-06-2018', '21:15:00', 90, 0, 1
GO

-- Podium File
EXEC sp_add_or_podium_file NULL, 1, 4, 'path/to/buildingbook.pdf', 'A beautiful description!! :D', 1
EXEC sp_add_or_podium_file NULL, 2, 17, 'path/to/file.pdf', 'A description', 1
GO

-- Podium plays Genre
EXEC sp_add_podium_plays_genre 1, 1
GO

-- Tent File
EXEC sp_add_or_tent_file NULL, 1, 3, 'path/to/file.pdf', 'Factuur huur tent', 1
EXEC sp_add_or_tent_file NULL, 2, 16, 'file/path.jpg', 'Bouwplan Tent', 1
GO

-- Toilet
EXEC sp_add_or_update_toilet NULL, 18, 'Maikletten Plein 1', 500, 1
EXEC sp_add_or_update_toilet NULL, 1, 'Maikinoirs 1', 50, 1
GO

-- Visitor likes Performance
EXEC sp_add_visitor_likes_performance 1, 2
EXEC sp_add_visitor_likes_performance 1, 1
EXEC sp_add_visitor_likes_performance 2, 1
EXEC sp_add_visitor_likes_performance 1, 9
EXEC sp_add_visitor_likes_performance 2, 9
EXEC sp_add_visitor_likes_performance 3, 9
EXEC sp_add_visitor_likes_performance 4, 9
GO

-- Visitor visited Performance
EXEC sp_add_visitor_visited_performance 1, 1
EXEC sp_add_visitor_visited_performance 1, 2
EXEC sp_add_visitor_visited_performance 2, 1
GO

USE master
GO
