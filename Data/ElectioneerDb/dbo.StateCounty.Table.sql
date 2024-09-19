USE [Electioneer]
GO
/****** Object:  Table [dbo].[StateCounty]    Script Date: 9/19/2024 3:30:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StateCounty](
	[CountyKey] [bigint] IDENTITY(1,1) NOT NULL,
	[CountyId] [uniqueidentifier] NOT NULL,
	[StateCode] [char](3) NOT NULL,
	[County] [nvarchar](128) NOT NULL,
	[FipsId] [char](6) NOT NULL,
	[StateCountyId] [nvarchar](128) NULL,
 CONSTRAINT [PK_StateCounty] PRIMARY KEY CLUSTERED 
(
	[CountyKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_StateCounty]    Script Date: 9/19/2024 3:30:33 PM ******/
CREATE NONCLUSTERED INDEX [IX_StateCounty] ON [dbo].[StateCounty]
(
	[StateCode] ASC,
	[County] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_StateCounty_FipsId]    Script Date: 9/19/2024 3:30:33 PM ******/
CREATE NONCLUSTERED INDEX [IX_StateCounty_FipsId] ON [dbo].[StateCounty]
(
	[FipsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_StateCounty_Id]    Script Date: 9/19/2024 3:30:33 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_StateCounty_Id] ON [dbo].[StateCounty]
(
	[CountyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StateCounty] ADD  CONSTRAINT [DF_StateCounty_CountyId]  DEFAULT (newid()) FOR [CountyId]
GO
