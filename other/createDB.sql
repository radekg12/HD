DROP TABLE [dbo].[Viewership];
GO


DROP TABLE [dbo].[Event];
GO


DROP TABLE [dbo].[Channel];
GO

DROP TABLE [dbo].[Program];
GO


DROP TABLE [dbo].[Time];
GO

DROP TABLE [dbo].[Date];
GO


DROP TABLE [dbo].[TargetGroup];
GO


DROP TABLE [dbo].[MediaGroup];
GO


DROP TABLE [dbo].[ChannelCategory];
GO

--DROP TABLE [dbo].#dim;
--GO

DROP FUNCTION [dbo].GetEasterHolidays
GO


--************************************** [dbo].[Program]

CREATE TABLE [dbo].[Program]
(
 [ProgramID]      INT IDENTITY (1, 1) NOT NULL ,
 [Description]    NVARCHAR(100) NOT NULL ,
 [2ndDescription] NVARCHAR(100) NOT NULL ,

 CONSTRAINT [PK_Program] PRIMARY KEY CLUSTERED ([ProgramID] ASC)
);
GO


--************************************** [dbo].[Time]

CREATE TABLE [dbo].[Time]
(
 [Time]   TIME NOT NULL ,
 [Hour]   TINYINT NOT NULL ,
 [Minute] TINYINT NOT NULL ,
 [Second] TINYINT NOT NULL ,
 [AmPm]   CHAR(2) NOT NULL ,
 [TimeID] CHAR(6) NOT NULL ,

 CONSTRAINT [PK_Time] PRIMARY KEY CLUSTERED ([TimeID] ASC)
);
GO

--************************************** [dbo].[Date]

CREATE TABLE [dbo].[Date]
(
  [DateID]            INT         NOT NULL,
  [Date]              DATE        NOT NULL,
  [Day]               TINYINT     NOT NULL,
  DaySuffix           CHAR(2)     NOT NULL,
  [Weekday]           TINYINT     NOT NULL,
  WeekDayName         VARCHAR(10) NOT NULL,
  IsWeekend           BIT         NOT NULL,
  IsHoliday           BIT         NOT NULL,
  HolidayText         VARCHAR(64) SPARSE,
  DOWInMonth          TINYINT     NOT NULL,
  [DayOfYear]         SMALLINT    NOT NULL,
  WeekOfMonth         TINYINT     NOT NULL,
  WeekOfYear          TINYINT     NOT NULL,
  ISOWeekOfYear       TINYINT     NOT NULL,
  [Month]             TINYINT     NOT NULL,
  [MonthName]         VARCHAR(10) NOT NULL,
  [Quarter]           TINYINT     NOT NULL,
  QuarterName         VARCHAR(6)  NOT NULL,
  [Year]              INT         NOT NULL,
  MMYYYY              CHAR(6)     NOT NULL,
  MonthYear           CHAR(7)     NOT NULL,
  FirstDayOfMonth     DATE        NOT NULL,
  LastDayOfMonth      DATE        NOT NULL,
  FirstDayOfQuarter   DATE        NOT NULL,
  LastDayOfQuarter    DATE        NOT NULL,
  FirstDayOfYear      DATE        NOT NULL,
  LastDayOfYear       DATE        NOT NULL,
  FirstDayOfNextMonth DATE        NOT NULL,
  FirstDayOfNextYear  DATE        NOT NULL

    CONSTRAINT [PK_DATA] PRIMARY KEY CLUSTERED ([DateID] ASC)
);
GO


--************************************** [dbo].[TargetGroup]

CREATE TABLE [dbo].[TargetGroup]
(
  [TargetGroupID] INT IDENTITY (1, 1) NOT NULL,
  [Name]          NVARCHAR(50)        NULL,
  [Code]          NVARCHAR(50)        NOT NULL,

  CONSTRAINT [PK_TargetGrupa] PRIMARY KEY CLUSTERED ([TargetGroupID] ASC)
);
GO


--************************************** [dbo].[MediaGroup]

