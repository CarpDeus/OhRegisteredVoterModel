USE [Electioneer]
GO
/****** Object:  View [dbo].[Ml_DataView2]    Script Date: 9/19/2024 3:30:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Ml_DataView2]
AS
SELECT v.SourceState
	--,v.SourceStateId
	--,v.BirthDate
	,DATEDIFF(Month, v.BirthDate, GetDate()) / 12.0 AS CurrentAge
	,v.Residential_Zip
	,et.ElectionType
	,el.ElectionLevel
	,case when year(e.electionDate)%4 = 0 then 'Presidential' when year(e.electionDate)%2 = 0 then 'Congressional' else 'Off-Year' end NationalElectionType
--	,e.ElectionDate
--	,DATEDIFF(Month, v.BirthDate, e.ElectionDate) / 12.0 AS AgeAtTimeOfElection
	,case when ltrim(isnull(p.PartyName,'')) ='' then 'Voted without declaring party affiliation' else p.PartyName end  PartyAffiliationDuringElection
	,convert(int,veh.Voted) Voted
	--,DATEDIFF(Month, v.BirthDate, v.StateRegistrationDate) / 12.0 AS AgeAtTimeOfRegistration
	--,DATEDIFF(Month, v.StateRegistrationDate, v.FirstElectionVotedIn) / 12.0 AS TimeRegisteredPriorToFirstVoting

FROM dbo.StateCounty AS sc
INNER JOIN dbo.VoterElectionHistory AS veh
INNER JOIN dbo.Voter AS v ON veh.VoterKey = v.VoterKey
INNER JOIN dbo.OutputOhVoters oov ON oov.VoterKey = v.voterkey
INNER JOIN dbo.ElectionLevels AS el
INNER JOIN dbo.Elections AS e ON el.ElectionLevelId = e.ElectionLevelId
INNER JOIN dbo.ElectionTypes AS et ON e.ElectionTypeId = et.ElectionTypeId 
ON veh.ElectionId = e.ElectionId 
ON sc.CountyKey = v.CountyKey 
INNER JOIN dbo.Precinct ON v.PrecinctKey = dbo.Precinct.PrecinctKey 
LEFT OUTER JOIN dbo.Parties AS p ON veh.PartyAffiliation = p.PartyId 
GO
