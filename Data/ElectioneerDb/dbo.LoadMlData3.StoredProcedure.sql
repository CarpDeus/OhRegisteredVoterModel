USE [Electioneer]
GO
/****** Object:  StoredProcedure [dbo].[LoadMlData3]    Script Date: 9/19/2024 3:30:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Josef Finsel
-- Create date: 2024-09-18
-- Description:	Load ML View with data for modeling
-- =============================================
CREATE PROCEDURE [dbo].[LoadMlData3]
AS
BEGIN
	SET NOCOUNT ON;
	truncate table Ml_Data3
	declare @VoterKey bigint=0
	select ElectionId, ElectionDate
	into #PrimaryElections from dbo.Elections where ElectionTypeId = 1 AND MONTH(ElectionDate) between 4 and 6
	select ElectionId, ElectionDate
	into #GeneralElections from dbo.Elections where ElectionTypeId = 2 AND MONTH(ElectionDate) = 11 AND DAY(ElectionDate) BETWEEN 2 AND 8

	while exists(select * from OutputOhVoters where VoterKey > @VoterKey)
	begin
		select top 1 @VoterKey = VoterKey from OutputOhVoters where VoterKey > @VoterKey order by VoterKey
		
INSERT INTO [dbo].[Ml_Data3]
           ([SourceState]
           ,[TimeRegisteredGeneralElection]
           ,[GeneralElectionVoted]
           ,[PartyAffiliationDuringGeneralElection]
           ,[GeneralElectionGeoId20]
           ,[TimeRegisteredPrimaryElection]
           ,[Residential_Zip]
           ,[NationalElectionType]
		   ,RegistrationYear
		   ,ElectionYear)
SELECT     v.SourceState, DATEDIFF(Month, v.StateRegistrationDate, eg.ElectionDate) / 12.0 AS TimeRegisteredGeneralElection, vehg.Voted GeneralElectionVoted, 
CASE WHEN ltrim(isnull(GenParties.PartyName, '')) 
                         = '' THEN 'Voted without declaring party affiliation' ELSE GenParties.PartyName END AS PartyAffiliationDuringGeneralElection, 
						 vehg.GeoId20  GeneralElectionGeoId20, 
						 DATEDIFF(Month, v.StateRegistrationDate, 
                         ep.ElectionDate) / 12.0 AS TimeRegisteredPrimaryElection, 
						 v.Residential_Zip, CASE WHEN year(eg.ElectionDate) % 4 = 0 THEN 'Presidential' WHEN year(eg.ElectionDate) 
                         % 2 = 0 THEN 'Congressional' ELSE 'Off-Year' END AS NationalElectionType
						 ,year(v.StateRegistrationDate), year(eg.ElectionDate)
FROM                     (select * from dbo.Voter Where VoterKey = @VoterKey) AS v 
					INNER JOIN
                         dbo.StateCounty AS sc ON sc.CountyKey = v.CountyKey INNER JOIN
                         dbo.Precinct ON v.PrecinctKey = dbo.Precinct.PrecinctKey INNER JOIN
						 dbo.VoterElectionHistory AS vehG on vehg.VoterKey = v.VoterKey
						 INNER JOIN #GeneralElections AS eg ON eg.ElectionId = vehg.ElectionId
						 inner join  dbo.VoterElectionHistory AS vehP on vehP.VoterKey = v.VoterKey 
						 INNER JOIN  #PrimaryElections ep on vehp.ElectionId = ep.ElectionId and year(ep.ElectionDate) = year(eg.ElectionDate)
LEFT OUTER JOIN dbo.Parties AS GenParties ON Vehg.PartyAffiliation = GenParties.PartyId LEFT OUTER JOIN
                         dbo.Parties AS PrimParties ON vehP.PartyAffiliation = PrimParties.PartyId
						 where eg.ElectionDate > v.StateRegistrationDate
						 
--	break;
print @VoterKey
/*if exists(select * from (select top 500 * from  Ml_Data3 order by dataid desc) x where timeregisteredgeneralelection<0)
break;*/
	end 
END
GO
