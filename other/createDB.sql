DROP TABLE [dbo].[Viewership];
GO


DROP TABLE [dbo].[Event];
GO


DROP TABLE [dbo].[Channel];
GO


DROP TABLE [dbo].[Date];
GO


DROP TABLE [dbo].[TargetGroup];
GO


DROP TABLE [dbo].[MediaGroup];
GO


DROP TABLE [dbo].[ChannelCategory];
GO


--************************************** [dbo].[Date]

CREATE TABLE [dbo].[Date]
(
 [DateID] VARCHAR(10) NOT NULL ,

 CONSTRAINT [PK_DATA] PRIMARY KEY CLUSTERED ([DateID] ASC)
);
GO



--************************************** [dbo].[TargetGroup]

CREATE TABLE [dbo].[TargetGroup]
(
 [Code] VARCHAR(10) NOT NULL ,
 [Name] TEXT NULL ,

 CONSTRAINT [PK_TargetGrupa] PRIMARY KEY CLUSTERED ([Code] ASC)
);
GO



--************************************** [dbo].[MediaGroup]

CREATE TABLE [dbo].[MediaGroup]
(
 [MediaGroupID] INT NOT NULL ,
 [Name]         TEXT NOT NULL ,

 CONSTRAINT [PK_GrMediowa] PRIMARY KEY CLUSTERED ([MediaGroupID] ASC)
);
GO



--************************************** [dbo].[ChannelCategory]

CREATE TABLE [dbo].[ChannelCategory]
(
 [ChannelCategoryID] INT NOT NULL ,
 [Name]              TEXT NOT NULL ,

 CONSTRAINT [PK_KategorieKanalow] PRIMARY KEY CLUSTERED ([ChannelCategoryID] ASC)
);
GO



--************************************** [dbo].[Channel]

CREATE TABLE [dbo].[Channel]
(
 [ChanelID]          INT NOT NULL ,
 [MediaGroupID]      INT NOT NULL ,
 [ChannelCategoryID] INT NOT NULL ,
 [Name]              TEXT NOT NULL ,

 CONSTRAINT [PK_Kanały] PRIMARY KEY CLUSTERED ([ChanelID] ASC),
 CONSTRAINT [FK_120] FOREIGN KEY ([ChannelCategoryID])
  REFERENCES [dbo].[ChannelCategory]([ChannelCategoryID]),
 CONSTRAINT [FK_124] FOREIGN KEY ([MediaGroupID])
  REFERENCES [dbo].[MediaGroup]([MediaGroupID])
);
GO


--SKIP Index: [fkIdx_120]

--SKIP Index: [fkIdx_124]


--************************************** [dbo].[Event]

CREATE TABLE [dbo].[Event]
(
 [EventID]        INT NOT NULL ,
 [DateID]         VARCHAR(10) NOT NULL ,
 [ChanelID]       INT NOT NULL ,
 [Description]    TEXT NOT NULL ,
 [2ndDescription] TEXT NOT NULL ,
 [StartTime]      TIME NOT NULL ,
 [EndTime]        TIME NOT NULL ,
 [Duration]       TIME NOT NULL ,

 CONSTRAINT [PK_Emisja] PRIMARY KEY CLUSTERED ([EventID] ASC),
 CONSTRAINT [FK_116] FOREIGN KEY ([DateID])
  REFERENCES [dbo].[Date]([DateID]),
 CONSTRAINT [FK_128] FOREIGN KEY ([ChanelID])
  REFERENCES [dbo].[Channel]([ChanelID])
);
GO


--SKIP Index: [fkIdx_116]

--SKIP Index: [fkIdx_128]


--************************************** [dbo].[Viewership]

CREATE TABLE [dbo].[Viewership]
(
 [ViewershipID] INT NOT NULL ,
 [EventID]      INT NOT NULL ,
 [Code]         VARCHAR(10) NOT NULL ,
 [ARM]          FLOAT NOT NULL ,
 [ARM%]         FLOAT NOT NULL ,
 [SHR]          FLOAT NOT NULL ,
 [RCH%]         FLOAT NOT NULL ,
 [RCH]          FLOAT NOT NULL ,

 CONSTRAINT [PK_Wartosc] PRIMARY KEY CLUSTERED ([ViewershipID] ASC),
 CONSTRAINT [FK_132] FOREIGN KEY ([EventID])
  REFERENCES [dbo].[Event]([EventID]),
 CONSTRAINT [FK_136] FOREIGN KEY ([Code])
  REFERENCES [dbo].[TargetGroup]([Code])
);
GO


--SKIP Index: [fkIdx_132]

--SKIP Index: [fkIdx_136]