USE [Electioneer]
GO
/****** Object:  User [ElectionData]    Script Date: 9/19/2024 3:30:33 PM ******/
CREATE USER [ElectionData] FOR LOGIN [ElectionData] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [ElectionData]
GO
