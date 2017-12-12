DROP PROC IF EXISTS procAddTent;
GO
CREATE PROC procAddTent
	@tent_number INT,
	@podium_number INT,
	@length INT,
	@width INT,
	@side_height INT,
	@ridge_height INT,
	@construction_width INT,
	@construction_length INT,
	@tent_type VARCHAR(50),
	@color VARCHAR(50),
	@floor_type VARCHAR(50),
	@capacity INT
AS
BEGIN
	BEGIN TRY
		IF (@podium_number IS NOT NULL)
		BEGIN

			IF (@width <= (SELECT podium_width FROM PODIUM WHERE podium_number = @podium_number))
			BEGIN
				;THROW 50000, 'The width of the podium can''t be greater or equal to the the width of the tent!', 1
			END

			IF (@length <= (SELECT podium_depth FROM PODIUM WHERE podium_number = @podium_number))
			BEGIN
				;THROW 50001, 'The depth of the podium can''t be greater or equal to the the depth of the tent!', 1
			END

			IF (@side_height <= (SELECT height FROM PODIUM WHERE podium_number = @podium_number))
			BEGIN
				;THROW 50002, 'The height of the podium can''t be greater or equal to the the side height of the tent!', 1
			END

			IF (@capacity <= (SELECT capacity FROM PODIUM WHERE podium_number = @podium_number))
			BEGIN
				;THROW 50003, 'The capacity of the podium can''t be greater or equal to the the capacity of the tent!', 1
			END

		END

  INSERT INTO TENT VALUES (@tent_number, @podium_number, @length, @width, @side_height, @ridge_height,
                           @construction_width, @construction_length, @tent_type, @color, @floor_type, @capacity)

  END TRY

	BEGIN CATCH
		;THROW
	END CATCH

END
GO