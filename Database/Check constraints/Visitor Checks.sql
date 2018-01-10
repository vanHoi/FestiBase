/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		10-1-2018									*/
/* Edited by:		Yuri Vannisselroy							*/
/* Constraint:		E-mail must be Unique						*/
/*==============================================================*/

USE FestiBase
GO

DROP INDEX IF EXISTS  UNCI_emailadres_is_uniek ON VISITOR
GO
CREATE UNIQUE NONCLUSTERED INDEX UNCI_emailadres_is_uniek
ON VISITOR(email)
WHERE email IS NOT NULL