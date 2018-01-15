/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		11-1-2018									*/
/* Edited by:		Robert Verkerk								*/
/* Procedure:		Procedure to check if the festival of the   */
/*					tent is the same as the festival of the		*/
/*					podium										*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure that checks the following:
	- If the festival from the tent is the same as the podium
*/

DROP PROC IF EXISTS sp_check_podium_tent_festival
GO
CREATE PROC sp_check_podium_tent_festival
	@podium_number INT,
	@tent_number INT
AS
BEGIN
	BEGIN TRY
		BEGIN
		IF ( (SELECT festival_number FROM TENT where tent_number = @tent_number) != (SELECT festival_number FROM PODIUM where podium_number = @podium_number))
			BEGIN
				;THROW 500001, 'The festival of the podium and tent should be the same.', 1
			END
		END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO