USE [Electioneer]
GO
/****** Object:  Table [dbo].[StateInformation]    Script Date: 9/19/2024 3:30:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StateInformation](
	[StateCode] [char](3) NOT NULL,
	[StateName] [nvarchar](128) NOT NULL,
	[ElectoralVotes] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StateInformation] ADD  CONSTRAINT [DF_StateInformation_ElectoralVotes]  DEFAULT ((0)) FOR [ElectoralVotes]
GO
