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

CREATE TABLE hd.dbo.GrupyMedioweKanalow
(
    GmkID INT IDENTITY (1, 1) NOT NULL,
    F1 INT,
    Kanal NVARCHAR(255),
    Grupa NVARCHAR(255)
)



--************************************** [dbo].[Event]

CREATE TABLE hd.dbo.Event
(
    EventID INT IDENTITY (1, 1) NOT NULL,
    Date VARCHAR(50),
    Channel VARCHAR(50),
    Description VARCHAR(100),
    [2nd Description] VARCHAR(100),
    [Start time] VARCHAR(50),
    Duration VARCHAR(50),
    [Variable\Target] VARCHAR(50),
    [Total Individuals] VARCHAR(50),
    Podgrupa VARCHAR(50),
    [A16-49] VARCHAR(50),
    [M16-49] VARCHAR(50),
    [A4-15] VARCHAR(50),
    [A4-9] VARCHAR(50)
)
GO