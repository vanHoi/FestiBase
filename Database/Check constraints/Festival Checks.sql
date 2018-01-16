/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		7											*/
/* Last edited:		12-01-2018									*/	
/* Edited by:		Yuri Vannisselroy							*/
/* Constraint:		Check dates									*/
/*==============================================================*/

USE FestiBase
GO

/* start date must come before the end date */

ALTER TABLE FESTIVAL
DROP CONSTRAINT IF EXISTS chk_festival_startdate_before_enddate
GO
ALTER TABLE FESTIVAL
ADD CONSTRAINT chk_festival_startdate_before_enddate
CHECK ("start_date" < end_date)
GO