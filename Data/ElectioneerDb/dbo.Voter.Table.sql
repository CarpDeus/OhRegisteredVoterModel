USE [Electioneer]
GO
/****** Object:  Table [dbo].[Voter]    Script Date: 9/19/2024 3:30:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Voter](
	[VoterKey] [bigint] IDENTITY(1,1) NOT NULL,
	[VoterId] [uniqueidentifier] NOT NULL,
	[SourceState] [varchar](3) NULL,
	[SourceStateId] [nvarchar](128) NULL,
	[BirthDate] [date] NULL,
	[StateRegistrationDate] [date] NULL,
	[VoterActiveOnRoles] [bit] NULL,
	[FirstName] [nvarchar](128) NULL,
	[LastName] [nvarchar](128) NULL,
	[Residential_Address1] [varchar](100) NULL,
	[Residential_Address_2_] [varchar](100) NULL,
	[Residential_City] [varchar](50) NULL,
	[Residential_State] [varchar](20) NULL,
	[Residential_Zip] [varchar](5) NULL,
	[Residential_Zip_Plus_4] [varchar](4) NULL,
	[Residential_Postal_Code] [varchar](10) NULL,
	[Mailing_Address1] [varchar](100) NULL,
	[Mailing_Address_2_] [varchar](100) NULL,
	[Mailing_City] [varchar](50) NULL,
	[Mailing_State] [varchar](20) NULL,
	[Mailing_Zip] [varchar](5) NULL,
	[Mailing_Zip_Plus_4] [varchar](4) NULL,
	[Mailing_Postal_Code] [varchar](10) NULL,
	[CountyKey] [bigint] NOT NULL,
	[PrecinctKey] [bigint] NOT NULL,
	[PrimaryPhoneNumber] [nvarchar](20) NULL,
	[SecondaryPhoneNumber] [nvarchar](20) NULL,
	[PrimaryEmailAddress] [nvarchar](128) NULL,
	[SecondaryEmailAddress] [nvarchar](128) NULL,
	[VoterInformationLastUpdated] [datetime] NULL,
	[VoterActiveFlipped] [bit] NOT NULL,
	[LastElectionVotedIn] [date] NULL,
	[VoterInformationAdded] [date] NOT NULL,
	[FirstElectionVotedIn] [date] NULL,
 CONSTRAINT [PK__Voter__1F6988F7CFA6328C] PRIMARY KEY CLUSTERED 
(
	[VoterKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Voter_SourceState_StateId]    Script Date: 9/19/2024 3:30:33 PM ******/
CREATE NONCLUSTERED INDEX [IX_Voter_SourceState_StateId] ON [dbo].[Voter]
(
	[SourceState] ASC,
	[SourceStateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Voter] ADD  CONSTRAINT [DF_Voter_VoterId]  DEFAULT (newid()) FOR [VoterId]
GO
ALTER TABLE [dbo].[Voter] ADD  CONSTRAINT [DF__Voter__VoterActi__3631FF56]  DEFAULT ((0)) FOR [VoterActiveFlipped]
GO
