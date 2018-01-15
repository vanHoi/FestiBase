select * from GENRE_preference_VISITOR
select * from GENRE

select * 
FROM GENRE_preference_VISITOR AS gpv JOIN GENRE as G
ON gpv.genre_number = G.genre_number
ORDER BY visitor_number
WHERE visitor_number = 1

select G.genre_number, G.genre, GPV.visitor_number
FROM GENRE as G FULL OUTER JOIN GENRE_preference_VISITOR AS GPV
ON G.genre_number = GPV.genre_number
WHERE visitor_number = 1