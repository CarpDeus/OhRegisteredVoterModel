USE [ElectioneerStaging]
GO
/****** Object:  Table [staging].[OhioVoterElectionCount]    Script Date: 9/19/2024 3:36:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[OhioVoterElectionCount](
	[ElectionCountID] [bigint] IDENTITY(1,1) NOT NULL,
	[SOS_Voter_Id] [varchar](13) NOT NULL,
	[Registration_Date] [date] NOT NULL,
	[NumberOfElectionRecords] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ElectionCountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_OhioVoterElectionCount_SOS_Voter_ID]    Script Date: 9/19/2024 3:36:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_OhioVoterElectionCount_SOS_Voter_ID] ON [staging].[OhioVoterElectionCount]
(
	[SOS_Voter_Id] ASC
)
INCLUDE([Registration_Date],[NumberOfElectionRecords]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
