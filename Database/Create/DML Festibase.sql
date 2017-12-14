/*==============================================================*/
/* DBMS name:      FestiBase									*/
/* PDM version 5												*/
/* testdata													    */
/*==============================================================*/

USE master
GO

USE FestiBase
GO

SET DATEFORMAT DMY
GO

INSERT INTO ARTIST (artist_name) VALUES
('3ROBI'),
('B-Front'),
('De Toppers'),
('Justin Bieber'),
('Big Shaq'),
('Eminem'),
('Rapper Sjors')
GO

INSERT INTO ORGANISATION (name) VALUES
('Paaspop'),
('Pinkpop'),
('Emporium')
GO

INSERT INTO FESTIVAL (organisation_number, name, start_date, end_date, location, token_price) VALUES
(1, 'Paaspop 2017', convert(datetime, '15-07-2017 00:00:00', 105), convert(datetime, '17-07-2017 00:00:00', 105), 'Schijndel', '2.50'),
(1, 'Paaspop 2018', convert(datetime, '15-07-2018 00:00:00', 105), convert(datetime, '17-07-2018 00:00:00', 105), 'Schijndel', '3.00'),
(2, 'Pinkpop 2018', convert(datetime, '15-06-2018 00:00:00', 105), convert(datetime, '17-06-2018 00:00:00', 105), 'Megaland Landgraaf', '3.00')
GO

INSERT INTO COUNTRY (country_name) VALUES
('Nederland'),
('Duitsland'),
('Belgie')
GO


INSERT INTO TOWN (country_number, town_name) VALUES
(1, 'Cuijk'),
(1, 'Nijmegen'),
(1, 'Schijndel')
GO

INSERT INTO COMPANY (coc_number, name) VALUES
(23456001,'Henks Hamburgers'),
(23456002,'Roys Reuzenrad'),
(23456003,'Verkerk Verhuur'),
(23456004,'Piets Podiums'),
(23456005,'Heineken'),
(23456006,'Aries Attracties'),
(23456007,'Tentencompany'),
(23456008,'Stagecompany'),
(23456045, 'Burger King'),
(23456046, 'Roberts Inbreekservices'),
(23456048, 'Leons Kaartjes Oplichterijen'),
(23456060, 'D-Records'),
(23456061, 'Music HQ')
GO

INSERT INTO COMPANY_BRANCH(coc_number, town_number, street, house_number) VALUES
(23456003, 1, 'aleidestraat', '15'),
(23456005, 2, 'Hatertseweg', '123'),
(23456006, 1, 'schijndelseweg', '5'),
(23456006, 2, 'maaskantjeseweg', '5'),
(23456001, 3, 'grotestraat', '2'),
(23456001, 2, 'hondenkaas', '25'),
(23456005, 1, 'datdorp', '27'),
(23456045, 1, 'Coolestraat', '28'),
(23456045, 3, 'Coolestraat', '28'),
(23456048, 3, 'Oplichtersstraat', '1'),
(23456060, 2, 'Lankforst', '29'),
(23456061, 2, 'Lankforst', '28')
GO

INSERT INTO FESTIVAL_COMPANY (branch_number, festival_number, contact_person, description, telephone_number) VALUES
(1, 1, 'Robert Verkerk', 'Tent verhuur', '0612345678'),
(2, 1, 'Freddie Heineken', 'Ja, bier!!', '0271234567'),
(3, 1, 'Henk van Amstel', 'Attractieverhuur', '0698765432'),
(4, 2, 'Klaas van Heineken', 'Attractieverhuur', '0698478512'),
(5, 3, 'Frida Heemskerk', 'hamburgerbar', '0611122233'),
(6, 2, 'Mac Donalds', 'Voedselcatering', '0624577885'),
(7, 3, 'Ham Burgers', 'Hamburgerbar', '0687433772'),
(8, 1, 'Robert De Inbreker', 'Kluisjesverhuurdbedrijf', '0654188745'),
(9, 2, 'Robert De Inbreker', 'Kluisjesverhuurdbedrijf', '0654188745'),
(10, 1, 'Leon De Oplichter', 'Ticket bedrijf', '0654788412'),
(11, 1, 'Dirk Records',  'Manager 3ROBI', '0689702314'),
(12, 1, 'Mary Headquarters', 'Manager B-Front', '0612449983')
GO

INSERT INTO ARTIST_FILE (artist_number, branch_number, festival_number, "file", description) VALUES
(1, 11, 1, 'contract 3ROBI', 'Het contract van 3ROBI'),
(2, 12, 1, 'contract B-Front', 'Het contract van B-Front')

INSERT INTO ATTRACTION (branch_number, festival_number, name, attraction_type) VALUES
(3, 1, 'Henks Draaimolen', 'Draaimolen'),
(4, 2, 'Booster', 'Booster'),
(8, 1, 'Booster', 'Booster'),
(9, 2, 'Das Omen', 'Spookhuis')
GO

INSERT INTO VISITOR (email, first_name, surname) VALUES
('robertverkerk@hetnet.nl', 'Robert', 'Verkerk'),
('mariusssss@gmail.com', 'Mariuszsz', 'Blautzik'),
('ivorr@reumkens.nl', 'Ivo', 'Reumkens'),
(null, null, null)
GO

INSERT INTO TICKET_TYPE (branch_number, festival_number, ticket_type, price, date_valid_from, date_valid_to) VALUES
(10, 1, 'Premium ticket', '75', GETDATE(), GETDATE() + 3),
(10, 1, 'VIP', '120', GETDATE(), GETDATE() + 1),
(10, 1, 'dagticket', '50', GETDATE(), GETDATE() + 3)
GO

