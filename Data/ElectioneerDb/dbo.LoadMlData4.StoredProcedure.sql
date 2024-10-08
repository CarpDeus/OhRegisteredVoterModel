USE [Electioneer]
GO
/****** Object:  StoredProcedure [dbo].[LoadMlData4]    Script Date: 9/19/2024 3:30:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Josef Finsel
-- Create date: 2024-09-18
-- Description:	Load ML View with data for modeling
-- =============================================
CREATE PROCEDURE [dbo].[LoadMlData4]
AS
BEGIN
	SET NOCOUNT ON;
	truncate table Ml_Data4
	declare @VoterKey bigint=0
	select e.ElectionId, e.ElectionDate
	into #PrimaryElections from elections e inner join 
	(select year(electiondate) Year, min(ElectionId) ELectionId from dbo.Elections where ElectionTypeId = 1 group by year(electionDate)) x on e.electionid = x.electionid

	select ElectionId, ElectionDate
	into #GeneralElections from dbo.Elections where ElectionTypeId = 2 AND MONTH(ElectionDate) = 11 AND DAY(ElectionDate) BETWEEN 2 AND 8

	while exists(select * from OutputOhVoters where VoterKey > @VoterKey)
	begin
		select top 1 @VoterKey = VoterKey from OutputOhVoters where VoterKey > @VoterKey order by VoterKey

INSERT INTO [dbo].[Ml_Data4]
           ([SourceState]
           ,[TimeRegisteredGeneralElection]
           ,[GeneralElectionVoted]
           ,[PrimaryElectionVoted]
           ,[PartyAffiliationDuringGeneralElection]
           ,[PartyAffiliationDuringPrimaryElection]
           ,[GeneralElectionGeoId20]
           ,[TimeRegisteredPrimaryElection]
           ,[Residential_Zip]
           ,[ElectionYear],
		   BirthYear)
SELECT     v.SourceState, DATEDIFF(Month, v.StateRegistrationDate, eg.ElectionDate) / 12.0 AS TimeRegisteredGeneralElection, vehg.Voted GeneralElectionVoted, 
	vehp.Voted PrimaryElectionVoted,Vehg.PartyAffiliation,Vehp.PartyAffiliation,
						 vehg.GeoId20  GeneralElectionGeoId20, 
						 DATEDIFF(Month, v.StateRegistrationDate, 
                         ep.ElectionDate) / 12.0 AS TimeRegisteredPrimaryElection, 
						 v.Residential_Zip,  year(eg.ElectionDate), year(v.BirthDate)
FROM                      (select * from dbo.Voter Where VoterKey = @VoterKey) AS v 
--(select v1.* from dbo.Voter v1 inner join OutputOhVoters oov on v1.VoterKey=oov.VoterKey) AS v 
					INNER JOIN
                         dbo.StateCounty AS sc ON sc.CountyKey = v.CountyKey INNER JOIN
                         dbo.Precinct ON v.PrecinctKey = dbo.Precinct.PrecinctKey INNER JOIN
						 dbo.VoterElectionHistory AS vehG on vehg.VoterKey = v.VoterKey
						 INNER JOIN #GeneralElections AS eg ON eg.ElectionId = vehg.ElectionId
						 inner join  dbo.VoterElectionHistory AS vehP on vehP.VoterKey = v.VoterKey 
						 INNER JOIN  #PrimaryElections ep on vehp.ElectionId = ep.ElectionId and year(ep.ElectionDate) = year(eg.ElectionDate)
						 where eg.ElectionDate > v.StateRegistrationDate
						 
--	break;
--print @VoterKey
/*if exists(select * from (select top 500 * from  Ml_Data3 order by dataid desc) x where timeregisteredgeneralelection<0)
break;*/
	end 
END
GO
