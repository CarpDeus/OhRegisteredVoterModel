USE [Electioneer]
GO
/****** Object:  Table [dbo].[Precinct]    Script Date: 9/19/2024 3:30:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Precinct](
	[PrecinctKey] [bigint] IDENTITY(1,1) NOT NULL,
	[PrecinctId] [uniqueidentifier] NOT NULL,
	[CountyKey] [bigint] NOT NULL,
	[PrecinctDescription] [nvarchar](256) NOT NULL,
	[StatePrecinctLookup] [nvarchar](128) NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateUpdated] [datetime] NULL,
	[CreateUser] [uniqueidentifier] NULL,
	[UpdateUser] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Precinct] PRIMARY KEY CLUSTERED 
(
	[PrecinctKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_StatePrecinctLookup_CountyKey]    Script Date: 9/19/2024 3:30:33 PM ******/
CREATE NONCLUSTERED INDEX [IX_StatePrecinctLookup_CountyKey] ON [dbo].[Precinct]
(
	[StatePrecinctLookup] ASC
)
INCLUDE([CountyKey]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Precinct] ADD  CONSTRAINT [DF_Precinct_PrecinctId]  DEFAULT (newid()) FOR [PrecinctId]
GO
ALTER TABLE [dbo].[Precinct] ADD  CONSTRAINT [DF_Precinct_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
