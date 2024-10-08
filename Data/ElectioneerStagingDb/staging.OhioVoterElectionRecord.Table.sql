USE [ElectioneerStaging]
GO
/****** Object:  Table [staging].[OhioVoterElectionRecord]    Script Date: 9/19/2024 3:36:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[OhioVoterElectionRecord](
	[ElectionRecordId] [bigint] IDENTITY(1,1) NOT NULL,
	[SOS_Voter_Id] [varchar](13) NOT NULL,
	[ElectionName] [varchar](50) NULL,
	[VoterRegisteredAs] [varchar](2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ElectionRecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_OhioVoterElectionRecord_SOS_Voter_ID]    Script Date: 9/19/2024 3:36:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_OhioVoterElectionRecord_SOS_Voter_ID] ON [staging].[OhioVoterElectionRecord]
(
	[SOS_Voter_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_OhioVoterElectionRecord_SOS_Voter_ID_Data]    Script Date: 9/19/2024 3:36:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_OhioVoterElectionRecord_SOS_Voter_ID_Data] ON [staging].[OhioVoterElectionRecord]
(
	[SOS_Voter_Id] ASC
)
INCLUDE([ElectionName],[VoterRegisteredAs]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