CREATE TABLE [dbo].[MediaGroup]
(
  [MediaGroupID] INT IDENTITY (1, 1) NOT NULL,
  [Name]         NVARCHAR(50)        NOT NULL,

  CONSTRAINT [PK_GrMediowa] PRIMARY KEY CLUSTERED ([MediaGroupID] ASC)
);
GO


--************************************** [dbo].[ChannelCategory]

CREATE TABLE [dbo].[ChannelCategory]
(
  [ChannelCategoryID] INT IDENTITY (1, 1) NOT NULL,
  [Name]              NVARCHAR(50)        NOT NULL,

  CONSTRAINT [PK_KategorieKanalow] PRIMARY KEY CLUSTERED ([ChannelCategoryID] ASC)
);
GO


--************************************** [dbo].[Channel]

CREATE TABLE [dbo].[Channel]
(
  [ChanelID]          INT IDENTITY (1, 1) NOT NULL,
  [MediaGroupID]      INT                 NULL,
  [ChannelCategoryID] INT                 NULL,
  [Name]              NVARCHAR(50)        NOT NULL,
  [OldName]           NVARCHAR(50)        NULL,

  CONSTRAINT [PK_Kanały] PRIMARY KEY CLUSTERED ([ChanelID] ASC),
  CONSTRAINT [FK_120] FOREIGN KEY ([ChannelCategoryID])
  REFERENCES [dbo].[ChannelCategory] ([ChannelCategoryID]),
  CONSTRAINT [FK_124] FOREIGN KEY ([MediaGroupID])
  REFERENCES [dbo].[MediaGroup] ([MediaGroupID])
);
GO


--SKIP Index: [fkIdx_120]

--SKIP Index: [fkIdx_124]


--************************************** [dbo].[Event]

CREATE TABLE [dbo].[Event]
(
 [EventID]         INT IDENTITY (1, 1) NOT NULL ,
 [DateID_start]    INT NOT NULL ,
 [DateID_end]      INT NOT NULL ,
 [StageEventID]    INT NOT NULL ,
 [ProgramID]       INT NOT NULL ,
 [DateTvID]        INT NOT NULL ,
 [ChanelID]        INT NULL ,
 [TimeID_start]    CHAR(6) NOT NULL ,
 [TimeID_end]      CHAR(6) NOT NULL ,
 [StartTimeTv]     NVARCHAR(20) NOT NULL ,
 [TimeID_duration] CHAR(6) NOT NULL ,

 CONSTRAINT [PK_Emisja] PRIMARY KEY CLUSTERED ([EventID] ASC),
 CONSTRAINT [FK_116] FOREIGN KEY ([DateID_start])
  REFERENCES [dbo].[Date]([DateID]),
 CONSTRAINT [FK_128] FOREIGN KEY ([ChanelID])
  REFERENCES [dbo].[Channel]([ChanelID]),
 CONSTRAINT [FK_183] FOREIGN KEY ([DateTvID])
  REFERENCES [dbo].[Date]([DateID]),
 CONSTRAINT [FK_202] FOREIGN KEY ([TimeID_start])
  REFERENCES [dbo].[Time]([TimeID]),
 CONSTRAINT [FK_206] FOREIGN KEY ([TimeID_end])
  REFERENCES [dbo].[Time]([TimeID]),
 CONSTRAINT [FK_210] FOREIGN KEY ([DateID_end])
  REFERENCES [dbo].[Date]([DateID]),
 CONSTRAINT [FK_214] FOREIGN KEY ([TimeID_duration])
  REFERENCES [dbo].[Time]([TimeID]),
 CONSTRAINT [FK_224] FOREIGN KEY ([ProgramID])
  REFERENCES [dbo].[Program]([ProgramID])
);
GO


--SKIP Index: [fkIdx_116]

--SKIP Index: [fkIdx_128]

--SKIP Index: [fkIdx_183]

--SKIP Index: [fkIdx_202]

--SKIP Index: [fkIdx_206]

--SKIP Index: [fkIdx_210]

--SKIP Index: [fkIdx_214]


--************************************** [dbo].[Viewership]