INSERT INTO BOUGHT_TICKET (branch_number, festival_number, ticket_type, visitor_number) VALUES
(10, 1, 'Premium ticket', 1),
(10, 1, 'Premium ticket', 1),
(10, 1, 'VIP', 2)
GO

INSERT INTO CATERING (branch_number, festival_number, name, electricity) VALUES
(1, 1, 'Hamburgerbar', 1),
(2, 1, 'Friettent', 1),
(7, 3, 'Tacos', 1),
(8, 1, 'Bierkar', 0)
GO

INSERT INTO FESTIVAL_COMPANY_FILE (branch_number, festival_number, "file", description) VALUES
(1, 1, 'path/to/file.pdf', 'factuur huur tent'),
(3, 1, 'file/path.jpg', 'afbeelding attractie')
GO

INSERT INTO GENRE (genre) VALUES
('Rap'),
('Nederlands'),
('Pop'),
('Hardstyle')
GO

INSERT INTO GENRE_of_ARTIST (genre_number, artist_number) VALUES
(1, 1),
(3, 1),
(2, 3),
(4, 7)
GO

INSERT INTO GENRE_preference_VISITOR (visitor_number, genre_number) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4)
GO

INSERT INTO LOCKER (branch_number, festival_number) VALUES
(8, 1),
(8, 1),
(8, 1),
(8, 1),
(8, 1),
(8, 1),
(8, 1),
(8, 1),
(8, 1),
(8, 1),
(8, 1),
(8, 1),
(8, 1),
(8, 1),
(8, 1),
(8, 1)
GO

INSERT INTO LOCKER_RENTED (locker_number, visitor_number, start_date, end_date) VALUES
(1, 1, convert(datetime, '15-07-2017 00:00:00', 105), convert(datetime, '17-07-2017 00:00:00', 105)),
(2, 3, convert(datetime, '15-07-2017 00:00:00', 105), null)
GO

INSERT INTO TENT (festival_number, name, width, length, side_height, ridge_height, construction_width, construction_length, tent_type, color, floor_type, capacity) VALUES
(1, 'tent1', 3000, 5000, 240, 400, 5200, 3200, 'aluhal', 'wit', 'dansvloer', 10000),
(2, 'tent2', 3000, 5000, 240, 400, 5200, 3200, 'pagode', 'wit', 'cassetevloer', 1000),
(1, 'Hele Grote Tent', 1300, 2000, 500, 1000, 1500, 3300, 'Grote Tent voor meerdere podiums', 'Blauw-wit', 'Systeemvloer', 12000) 
GO

INSERT INTO PODIUM (festival_number, tent_number, name, construction_width, construction_length, floor_height, construction_height, capacity, floor_load, free_span_width, free_span_length, free_span_height, environment, time_between_performances) VALUES
(1, NULL, 'Heineken Stage', 1500, 1000, 400, 600, 50, 12000, 800, 1400, 900, 'description of environment', 60),
(1, 2, 'PopPodium', 1500, 1200, NULL, 700, 100, 12000, 800, 1000, 900, 'beautiful trees', 60)
GO

INSERT INTO PERFORMANCE (podium_number, artist_number, festival_number, date, start_time, play_time, time_between_performances_override) VALUES
(1, 1, 1, '15-07-2018', convert(varchar(8), '12:00:00', 108), 60,  15),
(1, 2, 1, '15-07-2018', convert(varchar(8), '14:00:00', 108), 30,  30),
(1, 3, 1, '15-07-2018', convert(varchar(8), '15:30:00', 108), 60,  15),
(1, 4, 1, '15-07-2018', convert(varchar(8), '18:00:00', 108), 75,  60),
(2, 1, 1, '16-07-2018', convert(varchar(8), '10:00:00', 108), 75,  120),
(2, 2, 1, '16-07-2018', convert(varchar(8), '18:00:00', 108), 120, 15),
(2, 5, 1, '16-07-2018', convert(varchar(8), '20:15:00', 108), 60,  15),
(2, 6, 1, '16-07-2018', convert(varchar(8), '22:15:00', 108), 90,  15)


GO

INSERT INTO PERSONAL_INFORMATION (visitor_number, town_number, telephone_number, birthdate, twitter_username, facebook_username) VALUES
(1, 1, '0612345678', convert(datetime, '15-07-1995 00:00:00', 105), 'robert_verkerk', NULL),
(2, 1, '0632165487', convert(datetime, '12-02-1993 00:00:00', 105), NULL, 'mariusBlautzik'),
(3, 2, '0632141587', convert(datetime, '12-02-1996 00:00:00', 105), NULL, NULL)
GO

INSERT INTO PODIUM_FILE(podium_number, branch_number, festival_number, "file", description) VALUES
(1, 1, 1, 'path/to/buildingbook.pdf', 'a beautifl description'),
(2, 1, 1, 'path/to/file.pdf', 'a description')
GO

INSERT INTO PODIUM_plays_GENRE (genre_number, podium_number) VALUES
(1, 1),
(2, 2)
GO

INSERT INTO TENT_FILE(tent_number, branch_number, festival_number, "file", description) VALUES
(1, 1, 1, 'path/to/file.pdf', 'factuur huur tent'),
(2, 3, 1, 'file/path.jpg', 'afbeelding attractie')
GO

INSERT INTO TOILET (branch_number, festival_number, name, capacity) VALUES
(1, 1, 'Toilet 1', 500),
(1, 1, 'Toilet 2', 50)
GO

INSERT INTO VISITOR_likes_PERFORMANCE (visitor_number, performance_number) VALUES
(1, 2),
(1, 1),
(2, 1)
GO

INSERT INTO VISITOR_VISITED_PERFORMANCE (visitor_number, performance_number) VALUES
(1,2),
(1,1),
(2,1)
GO


