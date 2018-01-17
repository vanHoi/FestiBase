/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version 7												*/
/* Ivo Reumkens													*/	
/* 17-01-2018													*/
/* Constraint 1													*/
/*==============================================================*/

USE FestiBase
GO

ALTER TABLE PODIUM
DROP CONSTRAINT IF EXISTS chk_podium_construction_width_must_be_greater_or_equal_to_free_span_width
GO
ALTER TABLE PODIUM
ADD CONSTRAINT chk_podium_construction_width_must_be_greater_or_equal_to_free_span_width
CHECK (construction_width >= free_span_width)
GO

ALTER TABLE PODIUM
DROP CONSTRAINT IF EXISTS chk_podium_construction_length_must_be_greater_or_equal_to_freespan_length
GO
ALTER TABLE PODIUM
ADD CONSTRAINT chk_podium_construction_length_must_be_greater_or_equal_to_free_span_length
CHECK (construction_length >= free_span_length)
GO

ALTER TABLE PODIUM
DROP CONSTRAINT IF EXISTS chk_podium_height_must_be_greater_or_equal_to_free_span_height
GO
ALTER TABLE PODIUM
ADD CONSTRAINT chk_podium_height_must_be_greater_or_equal_to_free_span_height
CHECK ((construction_height - floor_height) >= free_span_height OR construction_height IS NULL)
GO
