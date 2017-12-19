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

/* Testdata */

-- Correct
BEGIN TRAN
INSERT INTO LOCKER_RENTED (locker_number, start_date, end_date, visitor_number) VALUES (1, GETDATE(), GETDATE() + 3, 1)
ROLLBACK TRAN

-- End date before start date in date
BEGIN TRAN
INSERT INTO LOCKER_RENTED (locker_number, start_date, end_date, visitor_number) VALUES (1, GETDATE(), GETDATE() - 3, 1)
ROLLBACK TRAN

-- End date before start date in time
BEGIN TRAN
INSERT INTO LOCKER_RENTED (locker_number, start_date, end_date, visitor_number) VALUES (1, GETDATE(), GETDATE() - 0.1, 1)
ROLLBACK TRAN
