USE [Electioneer]
GO
/****** Object:  Table [dbo].[Ml_Data3]    Script Date: 9/19/2024 3:30:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ml_Data3](
	[SourceState] [varchar](3) NULL,
	[TimeRegisteredGeneralElection] [numeric](17, 6) NULL,
	[GeneralElectionVoted] [bit] NOT NULL,
	[PartyAffiliationDuringGeneralElection] [varchar](128) NULL,
	[GeneralElectionGeoId20] [varchar](20) NULL,
	[TimeRegisteredPrimaryElection] [numeric](17, 6) NULL,
	[Residential_Zip] [varchar](5) NULL,
	[NationalElectionType] [varchar](13) NOT NULL,
	[DataId] [bigint] IDENTITY(1,1) NOT NULL,
	[RegistrationYear] [int] NULL,
	[ElectionYear] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DataId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
