------Add and Overview Form Declaration ----------------------

	Declare @AddForm_TemplateGuid Uniqueidentifier,
			@OverviewForm_TemplateGuid Uniqueidentifier

	SELECT @AddForm_TemplateGuid=NEWID()
	SELECT @OverviewForm_TemplateGuid=NEWID()

	INSERT INTO [M_EntityFormTemplates]
	   ([FormTemplateId],[EntityId],[IsDefault],[UseEntityFields],[Name],[Description],
	   [IsActive],[IsAddForm],[IsOverviewForm])
	VALUES
	   (@AddForm_TemplateGuid,@BE_Sch_TEMP,1,1,'Add RSAW Templates','Add RSAW Templates'
	   ,1,1,0)

	INSERT INTO [M_EntityFormTemplates]
	   ([FormTemplateId],[EntityId],[IsDefault],[UseEntityFields],[Name],[Description]
	   ,[IsActive],[IsAddForm],[IsOverviewForm])
	VALUES
	   (@OverviewForm_TemplateGuid,@BE_Sch_TEMP,1,1,'RSAW Templates Overview','RSAW Templates Overview'
	   ,1,0,1)

   	      ------------------Add Form Fields---------------------------

	INSERT INTO M_FormFields
	(FormFieldId,FieldId,FormTemplateId)
	SELECT newid(), sdf.FieldId, @AddForm_TemplateGuid
	FROM SystemDefinedFields sdf WHERE sdf.EntityTypeId = @BE_Sch_TEMP

	Insert into M_FormFieldsDisplay
	(FormFieldDisplayGuid,FieldId,FormFieldDisplayId,FormTemplateId,UseSeparatorAbove,DisplayOrder,IsReadOnly)
	SELECT newid(), mf.FormFieldId, null, @AddForm_TemplateGuid, 0 , ROW_NUMBER() over(order by mf.FieldId) , 0
	FROM M_FormFields mf
	INNER JOIN SystemDefinedFields sdf
	ON mf.FieldId = sdf.FieldId
	WHERE sdf.EntityTypeId = @BE_Sch_TEMP

	------------------Overview Form Fields---------------------------

	INSERT INTO M_FormFields
	(FormFieldId,FieldId,FormTemplateId)
	SELECT newid(), sdf.FieldId, @OverviewForm_TemplateGuid
	FROM SystemDefinedFields sdf WHERE sdf.EntityTypeId = @BE_Sch_TEMP

	Insert into M_FormFieldsDisplay
	(FormFieldDisplayGuid,FieldId,FormFieldDisplayId,FormTemplateId,UseSeparatorAbove,DisplayOrder,IsReadOnly)
	SELECT newid(), mf.FormFieldId, null, @OverviewForm_TemplateGuid, 0 , ROW_NUMBER() over(order by mf.FieldId) , 0
	FROM M_FormFields mf
	INNER JOIN SystemDefinedFields sdf
	ON mf.FieldId = sdf.FieldId
	WHERE sdf.EntityTypeId = @BE_Sch_TEMP AND mf.FormTemplateId = @OverviewForm_TemplateGuid