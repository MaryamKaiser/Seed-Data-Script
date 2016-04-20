-----------------------Default View--------------------

	Select @DefaultViewGuid = NEWID()
	Insert into MT_EntityDataViews
	(ViewId,EntityId,IsDefault,IsSystemDefined,Name,Description,Sequence)
	values
	(@DefaultViewGuid,@BE_Sch_TEMP,1,1,'Default View','Default View',1)

	INSERT INTO MT_ViewFields
	(ViewId,FieldId,DisplayOrder)
	SELECT @DefaultViewGuid, sdf.FieldId, ROW_NUMBER() OVER (ORDER BY sdf.FieldId)
	FROM SystemDefinedFields sdf WHERE sdf.EntityTypeId = @BE_Sch_TEMP

	INSERT INTO RBSViewRolePermissionMapping
	(PermissionID, ViewID, RoleID, IsInstanceLevel)
	VALUES
	(@PermissionID, @DefaultViewGuid , @Admin_Role_Id, 0)
	
					------My View------------
	Select @MyViewGuid = NEWID()
	Insert into MT_EntityDataViews
	(ViewId,EntityId,IsDefault,IsSystemDefined,Name,Description,Sequence, IsMyView, ViewTypeID, IsShowInLibrary)
	values
	(@MyViewGuid, @BE_Sch_TEMP, 0, 0, 'My View', 'My View', 0, 1, 1, 0)	
	
	INSERT INTO MT_ViewFields
	(ViewId,FieldId,DisplayOrder, DoAscendingSort)
	SELECT @MyViewGuid, @Standards_TEMP_Name, 1, 1

	INSERT INTO RBSViewRolePermissionMapping
	(PermissionID, ViewID, RoleID, IsInstanceLevel)
	VALUES
	(@PermissionID, @MyViewGuid , @Admin_Role_Id, 0)
	
				-------Relationship View----------------

	Select @RSViewGuid = NEWID()
	Insert into MT_EntityDataViews
	(ViewId,EntityId,IsDefault,IsSystemDefined,Name,[Description], IsMyView, ViewTypeID, RelatedSchemaID)
	values
	(@RSViewGuid, @BE_Sch_TEMP, 0, 0, 'RSAW Templates-Document Relationship', '',  0, 2, @RelatedSchemaIDTemp )	
	
	-----------------Filter Creation---------------
	IF EXISTS(SELECT 1 FROM Filter WHERE FilterName = 'All RSAW Templates')
	begin
	UPDATE Filter SET FilterName = 'x' + FilterName WHERE FilterName = 'All RSAW Templates'
	end	
	
	INSERT INTO Filter
	(FilterName, IsPrivate, EntityTypeID, [Statement], CreatedBy, CreatedOn, ModifiedBy, ModifiedOn, IsActive, MyEntityStatusID, IsSystemDefinedAllFilter, IsSystemDefinedMyEntityFilter)
	VALUES
	('All RSAW Templates'  , 0, @BE_Sch_TEMP, '<1>', '44F33A1A-D793-4ACC-A5B8-85EC2A4F9B31', GETDATE(), NULL, NULL, 1, 0, 1, 0)
	SELECT @FilterID_Temp = SCOPE_IDENTITY()

	IF EXISTS(SELECT 1 FROM Filter WHERE FilterName = 'My RSAW Templates')
	begin
	UPDATE Filter SET FilterName = 'x' + FilterName WHERE FilterName = 'My RSAW Templates'
	end

	INSERT INTO Filter
	(FilterName, IsPrivate, EntityTypeID, [Statement], CreatedBy, CreatedOn, ModifiedBy, ModifiedOn, IsActive, MyEntityStatusID, IsSystemDefinedAllFilter, IsSystemDefinedMyEntityFilter)
	VALUES
	('My RSAW Templates'  , 0, @BE_Sch_TEMP, '', '44F33A1A-D793-4ACC-A5B8-85EC2A4F9B31', GETDATE(), NULL, NULL, 1, 1, 0, 1)

	
	INSERT INTO FilterDetail
	(FilterID, SortOrder, WellFieldID, Condition, ConditionDateFormat, ConditionValue, ConditionValue2, SqlCondition, SqlConditionValue, BucketType, BucketCount, UseCurrentBucket)
	VALUES
	(@FilterID_Temp, 1, @Standards_TEMP_Name, 'Is Not Blank',	NULL, '', NULL,	'<>','''''', 0,	0,	0)