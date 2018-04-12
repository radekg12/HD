DROP TABLE [dbo].[TargetGroups];
GO


DROP TABLE [dbo].[KategorieKanalow];
GO


DROP TABLE [dbo].[GrupyMedioweKanalow];
GO


DROP TABLE [dbo].[Event];
GO


--************************************** [dbo].[TargetGroups]

CREATE TABLE [dbo].[TargetGroups]
(
 [Nazwa] VARCHAR(50) NULL ,
 [Kod]   VARCHAR(50) NULL ,


);
GO



--************************************** [dbo].[KategorieKanalow]

CREATE TABLE [dbo].[KategorieKanalow]
(
 [F1] NVARCHAR(255) NULL ,
 [F2] NVARCHAR(255) NULL ,


);
GO



--************************************** [dbo].[GrupyMedioweKanalow]

CREATE TABLE [dbo].[GrupyMedioweKanalow]
(
 [F1] FLOAT NULL ,
 [F2] NVARCHAR(255) NULL ,


);
GO



--************************************** [dbo].[Event]

CREATE TABLE [dbo].[Event]
(
 [Date]              VARCHAR(50) NULL ,
 [Channel]           VARCHAR(50) NULL ,
 [Description]       VARCHAR(100) NULL ,
 [2nd Description]   VARCHAR(100) NULL ,
 [Start time]        VARCHAR(50) NULL ,
 [Duration]          VARCHAR(50) NULL ,
 [Variable\Target]   VARCHAR(50) NULL ,
 [Total Individuals] VARCHAR(50) NULL ,
 [Podgrupa]          VARCHAR(50) NULL ,
 [A16-49]            VARCHAR(50) NULL ,
 [M16-49]            VARCHAR(50) NULL ,
 [A4-15]             VARCHAR(50) NULL ,
 [A4-9]              VARCHAR(50) NULL ,


);
GO