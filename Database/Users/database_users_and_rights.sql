CREATE LOGIN Bezoeker WITH PASSWORD = 'festibase' 
CREATE LOGIN Organisatie WITH PASSWORD = 'festibase' 
CREATE LOGIN Medewerker WITH PASSWORD = 'festibase' 
CREATE LOGIN Bedrijf WITH PASSWORD = 'festibase' 

USE FestiBase
GO

CREATE USER Bezoeker FOR LOGIN Bezoeker
CREATE USER Organisatie FOR LOGIN Organisatie
CREATE USER Medewerker FOR LOGIN Medewerker
CREATE USER Bedrijf FOR LOGIN Bedrijf

GRANT EXECUTE TO Organisatie

--Add or update procecdures
GRANT EXECUTE ON dbo.sp_add_or_update_locker_rented TO Bezoeker
GRANT EXECUTE ON dbo.sp_add_or_update_company TO Bedrijf
GRANT EXECUTE ON dbo.sp_add_or_update_company_branch TO Bedrijf
GRANT EXECUTE ON dbo.sp_add_or_update_visitor TO Bezoeker
GRANT EXECUTE ON dbo.sp_add_or_update_attraction TO Bedrijf
GRANT EXECUTE ON dbo.sp_add_or_update_catering TO Bedrijf
GRANT EXECUTE ON dbo.sp_add_or_update_toilet TO Bedrijf
GRANT EXECUTE ON dbo.sp_add_or_update_festival_company TO Bedrijf
GRANT EXECUTE ON dbo.sp_add_or_update_festival_company_file TO Bedrijf
GRANT EXECUTE ON dbo.sp_add_or_update_tent TO Bedrijf
GRANT EXECUTE ON dbo.sp_add_or_update_tent_file TO Bedrijf
GRANT EXECUTE ON dbo.sp_add_or_update_podium TO Bedrijf
GRANT EXECUTE ON dbo.sp_add_or_update_podium_file TO Bedrijf
GRANT EXECUTE ON dbo.sp_add_or_update_ticket_type TO Bedrijf
GRANT EXECUTE ON dbo.sp_add_or_update_bought_ticket TO Bezoeker
GRANT EXECUTE ON dbo.sp_add_or_update_bought_ticket TO Medewerker
GRANT EXECUTE ON dbo.sp_add_visitor_visited_performance TO Bezoeker
GRANT EXECUTE ON dbo.sp_add_visitor_likes_performance TO Bezoeker
GRANT EXECUTE ON dbo.sp_add_genre_preference_visitor TO Bezoeker
GRANT EXECUTE ON dbo.sp_add_or_update_artist TO Bedrijf
GRANT EXECUTE ON dbo.sp_add_or_update_artist_file TO Bedrijf

--Delete procedures
GRANT EXECUTE ON dbo.sp_delete_locker_rented TO Bezoeker
GRANT EXECUTE ON dbo.sp_delete_visitor TO Bezoeker
GRANT EXECUTE ON dbo.sp_delete_attraction TO Bedrijf
GRANT EXECUTE ON dbo.sp_delete_catering TO Bedrijf
GRANT EXECUTE ON dbo.sp_delete_festival_company TO Bedrijf
GRANT EXECUTE ON dbo.sp_delete_festival_company_file TO Bedrijf
GRANT EXECUTE ON dbo.sp_delete_tent TO Bedrijf
GRANT EXECUTE ON dbo.sp_delete_tent_file TO Bedrijf
GRANT EXECUTE ON dbo.sp_delete_podium TO Bedrijf
GRANT EXECUTE ON dbo.sp_delete_podium_file TO Bedrijf
GRANT EXECUTE ON dbo.sp_delete_bought_ticket TO Bezoeker
GRANT EXECUTE ON dbo.sp_delete_tent TO Bedrijf
GRANT EXECUTE ON dbo.sp_delete_tent_file TO Bedrijf
GRANT EXECUTE ON dbo.sp_delete_podium TO Bedrijf
GRANT EXECUTE ON dbo.sp_delete_podium_file TO Bedrijf
GRANT EXECUTE ON dbo.sp_delete_bought_ticket TO Bezoeker
GRANT EXECUTE ON dbo.sp_delete_visitor_visited_performance TO Bezoeker
GRANT EXECUTE ON dbo.sp_delete_visitor_likes_performance TO Bezoeker
GRANT EXECUTE ON dbo.sp_delete_genre_preference_visitor TO Bezoeker

--Select procedures
GRANT EXECUTE ON dbo.sp_get_all_genres TO Bezoeker
GRANT EXECUTE ON dbo.sp_get_genres_of_visitor TO Bezoeker