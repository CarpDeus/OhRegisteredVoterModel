USE [ElectioneerStaging]
GO
/****** Object:  Table [staging].[OhioElections]    Script Date: 9/19/2024 3:36:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[OhioElections](
	[ElectionID] [bigint] IDENTITY(1,1) NOT NULL,
	[ElectionName] [varchar](50) NULL,
	[ElectionDate] [date] NULL,
	[ElectionType] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ElectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
