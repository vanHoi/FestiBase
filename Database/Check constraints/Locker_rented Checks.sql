/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version 6												*/
/* Ivo Reumkens													*/	
/* 19-12-2017													*/
/* Business Rule 12	/ Constraint 4								*/
/*==============================================================*/

USE FestiBase
GO

ALTER TABLE LOCKER_RENTED
DROP CONSTRAINT IF EXISTS chk_locker_start_date_must_be_before_end_date
GO
ALTER TABLE LOCKER_RENTED
ADD CONSTRAINT chk_locker_start_date_must_be_before_end_date
CHECK (start_date < end_date OR end_date IS NULL)
GO
