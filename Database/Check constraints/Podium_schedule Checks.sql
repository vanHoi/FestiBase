/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		7											*/
/* Last edited:		12-01-2018									*/	
/* Edited by:		Yuri Vannisselroy							*/
/* Constraint:		Check dates PODIUM_SCHEDULE					*/
/*==============================================================*/

USE FestiBase
GO

SET DATEFORMAT DMY
GO

/* start date must come before the end date */

ALTER TABLE PODIUM_SCHEDULE
DROP CONSTRAINT IF EXISTS chk_podium_schedule_startdate_before_enddate
GO
ALTER TABLE PODIUM_SCHEDULE
ADD CONSTRAINT chk_podium_schedule_startdate_before_enddate
CHECK ((CAST("start_date" AS DATETIME) + CAST(start_time AS DATETIME)) 
		< (CAST(end_date AS DATETIME) + CAST(end_time AS DATETIME)))
GO