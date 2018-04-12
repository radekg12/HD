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
 [DateID]              INT NOT NULL ,
 [Date]                DATE NOT NULL ,
 [Day]                 TINYINT NOT NULL ,
 [DaySuffix]           CHAR(2) NOT NULL ,
 [Weekday]             TINYINT NOT NULL ,
 [WeekDayName]         VARCHAR(10) NOT NULL ,
 [IsWeekend]           BIT NOT NULL ,
 [IsHoliday]           BIT NOT NULL ,
 [HolidayText]         VARCHAR(64) NOT NULL ,
 [DOWInMonth]          TINYINT NOT NULL ,
 [DayOfYear]           SMALLINT NOT NULL ,
 [WeekOfMonth]         TINYINT NOT NULL ,
 [WeekOfYear]          TINYINT NOT NULL ,
 [ISOWeekOfYear]       TINYINT NOT NULL ,
 [Month]               TINYINT NOT NULL ,
 [MonthName]           VARCHAR(10) NOT NULL ,
 [Quarter]             TINYINT NOT NULL ,
 [QuarterName]         VARCHAR(6) NOT NULL ,
 [Year]                INT NOT NULL ,
 [MMYYYY]              CHAR(6) NOT NULL ,
 [MonthYear]           CHAR(7) NOT NULL ,
 [FirstDayOfMonth]     DATE NOT NULL ,
 [LastDayOfMonth]      DATE NOT NULL ,
 [FirstDayOfQuarter]   DATE NOT NULL ,
 [LastDayOfQuarter_1]  DATE NOT NULL ,
 [FirstDayOfYear]      DATE NOT NULL ,
 [LastDayOfYear]       DATE NOT NULL ,
 [FirstDayOfNextMonth] DATE NOT NULL ,
 [FirstDayOfNextYear]  DATE NOT NULL ,

 CONSTRAINT [PK_DATA] PRIMARY KEY CLUSTERED ([DateID] ASC)
);
GO



--************************************** [dbo].[TargetGroup]

CREATE TABLE [dbo].[TargetGroup]
(
 [TargetGroupID] INT NOT NULL ,
 [Name]          TEXT NULL ,
 [Code]          VARCHAR(10) NOT NULL ,

 CONSTRAINT [PK_TargetGrupa] PRIMARY KEY CLUSTERED ([TargetGroupID] ASC)
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
 [DateID]         INT NOT NULL ,
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
 [ViewershipID]  INT NOT NULL ,
 [EventID]       INT NOT NULL ,
 [TargetGroupID] INT NOT NULL ,
 [ARM]           FLOAT NOT NULL ,
 [ARM%]          FLOAT NOT NULL ,
 [SHR]           FLOAT NOT NULL ,
 [RCH%]          FLOAT NOT NULL ,
 [RCH]           FLOAT NOT NULL ,

 CONSTRAINT [PK_Wartosc] PRIMARY KEY CLUSTERED ([ViewershipID] ASC),
 CONSTRAINT [FK_132] FOREIGN KEY ([EventID])
  REFERENCES [dbo].[Event]([EventID]),
 CONSTRAINT [FK_136] FOREIGN KEY ([TargetGroupID])
  REFERENCES [dbo].[TargetGroup]([TargetGroupID])
);
GO


--SKIP Index: [fkIdx_132]

--SKIP Index: [fkIdx_136]