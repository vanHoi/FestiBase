DROP PROC IF EXISTS sp_add_or_update_tent;
GO
CREATE PROC sp_add_or_update_tent
	@insert BIT,
	@tent_number INT = NULL,
	@festival_number INT,
	@name VARCHAR(50),
	@width INT,
	@length INT,
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

	IF (@insert = 1)
	BEGIN
		INSERT INTO TENT (festival_number, name, width, length, side_height, ridge_height, construction_width, construction_length,
		tent_type, color, floor_type, capacity)
		 VALUES (@festival_number, @name , @width, @length, @side_height, @ridge_height,
                           @construction_width, @construction_length, @tent_type, @color, @floor_type, @capacity)
	END
	ELSE 
	BEGIN
		IF (@tent_number = null)
		BEGIN
			;THROW 50000, 'You must supply a tent number with an update statement.', 1
		END
		UPDATE TENT SET festival_number = @festival_number, name = @name, width = @width, length =  @length, side_height = @side_height, ridge_height = @ridge_height,
                           construction_width = @construction_width, construction_length = @construction_length, tent_type = @tent_type, color = @color, 
						   floor_type = @floor_type, capacity = @capacity WHERE tent_number = @tent_number
	
	END

  END TRY

	BEGIN CATCH
		;THROW
	END CATCH

END
