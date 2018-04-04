--USE YourDatabaseName

GO
SELECT 
	[Version] = 1, --script version
	[DatabaseName] = DB_NAME(),
	--[DbCollation] = DATABASEPROPERTYEX(DB_NAME(),'collation'),
	--schemas
	(
	SELECT [Name] = s.name, 
	       [DbDefault] = 
				    CASE WHEN o.is_fixed_Role = 1 THEN 1 
					    WHEN s.Name = 'dbo' THEN 1
					    WHEN s.Name = 'guest' THEN 1 ELSE 0
					END

			FROM	sys.schemas s join
					sys.database_principals o ON o.principal_id = s.principal_id
		    WHERE	o.sid IS NOT NULL		
				--AND s.Name in ('dbo','lkp') --schema filter
			FOR XML RAW('Schema'), TYPE, ROOT('Schemas')),
	--tables
	(
	SELECT 
	   
	   [Schema] = s.name, 
	   [Table] = o.Name,
	   -- Get Columns
	   (
		  SELECT	
			[Name] = c.name,
			[IsIdentity] = CASE WHEN c.is_identity=1 THEN 1 ELSE NULL END,
			[IdentitySeed] = i.seed_value,
			[IdentityIncrement] = i.increment_value, 
			[AllowNulls] = CASE WHEN c.is_nullable=1 THEN 1 ELSE NULL END,
			[Position] = c.column_id,
			[DataType] = t.name +
				CASE WHEN t.name IN ('char', 'varchar','nchar','nvarchar','varbinary') THEN '('+
							CASE WHEN c.max_length=-1 THEN 'MAX'
								ELSE CONVERT(VARCHAR(4),
											CASE WHEN t.name IN ('nchar','nvarchar')
											THEN  c.max_length/2 ELSE c.max_length END )
								END +')'
								WHEN t.name IN ('decimal','numeric')
										THEN '('+ CONVERT(VARCHAR(4),c.precision)+','
												+ CONVERT(VARCHAR(4),c.Scale)+')'
								WHEN t.name IN ('datetime2', 'datetimeoffset')
										THEN '('+ CONVERT(VARCHAR(4),c.Scale)+')'
								ELSE '' END,
			[Collation] = CASE WHEN c.collation_name!=SERVERPROPERTY('collation') THEN c.collation_name ELSE null END,
			[RowGuid] = CASE WHEN c.is_rowguidcol=1 THEN 1 ELSE NULL END,
			[Sparse] = CASE WHEN c.is_sparse=1 THEN 1 ELSE NULL END,
			[FileStream] = CASE WHEN c.is_filestream=1 THEN 1 ELSE NULL END,
			[ComputedExp] = cc.definition, 
			[Persisted] = CASE WHEN cc.is_persisted=1 THEN 1 ELSE NULL END,
			[DefaultValue] = object_definition(c.default_object_id) ,
			--[ValidationExp] = cc2.definition, --ISSUE: only one check per Column
			--[withCheck] = cc2.type_desc,
			[Comment] = ep.[value]

			FROM     sys.columns c 
					 JOIN sys.types t ON c.user_type_id = t.user_type_id 
					 LEFT JOIN sys.identity_columns i ON c.object_id=i.object_id AND c.column_id=i.column_id
					 LEFT JOIN sys.computed_columns cc ON o.object_id = cc.object_id and cc.column_id = c.column_id
					 LEFT JOIN sys.extended_properties ep on o.object_id = ep.major_id
                                         and c.column_id = ep.minor_id
                                         and ep.name = 'MS_Description'
										 and ep.class = 1
					 --LEFT JOIN sys.check_constraints cc2 ON cc2.parent_object_id = o.object_id and cc2.parent_column_id = c.column_id AND cc2.type = 'C'

			WHERE    
				o.object_id = c.object_id
			ORDER BY 
				o.Name, c.column_id
			FOR XML RAW ('Column'), TYPE, ROOT('Columns')
		),
	   -- Get Indexes
	   (
	   	SELECT	
			[Name] = i.name,
			[IsClustered] = CASE WHEN i.type=1 THEN 1 ELSE NULL END,
			[IsUnique] = CASE WHEN i.is_unique=1 THEN 1 ELSE NULL END,
			[IsPrimary] = CASE WHEN i.is_primary_key=1 THEN 1 ELSE NULL END,
			[IsUniqueConstraint] = CASE WHEN i.is_unique_constraint=1 THEN 1 ELSE NULL END,
			[WhereExp] = i.filter_definition,

			 --members
				 (
				 SELECT	
						 [Column] =c.name, 
						 [Position] = ic.key_ordinal,
						 [SortDesc] = CASE WHEN ic.is_descending_key=1 THEN 1 ELSE NULL END
						 --,[IsIncluded] = ic.is_included_column

						 FROM sys.index_columns ic 
							 JOIN sys.indexes iInner ON ic.object_id = iInner.object_id 
								AND ic.index_id = iInner.index_id AND ic.is_included_column=0
							 JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id 
						 WHERE
								o.object_id = ic.object_id  
								AND i.index_id = iInner.index_id
							 --o.type = 'U'
							 --AND o.Name in ('Address') --table filter
						 ORDER BY o.name, i.name, ic.key_ordinal
						 FOR XML RAW ('Member'), TYPE, ROOT('Members'))

			--,i.*
			FROM     sys.indexes i 
			WHERE    o.object_id = i.object_id
				    AND i.type  != 0 -- Not a Heap			 
			--o.type = 'U' 
				--AND s.Name in ('dbo','lkp','dbo') --schema filter
				--AND o.Name in ('Address','CompanyAddress', 'Company', 'Wapla') --table filter
			ORDER BY o.Name, i.Name
			FOR XML RAW ('Index'), TYPE, ROOT('Indexes')
	),
	--Get ForeignKeys
    (
		  SELECT	
		  [Name] = fk.name,
		  [PkTableSchema] = s2.name,
		  [PkTable] = o2.name,

		  --foreignKeyColumns
		   (
		   SELECT	
				   [FkColumn] = c1.name,
				   [Position] = fkc.constraint_column_id,
				   [PkColumn] = c2.name

				   FROM 
					   sys.foreign_key_columns fkc 
					   INNER JOIN sys.columns c1 ON fkc.parent_object_id = c1.object_id AND fkc.parent_column_id = c1.column_id 
					   INNER JOIN sys.columns c2 ON fkc.referenced_object_id = c2.object_id AND fkc.referenced_column_id = c2.column_id
					   INNER JOIN sys.schemas s1 ON s1.schema_id = o1.schema_id
				   WHERE fk.object_id = fkc.constraint_object_id
				   --   s1.Name in ('dbo','lkp')--schema filter
				   --	AND o1.Name in ('Address','CompanyAddress', 'Company') --table filter
				   ORDER BY o1.name, fkc.constraint_column_id
				   FOR XML RAW ('ForeignKeyColumn'), TYPE, ROOT('ForeignKeyColumns'))

		  FROM sys.foreign_keys fk 
			 INNER JOIN sys.objects o1 ON o1.object_id = fk.parent_object_id
			 INNER JOIN sys.objects o2 ON fk.referenced_object_id = o2.object_id
			 INNER JOIN sys.schemas s1 ON s1.schema_id = fk.schema_id
			 INNER JOIN sys.schemas s2 ON s2.schema_id = o2.schema_id
		  WHERE
			  o.object_id = o1.object_id 
		  ORDER BY o1.name, fk.name
		  FOR XML RAW ('ForeignKey'), TYPE, ROOT('ForeignKeys')
    )

	
    FROM    sys.tables o 
			 JOIN sys.schemas s ON o.schema_id = s.schema_id
    WHERE   o.type = 'U' 
	   --AND s.Name in ('test') --schema filter
	   --AND o.Name in ('Address','CompanyAddress', 'Company') --table filter
    ORDER BY o.Name
    FOR XML RAW ('Table'), TYPE, ROOT('Tables')
	)
FOR XML RAW ('ExportSchemaXml')