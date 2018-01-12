/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version 6												*/
/* Ivo Reumkens													*/	
/* 19-12-2017													*/
/* Constraint 3													*/
/*==============================================================*/

USE FestiBase
GO

ALTER TABLE TENT
DROP CONSTRAINT IF EXISTS chk_construction_width_must_be_greater_or_equal_to_width
GO
ALTER TABLE TENT
ADD CONSTRAINT chk_construction_width_must_be_greater_or_equal_to_width
CHECK (construction_width >= width)
GO

ALTER TABLE TENT
DROP CONSTRAINT IF EXISTS chk_building_length_must_be_greater_or_equal_to_length
GO
ALTER TABLE TENT
ADD CONSTRAINT chk_building_length_must_be_greater_or_equal_to_length
CHECK (construction_length >= "length")
GO

ALTER TABLE TENT
DROP CONSTRAINT IF EXISTS chk_ridge_height_must_be_greater_or_equal_to_side_height
GO
ALTER TABLE TENT
ADD CONSTRAINT chk_ridge_height_must_be_greater_or_equal_to_side_height
CHECK (ridge_height >= side_height)
GO

/* Testdata */

-- Correct
BEGIN TRAN
INSERT INTO TENT (festival_number, name, width, length, side_height, ridge_height, construction_width, construction_length, tent_type, color, floor_type, capacity) 
VALUES (1, 'Test Tent', 1200, 2000, 500, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000)
ROLLBACK TRAN

-- Width too wide
BEGIN TRAN
INSERT INTO TENT (festival_number, name, width, length, side_height, ridge_height, construction_width, construction_length, tent_type, color, floor_type, capacity) 
VALUES (1, 'Test Tent', 1200, 2000, 500, 1000, 1000, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000)
ROLLBACK TRAN

-- Length too long
BEGIN TRAN
INSERT INTO TENT (festival_number, name, width, length, side_height, ridge_height, construction_width, construction_length, tent_type, color, floor_type, capacity) 
VALUES (1, 'Test Tent', 1200, 2000, 500, 1000, 1400, 1800, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000)
ROLLBACK TRAN

-- Side height too high
BEGIN TRAN
INSERT INTO TENT (festival_number, name, width, length, side_height, ridge_height, construction_width, construction_length, tent_type, color, floor_type, capacity) 
VALUES (1, 'Test Tent', 1200, 2000, 1200, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000)
ROLLBACK TRAN