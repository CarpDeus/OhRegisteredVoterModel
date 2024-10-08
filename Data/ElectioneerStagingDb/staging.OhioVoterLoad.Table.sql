USE [ElectioneerStaging]
GO
/****** Object:  Table [staging].[OhioVoterLoad]    Script Date: 9/19/2024 3:36:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[OhioVoterLoad](
	[StagingID] [bigint] IDENTITY(1,1) NOT NULL,
	[SOS_Voter_Id] [varchar](13) NOT NULL,
	[County_Number] [varchar](2) NULL,
	[County_Id] [varchar](50) NULL,
	[Last_Name] [varchar](50) NULL,
	[First_Name] [varchar](50) NULL,
	[Middle_Name] [varchar](50) NULL,
	[Suffix] [varchar](10) NULL,
	[Date_Of_Birth] [varchar](10) NULL,
	[Registration_Date] [varchar](10) NULL,
	[Voter_Status] [varchar](25) NULL,
	[Party_Affiliation] [varchar](1) NULL,
	[Residential_Address1] [varchar](100) NULL,
	[Residential_Address_2_] [varchar](100) NULL,
	[Residential_City] [varchar](50) NULL,
	[Residential_State] [varchar](20) NULL,
	[Residential_Zip] [varchar](5) NULL,
	[Residential_Zip_Plus_4] [varchar](4) NULL,
	[Residential_Country] [varchar](50) NULL,
	[Residential_Postal_Code] [varchar](10) NULL,
	[Mailing_Address1] [varchar](100) NULL,
	[Mailing_Address_2_] [varchar](100) NULL,
	[Mailing_City] [varchar](50) NULL,
	[Mailing_State] [varchar](20) NULL,
	[Mailing_Zip] [varchar](5) NULL,
	[Mailing_Zip_Plus_4] [varchar](4) NULL,
	[Mailing_Country] [varchar](50) NULL,
	[Mailing_Postal_Code] [varchar](10) NULL,
	[Career_Center] [varchar](80) NULL,
	[City] [varchar](80) NULL,
	[City_School_District] [varchar](80) NULL,
	[County_Court__District] [varchar](80) NULL,
	[Congressional_District] [varchar](2) NULL,
	[Court_of_Appeals] [varchar](2) NULL,
	[Education_Service_Center] [varchar](80) NULL,
	[Exempted_Village_School_District] [varchar](80) NULL,
	[Library_District] [varchar](80) NULL,
	[Local_School_District] [varchar](80) NULL,
	[Municipal_Court_District] [varchar](80) NULL,
	[Precinct] [varchar](80) NULL,
	[Precinct_Code_] [varchar](20) NULL,
	[State_Board_of_Education] [varchar](2) NULL,
	[State_Representative_District_] [varchar](2) NULL,
	[State_Senate_District] [varchar](2) NULL,
	[Township] [varchar](100) NULL,
	[Village] [varchar](100) NULL,
	[Ward] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[StagingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
