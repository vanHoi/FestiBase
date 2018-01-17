/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version 7												*/
/* Ivo Reumkens													*/	
/* 17-01-2018													*/
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
