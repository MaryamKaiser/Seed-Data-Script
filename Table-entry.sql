	----------Insertion in related Tables---------------
	INSERT INTO EntityType
	(EntityName,IsModule,IsBasicAdvancedApplicable,IsViewerApplicable,IsTemplateApplicable,
	IsTemplateOwner,DisplayName,IsCustomFieldAllowed,IconUrl,IsCustomEntity,Prefix,IsCustomWork,
	DetailsPageUrl,DefaultOwner,IsRedirectToHomePage,Description,IsPushLifeCyclePhase,IsWPMCustomEntity,IsCustomSubjects,IsBusinessEntity,IsResource,CreatedDate,
	CreatedByGuid,ModifiedDate,ModifiedByGuid,IsHierarchyNode,IsShowInLibrary,IsIntegrationEnabled,IsActive,IsDeleted,HierarchytypeId,IsSystemDefined,
	IsCustomField, BusinessEntityCategoryID, Recurring, IsNonLoginUserInputAllowed, DefaultOwnerGuid, DefaultProcTemplateGuid,IsAutoAssignProc, DefaultTeamGuid, IsAutoActivateProc)
	VALUES
	('RSAW Templates',
	1,0,0,0,0,'RSAW Templates',0,'~/Images/SFLogo16.ico',0,'Templates',NULL,NULL,NULL,0,
	'Multiple RSAW configuration templates (RSAW Templates) can be created for each NERC Standard. To create multiple RSAW Templates for a Standard, the RSAW Template must first be added to this Library.'
	,0, 0, 0, 1, 0, GETDATE(), 
	'44F33A1A-D793-4ACC-A5B8-85EC2A4F9B31', GETDATE(), '44F33A1A-D793-4ACC-A5B8-85EC2A4F9B31', 0, 1, 1, 1, 0, 0, 1, 0, 1,NULL, 0, NULL, NULL, 0, NULL, 0)
	SELECT @BE_Sch_TEMP = SCOPE_IDENTITY()

	INSERT INTO SystemDefinedBusinessEntities(EntityTypeId,SystemBusinessEntityName) 
	VALUES (@BE_Sch_TEMP,'RSAW Templates')


	-----------------------------------	
		
	INSERT INTO WellField
	(FName, FType, TextValue, DateValue, NumberValue, CurrencyValue, DisplayName, IsSystemGenerated, IsWell, IsQuestion, IsOverview, IsStandard, IsRequired, ColumnName, IsTag, IsRig, SubTableName, MaxLength, DecimalPoints, IsWPMCustomEntityField, IsWPMCustomSubjectField, IsBusinessEntityField, IsActive, IsDeleted, IsSystemDefined, BooleanValue, UseFormattedText, TextValueFormatted, IsPrimaryField, UseUniqueValue)
	SELECT 'Name', 'MLT', '', NULL, NULL, NULL, 'Template Name', 0, 0, 0, 0, 1, 1, 'Name', 0, 0, NULL, 5000, 0, 1, 1, 1, 1, 0, 0, NULL, 0, NULL, 0, 1
	SELECT @Standards_TEMP_Name = SCOPE_IDENTITY()

	INSERT INTO WellField
	(FName, FType, TextValue, DateValue, NumberValue, CurrencyValue, DisplayName, IsSystemGenerated, IsWell, IsQuestion, IsOverview, IsStandard, IsRequired, ColumnName, IsTag, IsRig, SubTableName, MaxLength, DecimalPoints, IsWPMCustomEntityField, IsWPMCustomSubjectField, IsBusinessEntityField, IsActive, IsDeleted, IsSystemDefined, BooleanValue, UseFormattedText, TextValueFormatted, IsPrimaryField, UseUniqueValue)
	SELECT 'Description', 'MLT', '', NULL, NULL, NULL, 'Description', 0, 1, 0, 1, 1, 0, 'Description', 0, 1, NULL, 5000, 2, 1, 1, 1, 1, 0, 0, NULL, 0, NULL, 0, 0
	SELECT @Standards_TEMP_Description = SCOPE_IDENTITY()

		--------------------------------------------
	
	INSERT INTO WellFieldEntityTypeMapping
	(EntityTypeId, FID, DisplayName, TextValue, DateValue, NumberValue, CurrencyValue, IsQuestion, IsRequired, ColumnName, IsTag, MaxLength, DecimalPoints, IsVirtual, ParentEntityTypeId, SubTableName, IsDeleted, IsInherited, IsIntegrationEnabled, IsActive, BooleanValue, TextValueFormatted, CustomFieldDataColumn, CustomFieldDataTable, [Description] )
	VALUES
	(@BE_Sch_TEMP, @Standards_TEMP_Name, 'Template Name', NULL, NULL, NULL, NULL, 0, 1, 'Name', 0, 5000, 0, 0, NULL, NULL, 0, 0, 1, 1, NULL, NULL, 'Name','BusinessEntity', 'The (unique) name of the RSAW Template Version.')

	INSERT INTO WellFieldEntityTypeMapping
	(EntityTypeId, FID, DisplayName, TextValue, DateValue, NumberValue, CurrencyValue, IsQuestion, IsRequired, ColumnName, IsTag, MaxLength, DecimalPoints, IsVirtual, ParentEntityTypeId, SubTableName, IsDeleted, IsInherited, IsIntegrationEnabled, IsActive, BooleanValue, TextValueFormatted, CustomFieldDataColumn, CustomFieldDataTable)
	VALUES
	(@BE_Sch_TEMP, @Standards_TEMP_Description, 'Description', NULL, NULL, NULL, NULL, 0, 0, 'Description', 0, 5000, 0, 0, NULL, NULL, 0, 0, 1, 1, NULL, NULL,'Description','BusinessEntity')
