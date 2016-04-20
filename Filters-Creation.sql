
	
	--------Library Filters ------------
	IF EXISTS(SELECT 1 FROM Filter WHERE FilterName = 'All RSAW Tags')
	begin
	UPDATE Filter SET FilterName = 'x' + FilterName WHERE FilterName = 'All RSAW Tags'
	end

	INSERT INTO Filter
	(FilterName, IsPrivate, EntityTypeID, [Statement], CreatedBy, CreatedOn, ModifiedBy, ModifiedOn, IsActive, MyEntityStatusID, IsSystemDefinedAllFilter, IsSystemDefinedMyEntityFilter)
	VALUES
	('All RSAW Tags', 0, @BE_Sch_Tags, '<1>', '44F33A1A-D793-4ACC-A5B8-85EC2A4F9B31', GETDATE(), NULL, NULL, 1, 0, 1, 0)
	SELECT @FilterID_Tags = SCOPE_IDENTITY()
	
	IF EXISTS(SELECT 1 FROM Filter WHERE FilterName = 'My RSAW Tags')
	begin
	UPDATE Filter SET FilterName = 'x' + FilterName WHERE FilterName = 'My RSAW Tags'
	end
	
	INSERT INTO Filter
	(FilterName, IsPrivate, EntityTypeID, [Statement], CreatedBy, CreatedOn, ModifiedBy, ModifiedOn, IsActive, MyEntityStatusID, IsSystemDefinedAllFilter, IsSystemDefinedMyEntityFilter)
	VALUES
	('My RSAW Tags', 0, @BE_Sch_Tags, '', '44F33A1A-D793-4ACC-A5B8-85EC2A4F9B31', GETDATE(), NULL, NULL, 1, 1, 0, 1)

	
	INSERT INTO FilterDetail
	(FilterID, SortOrder, WellFieldID, Condition, ConditionDateFormat, ConditionValue, ConditionValue2, SqlCondition, SqlConditionValue, BucketType, BucketCount, UseCurrentBucket)
	VALUES
	( @FilterID_Tags, 1, @Standards_Tags_Name, 'Is Not Blank',	NULL, '', NULL,	'<>', '''''', 0, 0,	0)
