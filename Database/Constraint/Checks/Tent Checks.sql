ALTER TABLE TENT
DROP CONSTRAINT IF EXISTS chkConstructionWidthMustBeGreaterOrEqualToWidth
GO
ALTER TABLE TENT
ADD CONSTRAINT chkConstructionWidthMustBeGreaterOrEqualToWidth
CHECK (construction_width >= width)
GO

ALTER TABLE TENT
DROP CONSTRAINT IF EXISTS chkBuildingLengthMustBeGreaterOrEqualToLength
GO
ALTER TABLE TENT
ADD CONSTRAINT chkBuildingLengthMustBeGreaterOrEqualToLength
CHECK (construction_length >= length)
GO

ALTER TABLE TENT
DROP CONSTRAINT IF EXISTS chkRidgeHeightMustBeGreaterOrEqualToSideHeight
GO
ALTER TABLE TENT
ADD CONSTRAINT chkRidgeHeightMustBeGreaterOrEqualToSideHeight
CHECK (ridge_height >= side_height)
GO

/* Testdata */

-- Correct
EXEC procAddOrUpdateTent 1, null, null, 1200, 2000, 500, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000

-- Width to great
EXEC procAddOrUpdateTent 1, null, null, 1200, 2000, 500, 1000, 1000, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000

-- Length to great
EXEC procAddOrUpdateTent 1, null, null, 1200, 2000, 500, 1000, 1400, 1800, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000

-- Side height to great
EXEC procAddOrUpdateTent 1, null, null, 1200, 2000, 1200, 1000, 1400, 3300, 'Grote Tent', 'Blauw-wit', 'Systeemvloer', 12000