CREATE TABLE [dbo].[Viewership]
(
 [ViewershipID]  INT IDENTITY (1, 1) NOT NULL ,
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


-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
DECLARE @StartDate DATE = '20000101', @NumberOfYears INT = 30;

-- prevent set or regional settings from interfering with
-- interpretation of dates / literals

SET DATEFIRST 7;
SET DATEFORMAT mdy;
SET LANGUAGE US_ENGLISH;

DECLARE @CutoffDate DATE = DATEADD(YEAR, @NumberOfYears, @StartDate);

-- this is just a holding table for intermediate calculations:

CREATE TABLE #dim
(
  [date] DATE PRIMARY KEY,
  [day]        AS DATEPART(DAY, [date]),
  [month]      AS DATEPART(MONTH, [date]),
  FirstOfMonth AS CONVERT(DATE, DATEADD(MONTH, DATEDIFF(MONTH, 0, [date]), 0)),
  [MonthName]  AS DATENAME(MONTH, [date]),
  [week]       AS DATEPART(WEEK, [date]),
  [ISOweek]    AS DATEPART(ISO_WEEK, [date]),
  [DayOfWeek]  AS DATEPART(WEEKDAY, [date]),
  [quarter]    AS DATEPART(QUARTER, [date]),
  [year]       AS DATEPART(YEAR, [date]),
  FirstOfYear  AS CONVERT(DATE, DATEADD(YEAR, DATEDIFF(YEAR, 0, [date]), 0)),
  Style112     AS CONVERT(CHAR(8), [date], 112),
  Style101     AS CONVERT(CHAR(10), [date], 101)
);

-- use the catalog views to generate as many rows as we need

INSERT #dim ([date])
  SELECT d
  FROM
    (
      SELECT d = DATEADD(DAY, rn - 1, @StartDate)
      FROM
        (
          SELECT TOP (DATEDIFF(DAY, @StartDate, @CutoffDate)) rn = ROW_NUMBER()
          OVER (
            ORDER BY s1.[object_id] )
          FROM sys.all_objects AS s1
            CROSS JOIN sys.all_objects AS s2
          -- on my system this would support > 5 million days
          ORDER BY s1.[object_id]
        ) AS x
    ) AS y;

INSERT dbo.Date WITH ( TABLOCKX )
  SELECT
      DateID = CONVERT(INT, Style112),
      [Date] = [date],
      [Day] = CONVERT(TINYINT, [day]),
      DaySuffix = CONVERT(CHAR(2), CASE WHEN [day] / 10 = 1
        THEN 'th'
                                   ELSE
                                     CASE RIGHT([day], 1)
                                     WHEN '1'
                                       THEN 'st'
                                     WHEN '2'
                                       THEN 'nd'
                                     WHEN '3'
                                       THEN 'rd'
                                     ELSE 'th' END END),
      [Weekday] = CONVERT(TINYINT, [DayOfWeek]),
      [WeekDayName] = CONVERT(VARCHAR(10), DATENAME(WEEKDAY, [date])),
      [IsWeekend] = CONVERT(BIT, CASE WHEN [DayOfWeek] IN (1, 7)
        THEN 1
                                 ELSE 0 END),
      [IsHoliday] = CONVERT(BIT, 0),
      HolidayText = CONVERT(VARCHAR(64), NULL),
      [DOWInMonth] = CONVERT(TINYINT, ROW_NUMBER()
      OVER
        ( PARTITION BY FirstOfMonth, [DayOfWeek]
        ORDER BY [date] )),
      [DayOfYear] = CONVERT(SMALLINT, DATEPART(DAYOFYEAR, [date])),
      WeekOfMonth = CONVERT(TINYINT, DENSE_RANK()
      OVER
        ( PARTITION BY [year], [month]
        ORDER BY [week] )),
      WeekOfYear = CONVERT(TINYINT, [week]),
      ISOWeekOfYear = CONVERT(TINYINT, ISOWeek),
      [Month] = CONVERT(TINYINT, [month]),
      [MonthName] = CONVERT(VARCHAR(10), [MonthName]),
      [Quarter] = CONVERT(TINYINT, [quarter]),
      QuarterName = CONVERT(VARCHAR(6), CASE [quarter]
                                        WHEN 1
                                          THEN 'First'
                                        WHEN 2
                                          THEN 'Second'
                                        WHEN 3
                                          THEN 'Third'
                                        WHEN 4
                                          THEN 'Fourth' END),
      [Year] = [year],
      MMYYYY = CONVERT(CHAR(6), LEFT(Style101, 2) + LEFT(Style112, 4)),
      MonthYear = CONVERT(CHAR(7), LEFT([MonthName], 3) + LEFT(Style112, 4)),
      FirstDayOfMonth = FirstOfMonth,
      LastDayOfMonth = MAX([date])
      OVER ( PARTITION BY [year], [month]),
      FirstDayOfQuarter = MIN([date])
      OVER ( PARTITION BY [year], [quarter]),
      LastDayOfQuarter = MAX([date])
      OVER ( PARTITION BY [year], [quarter]),
      FirstDayOfYear = FirstOfYear,
      LastDayOfYear = MAX([date])
      OVER ( PARTITION BY [year]),
      FirstDayOfNextMonth = DATEADD(MONTH, 1, FirstOfMonth),
      FirstDayOfNextYear = DATEADD(YEAR, 1, FirstOfYear)
  FROM #dim
OPTION (MAXDOP 1);

;
WITH x AS
(
    SELECT
      DateID,
      [Date],
      IsHoliday,
      HolidayText,
      FirstDayOfYear,
      DOWInMonth,
      [MonthName],
      [WeekDayName],
      [Day],
        LastDOWInMonth = ROW_NUMBER()
      OVER
        (
      PARTITION BY FirstDayOfMonth, [Weekday]
        ORDER BY [Date] DESC
        )
    FROM dbo.Date
)
UPDATE x
SET IsHoliday = 1, HolidayText = CASE
                                 WHEN ([Date] = FirstDayOfYear)
                                   THEN 'New Year''s Day'
                                 WHEN ([DOWInMonth] = 3 AND [MonthName] = 'January' AND [WeekDayName] = 'Monday')
                                   THEN 'Martin Luther King Day' -- (3rd Monday in January)
                                 WHEN ([DOWInMonth] = 3 AND [MonthName] = 'February' AND [WeekDayName] = 'Monday')
                                   THEN 'President''s Day' -- (3rd Monday in February)
                                 WHEN ([LastDOWInMonth] = 1 AND [MonthName] = 'May' AND [WeekDayName] = 'Monday')
                                   THEN 'Memorial Day' -- (last Monday in May)
                                 WHEN ([MonthName] = 'July' AND [Day] = 4)
                                   THEN 'Independence Day' -- (July 4th)
                                 WHEN ([DOWInMonth] = 1 AND [MonthName] = 'September' AND [WeekDayName] = 'Monday')
                                   THEN 'Labour Day' -- (first Monday in September)
                                 WHEN ([DOWInMonth] = 2 AND [MonthName] = 'October' AND [WeekDayName] = 'Monday')
                                   THEN 'Columbus Day' -- Columbus Day (second Monday in October)
                                 WHEN ([MonthName] = 'November' AND [Day] = 11)
                                   THEN 'Veterans'' Day' -- Veterans' Day (November 11th)
                                 WHEN ([DOWInMonth] = 4 AND [MonthName] = 'November' AND [WeekDayName] = 'Thursday')
                                   THEN 'Thanksgiving Day' -- Thanksgiving Day (fourth Thursday in November)
                                 WHEN ([MonthName] = 'December' AND [Day] = 25)
                                   THEN 'Christmas Day'
                                 END
WHERE
  ([Date] = FirstDayOfYear)
  OR ([DOWInMonth] = 3 AND [MonthName] = 'January' AND [WeekDayName] = 'Monday')
  OR ([DOWInMonth] = 3 AND [MonthName] = 'February' AND [WeekDayName] = 'Monday')
  OR ([LastDOWInMonth] = 1 AND [MonthName] = 'May' AND [WeekDayName] = 'Monday')
  OR ([MonthName] = 'July' AND [Day] = 4)
  OR ([DOWInMonth] = 1 AND [MonthName] = 'September' AND [WeekDayName] = 'Monday')
  OR ([DOWInMonth] = 2 AND [MonthName] = 'October' AND [WeekDayName] = 'Monday')
  OR ([MonthName] = 'November' AND [Day] = 11)
  OR ([DOWInMonth] = 4 AND [MonthName] = 'November' AND [WeekDayName] = 'Thursday')
  OR ([MonthName] = 'December' AND [Day] = 25);
GO

UPDATE d
SET IsHoliday = 1, HolidayText = 'Black Friday'
FROM dbo.Date AS d
  INNER JOIN
  (
    SELECT
      DateID,
      [Year],
      [DayOfYear]
    FROM dbo.Date
    WHERE HolidayText = 'Thanksgiving Day'
  ) AS src
    ON d.[Year] = src.[Year]
       AND d.[DayOfYear] = src.[DayOfYear] + 1;
GO

CREATE FUNCTION dbo.GetEasterHolidays(@year INT)
  RETURNS TABLE
  WITH SCHEMABINDING
  AS
  RETURN
  (
  WITH x AS
  (
      SELECT [Date] = CONVERT(DATE, RTRIM(@year) + '0' + RTRIM([Month])
                                    + RIGHT('0' + RTRIM([Day]), 2))
      FROM (SELECT
              [Month],
                [Day] = DaysToSunday + 28 - (31 * ([Month] / 4))
            FROM (SELECT
                      [Month] = 3 + (DaysToSunday + 40) / 44,
                    DaysToSunday
                  FROM (SELECT DaysToSunday = paschal - ((@year + @year / 4 + paschal - 13) % 7)
                        FROM (SELECT paschal = epact - (epact / 28)
                              FROM (SELECT epact = (24 + 19 * (@year % 19)) % 30)
                                AS epact) AS paschal) AS dts) AS m) AS d
  )
  SELECT
    [Date],
      HolidayName = 'Easter Sunday'
  FROM x
  UNION ALL SELECT
              DATEADD(DAY, -2, [Date]),
              'Good Friday'
            FROM x
  UNION ALL SELECT
              DATEADD(DAY, 1, [Date]),
              'Easter Monday'
            FROM x
  );
GO

WITH x AS
(
    SELECT
      d.[Date],
      d.IsHoliday,
      d.HolidayText,
      h.HolidayName
    FROM dbo.Date AS d
      CROSS APPLY dbo.GetEasterHolidays(d.[Year]) AS h
    WHERE d.[Date] = h.[Date]
)
UPDATE x
SET IsHoliday = 1, HolidayText = HolidayName;
GO

------------------------------------------------------------------------------------------------
--*******************************************************TIME
-------------------------------------------------------------------------
CREATE TABLE #dim2
(
  [Time]   TIME,
  [Hour]   TINYINT,
  [Minute] TINYINT,
  [Second] TINYINT,
  [AmPm]   CHAR(2),
  [TimeID] CHAR(6),
);
GO

-- use the catalog views to generate as many rows as we need

DECLARE @Time DATETIME
SET @TIME = CONVERT(VARCHAR, '12:00:00 AM', 108)

SELECT @TIME
SELECT CONVERT(VARCHAR, @TIME, 108)
TRUNCATE TABLE #dim2

WHILE @TIME <= '11:59:59 PM'
  BEGIN
    INSERT INTO #dim2 ([TimeID], [Time], [Hour], [Minute], [Second], [AmPm])
      SELECT
        REPLACE(CONVERT(CHAR, @TIME, 108), ':', '') [TimeID],
        CONVERT(TIME, @TIME, 108)                   [Time],
        DATEPART(Hour, @Time)                       [Hour],
        DATEPART(MINUTE, @Time)                     [Minute],
        DATEPART(SECOND, @Time)                     [Second],
        CASE
        WHEN DATEPART(HOUR, @Time) >= 12
          THEN 'PM'
        ELSE 'AM'
        END AS                                      [AmPm]
    SELECT @TIME = DATEADD(second, 1, @Time)
  END
GO

INSERT INTO Time
  SELECT *
  FROM #dim2
GO
