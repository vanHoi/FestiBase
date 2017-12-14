ALTER TABLE PODIUM
DROP CONSTRAINT IF EXISTS chk_podium_construction_width_must_be_greater_or_equal_to_free_span_width
GO
ALTER TABLE PODIUM
ADD CONSTRAINT chk_podium_construction_width_must_be_greater_or_equal_to_free_span_width
CHECK (construction_width >= free_span_width)
GO

ALTER TABLE PODIUM
DROP CONSTRAINT IF EXISTS chk_podium_construction_length_must_be_greater_or_equal_to_freespan_depth
GO
ALTER TABLE PODIUM
ADD CONSTRAINT chk_podium_construction_length_must_be_greater_or_equal_to_free_span_depth
CHECK (construction_length >= free_span_length)
GO

ALTER TABLE PODIUM
DROP CONSTRAINT IF EXISTS chk_podium_height_must_be_greater_or_equal_to_free_span_height
GO
ALTER TABLE PODIUM
ADD CONSTRAINT chk_podium_height_must_be_greater_or_equal_to_free_span_height
CHECK ((construction_height - floor_height) >= free_span_height OR construction_height IS NULL)
GO

/* Testdata */

-- Correct
INSERT INTO PODIUM (festival_number, name, construction_width, construction_length, floor_height, construction_height, capacity, floor_load, free_span_width, free_span_length, free_span_height, environment, time_between_performances) VALUES (1, 'Test Stage', 1000, 600, 100, 500, 10000, 15, 800, 500, 400, 'Plat vlak land', 60) 

-- Width too wide
INSERT INTO PODIUM (festival_number, name, construction_width, construction_length, floor_height, construction_height, capacity, floor_load, free_span_width, free_span_length, free_span_height, environment, time_between_performances) VALUES (1, 'Test Stage', 1000, 600, 100, 500, 10000, 15, 1200, 500, 400, 'Plat vlak land', 60) 

-- Length too long
INSERT INTO PODIUM (festival_number, name, construction_width, construction_length, floor_height, construction_height, capacity, floor_load, free_span_width, free_span_length, free_span_height, environment, time_between_performances) VALUES (1, 'Test Stage', 1000, 600, 100, 500, 10000, 15, 800, 700, 400, 'Plat vlak land', 60) 

-- Height too high
INSERT INTO PODIUM (festival_number, name, construction_width, construction_length, floor_height, construction_height, capacity, floor_load, free_span_width, free_span_length, free_span_height, environment, time_between_performances) VALUES (1, 'Test Stage', 1000, 600, 100, 500, 10000, 15, 800, 500, 550, 'Plat vlak land', 60) 
