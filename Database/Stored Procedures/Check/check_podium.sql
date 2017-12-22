/*==============================================================*/
/* DBMS name:		FestiBase									*/
/* PDM version:		6											*/
/* Last edited:		22-12-2017									*/
/* Edited by:		Ivo Reumkens								*/
/* Procedure:		Check podium constraints (C2)				*/
/*==============================================================*/

USE FestiBase
GO

/*
	Procedure that checks the following:
	- The podium capacity can't be greater then the capacity from the tent
	- The floor_height of the podium can't be greater then the side_height of the tent
	- The building_width of the podium can't be greater then the width of the tent
	- The building_length of the podium can't be greater then the length of the tent
	- - The building_height of the podium can't be greater then the ridge_height of the tent
	- There must be at least 3 meters between the podium floor and the ridge_height of the tent
*/

DROP PROC IF EXISTS sp_check_podium;
GO
CREATE PROC sp_check_podium
	@tent_number INT = NULL,
	@construction_width INT,
	@construction_length INT,	
	@construction_height INT = NULL,
	@floor_height INT = NULL,
	@capacity INT,
	@free_span_width INT,
	@free_span_length INT,
	@free_span_height INT = NULL
AS
BEGIN
	BEGIN TRY
		IF (@tent_number IS NOT NULL OR @tent_number != 0)
		BEGIN

			IF (@construction_width > (SELECT width FROM TENT WHERE tent_number = @tent_number))
			BEGIN
				;THROW 50001, 'The width of the podium can''t be greater or equal to the the width of the tent!', 1
			END

			IF (@construction_length > (SELECT length FROM TENT WHERE tent_number = @tent_number))
			BEGIN
				;THROW 50002, 'The length of the podium can''t be greater or equal to the the length of the tent!', 1
			END

			IF (@floor_height > (SELECT side_height FROM TENT WHERE tent_number = @tent_number))
			BEGIN
				;THROW 50003, 'The floor height of the podium can''t be greater then the side height of the tent!', 1
			END

			IF (@capacity > (SELECT capacity FROM TENT WHERE tent_number = @tent_number))
			BEGIN
				;THROW 50004, 'The capacity of the podium can''t be greater than the the capacity of the tent!', 1
			END

			IF ((@floor_height + 300) > (SELECT ridge_height FROM TENT WHERE tent_number = @tent_number))
			BEGIN
				;THROW 50005, 'There is less then three meters standing space available from the podium floor to the highest point in the tent.', 1
			END

			IF (@construction_height >= (SELECT ridge_height FROM TENT WHERE tent_number = @tent_number))
			BEGIN
				;THROW 50006, 'The construction height of the podium can''t be greater or equal to the the ridge height of the tent!', 1
			END

		END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO