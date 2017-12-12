/*==============================================================*/
/* DBMS name:      FestiBase									*/
/* PDM version 4												*/
/* testdata													    */
/*==============================================================*/

USE master
GO

USE FestiBase
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
(23456048, 'Leons Kaartjes Oplichterijen')
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

INSERT INTO FESTIVAL_COMPANY (coc_number, festival_number, town_number, telephone_number, street, house_number, contact_person, description) VALUES
(23456003, 1, 1, '0612345678', 'aleidestraat', '15', 'Robert Verkerk', 'Tent verhuur'),
(23456005, 1, 2, '0271234567', 'Hatertseweg', '123', 'Freddie Heineken', 'Ja, bier!!'),
(23456006, 1, 3, '0698765432', 'schijndelseweg', '5', 'Henk van Amstel', 'Attractieverhuur'),
(23456006, 2, 3, '0698478512', 'maaskantjeseweg', '5', 'Klaas van Heineken', 'Attractieverhuur'),
(23456001, 3, 3, '0611122233', 'grotestraat', '2', 'Frida Heemskerk', 'hamburgerbar'),
(23456001, 2, 3, '0624577885', 'hondenkaas', '25', 'Mac Donalds', 'Voedselcatering'),
(23456005, 3, 3, '0687433772', 'datdorp', '27', 'Ham Burgers', 'Hamburgerbar'),
(23456045, 1, 1, '0654188745', 'Coolestraat', '28', 'Robert De Inbreker', 'Kluisjesverhuurdbedrijf'),
(23456045, 2, 1, '0654188745', 'Coolestraat', '28', 'Robert De Inbreker', 'Kluisjesverhuurdbedrijf'),
(23456048, 1, 2, '0654788412', 'Oplichtersstraat', '1', 'Leon De Oplichter', 'Ticket bedrijf')
GO

INSERT INTO ATTRACTION (coc_number, festival_number, name, attraction_type) VALUES
(23456006, 1, 'Henks Draaimolen', 'Draaimolen'),
(23456006, 1, 'Booster', 'Booster'),
(23456045, 2, 'Booster', 'Booster'),
(23456045, 2, 'Das Omen', 'Spookhuis')
GO

INSERT INTO CATERING (coc_number, festival_number, name, electricity) VALUES
(23456003, 1, 'Hamburgerbar', 1),
(23456005, 1, 'Friettent', 1),
(23456045, 2, 'Tacos', 1),
(23456005, 3, 'Bierkar', 0)
GO

INSERT INTO FESTIVAL_COMPANY_FILE (coc_number, festival_number, "file", description) VALUES
(23456003, 1, 'path/to/file.pdf', 'factuur huur tent'),
(23456006, 1, 'file/path.jpg', 'afbeelding attractie')
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

INSERT INTO LOCKER (coc_number, festival_number) VALUES
(23456045, 1),
(23456045, 1),
(23456045, 1),
(23456045, 1),
(23456045, 1),
(23456045, 1),
(23456045, 1),
(23456045, 1),
(23456045, 1),
(23456045, 2),
(23456045, 2),
(23456045, 2),
(23456045, 2),
(23456045, 2),
(23456045, 2),
(23456045, 2)
GO

INSERT INTO VISITOR (email, first_name, surname) VALUES
('robertverkerk@hetnet.nl', 'Robert', 'Verkerk'),
('mariusssss@gmail.com', 'Mariuszsz', 'Blautzik'),
('ivorr@reumkens.nl', 'Ivo', 'Reumkens'),
(null, null, null)
GO

INSERT INTO LOCKER_RENTED (locker_number, visitor_number, start_date, end_date) VALUES
(1, 1, convert(datetime, '15-07-2017 00:00:00', 105), convert(datetime, '17-07-2017 00:00:00', 105)),
(2, 3, convert(datetime, '15-07-2017 00:00:00', 105), null)
GO

INSERT INTO PERSONAL_INFORMATION (visitor_number, town_number, telephone_number, birthdate, twitter_username, facebook_username) VALUES
(1, 1, '0612345678', convert(datetime, '15-07-1995 00:00:00', 105), 'robert_verkerk', NULL),
(2, 1, '0632165487', convert(datetime, '12-02-1993 00:00:00', 105), NULL, 'mariusBlautzik'),
(3, 2, '0632141587', convert(datetime, '12-02-1996 00:00:00', 105), NULL, NULL)
GO

INSERT INTO GENRE_preference_VISITOR (visitor_number, genre_number) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4)
GO

INSERT INTO ARTIST_preferred_by_VISITOR (artist_number, visitor_number) VALUES
(1, 2),
(2, 1),
(4, 1),
(3, 2)
GO

INSERT INTO TICKET_TYPE (coc_number, festival_number, ticket_type, price, date_valid_from, date_valid_to) VALUES
(23456048, 1, 'Premium ticket', '75', GETDATE(), GETDATE() + 3),
(23456048, 1, 'VIP', '120', GETDATE(), GETDATE() + 1),
(23456048, 1, 'dagticket', '50', GETDATE(), GETDATE() + 3)
GO

INSERT INTO BOUGHT_TICKET (coc_number, festival_number, ticket_type, visitor_number) VALUES
(23456048, 1, 'Premium ticket', 1),
(23456048, 1, 'Premium ticket', 1),
(23456048, 1, 'VIP', 2)
GO

INSERT INTO PODIUM (festival_number, genre_number, name, podium_width, podium_depth, height, capacity, floorheight, floor_load, free_span_width, free_span_depth, free_span_height, environment) VALUES
(1, NULL, 'Heineken Stage', 1500, 1000, 400, 5000, 50, 180, 200, 1400, 900, 'description of environment'),
(1, 1, 'PopPodium', 1200, 1000, NULL, 10000, 100, 200, 200, 1000, 900, 'beautiful trees')
GO

INSERT INTO PODIUM_FILE(podium_number, coc_number, festival_number, "file", description) VALUES
(1, 23456003, 1, 'path/to/buildingbook.pdf', 'a beautifl description'),
(2, 23456003, 1, 'path/to/file.pdf', 'a description')
GO

INSERT INTO TENT (podium_number, length, width, side_height, ridge_height, construction_width, construction_length, tent_type, color, floor_type, capacity) VALUES
(1, 5000, 3000, 240, 400, 5200, 3200, 'aluhal', 'wit', 'dansvloer', 10000),
(2, 5000, 3000, 240, 400, 5200, 3200, 'pagode', 'wit', 'cassetevloer', 1000)
GO

INSERT INTO TENT_FILE(tent_number, coc_number, festival_number, "file", description) VALUES
(1, 23456003, 1, 'path/to/file.pdf', 'factuur huur tent'),
(2, 23456006, 1, 'file/path.jpg', 'afbeelding attractie')
GO

INSERT INTO TOILET (coc_number, festival_number, toilet_code, toilet_capacity) VALUES
(23456003, 1, 'Toilet 1', 500),
(23456003, 1, 'Toilet 2', 50)
GO

INSERT INTO PERFORMANCE (podium_number, artist_number, date, start_time, play_time) VALUES
(1, 1, convert(date, '01-04-2017 00:00:00', 103), convert(time, '01-04-2017 15:00:00', 103), 60),
(2, 2, convert(date, '02-04-2018 00:00:00', 103), convert(time, '02-04-2018 14:00:00', 103), 90)
GO

INSERT INTO VISITOR_VISITED_PERFORMANCE (visitor_number, performance_number) VALUES
(1,2),
(1,1),
(2,1)
GO
