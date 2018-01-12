/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		7											*/
/* Last edited:		12-01-2018									*/	
/* Edited by:		Yuri Vannisselroy							*/
/* Constraint:		Check dates TICKET_TYPE						*/
/*==============================================================*/

USE FestiBase
GO

/* start date must come before the end date */

ALTER TABLE TICKET_TYPE
DROP CONSTRAINT IF EXISTS chk_ticket_type_startdate_before_enddate
GO
ALTER TABLE TICKET_TYPE
ADD CONSTRAINT chk_ticket_type_startdate_before_enddate
CHECK (date_valid_from < date_valid_to)
GO