USE [Electioneer]
GO
/****** Object:  Table [dbo].[Elections]    Script Date: 9/19/2024 3:30:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Elections](
	[ElectionId] [bigint] IDENTITY(1,1) NOT NULL,
	[StateCode] [char](2) NOT NULL,
	[ElectionTypeId] [int] NOT NULL,
	[ElectionLevelId] [int] NOT NULL,
	[ElectionDate] [date] NOT NULL,
	[ElectionStateLookup] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ElectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
