USE [Electioneer]
GO
/****** Object:  Table [dbo].[VoterElectionHistory]    Script Date: 9/19/2024 3:30:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VoterElectionHistory](
	[VoterElectionHistoryId] [bigint] IDENTITY(1,1) NOT NULL,
	[VoterKey] [bigint] NOT NULL,
	[ElectionId] [bigint] NOT NULL,
	[PartyAffiliation] [bigint] NULL,
	[Voted] [bit] NOT NULL,
	[GeoId20] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[VoterElectionHistoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_VoterElectionHistory_GeoId20_VoterKey]    Script Date: 9/19/2024 3:30:33 PM ******/
CREATE NONCLUSTERED INDEX [IX_VoterElectionHistory_GeoId20_VoterKey] ON [dbo].[VoterElectionHistory]
(
	[GeoId20] ASC
)
INCLUDE([VoterKey]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_VoterElectionHistory_VoterKey_ElectionId]    Script Date: 9/19/2024 3:30:33 PM ******/
CREATE NONCLUSTERED INDEX [IX_VoterElectionHistory_VoterKey_ElectionId] ON [dbo].[VoterElectionHistory]
(
	[VoterKey] ASC,
	[ElectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VoterElectionHistory] ADD  DEFAULT ((0)) FOR [Voted]
GO
