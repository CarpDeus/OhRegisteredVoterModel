USE [Electioneer]
GO
/****** Object:  Table [dbo].[ElectionLevels]    Script Date: 9/19/2024 3:30:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ElectionLevels](
	[ElectionLevelId] [int] IDENTITY(1,1) NOT NULL,
	[ElectionLevel] [nvarchar](28) NOT NULL,
	[ElectionLevelDescription] [nvarchar](1024) NULL,
PRIMARY KEY CLUSTERED 
(
	[ElectionLevelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
