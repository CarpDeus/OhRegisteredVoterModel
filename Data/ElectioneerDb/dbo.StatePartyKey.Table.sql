USE [Electioneer]
GO
/****** Object:  Table [dbo].[StatePartyKey]    Script Date: 9/19/2024 3:30:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatePartyKey](
	[StateCode] [char](3) NULL,
	[PartyId] [bigint] NULL,
	[StateIdentifier] [nvarchar](128) NULL
) ON [PRIMARY]
GO
