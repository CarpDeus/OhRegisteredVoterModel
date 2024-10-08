USE [Electioneer]
GO
/****** Object:  StoredProcedure [staging].[LoadOhioData]    Script Date: 9/19/2024 3:30:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [staging].[LoadOhioData]
@NotUpdatedSince date=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if @NotUpdatedSince is null set @NotUpdatedSince = getdate()+1

	DECLARE @FirstStagingId BIGINT = 0
		,@LastStagingId BIGINT = 0
		,@SourceStateId VARCHAR(3) = 'OH'
		,@ElectionsRecordsLoaded bigint = 0
		,@VoterHistoryRecordsLoaded bigint = 0
	create table  #TempLoadTable  (
		StagingId BIGINT NOT NULL PRIMARY KEY
		,SOS_Voter_ID VARCHAR(13)
		,VoterKey BIGINT
		,Existed BIT NOT NULL DEFAULT(0)
		,ProcessedElections BIT NULL
		)
create table #ElectionCrossReference
	(
		ElectionCrossReferenceId bigint not null primary key identity(1,1),
		ElectionName varchar(50) not null,
		ElectionDate date not null,
		ElectionType varchar(50) not null,
		ElectionTypeId bigint null,
		ElectionId bigint null
	) 

	create table #Elections (
		VoterKeyId BIGINT NOT NULL identity(1, 1) PRIMARY KEY
		,VoterKey BIGINT NOT NULL
		,ElectionId BIGINT NOT NULL
		,VoterRegisteredAs varchar(2)
		,PartyId bigint
		,Voted bit  NULL
		)

-- Process Elections
insert into #ElectionCrossReference (ElectionName, ElectionDate, ElectionType)
select distinct ElectionName, ElectionDate, ElectionType
from ElectioneerStaging.staging.OhioElections
update ec set ElectionTypeId = et.ElectionTypeId
from dbo.ElectionTypes et inner join #ElectionCrossReference ec on et.ElectionType = ec.ElectionType

update ec set ElectionId = e.ElectionId
from dbo.Elections e inner join #ElectionCrossReference ec on e.ElectionStateLookup = convert(nvarchar(128),ec.ElectionName) and e.StateCode = N'OH'

insert into Elections
select N'OH', ElectionTypeId, 2, ElectionDate, convert(nvarchar(128),ElectionName)
from #ElectionCrossReference where ElectionId is null 
update ec set ElectionId = e.ElectionId
from dbo.Elections e inner join #ElectionCrossReference ec on e.ElectionStateLookup = convert(nvarchar(128),ec.ElectionName) and e.StateCode = 'OH' and ec.ElectionId is null


	WHILE EXISTS (
			SELECT *
			FROM ElectioneerStaging.staging.OhioVoterLoad
			WHERE StagingId > @LastStagingId
			)
	BEGIN
		DELETE
		FROM #TempLoadTable

		SET @LastStagingId = @FirstStagingId + 10000

		INSERT INTO #TempLoadTable (
			StagingID
			,SOS_Voter_ID
			)
		SELECT StagingID
			,SOS_Voter_ID
		FROM ElectioneerStaging.staging.OhioVoterLoad
		WHERE StagingId BETWEEN @FirstStagingId
				AND @LastStagingId

		--	select * from #TempLoadTable
		UPDATE d
		SET VoterKey = v.VoterKey
			,Existed = 1
		FROM #TempLoadTable d
		INNER JOIN dbo.Voter v ON v.SourceState = @SourceStateId
			AND v.SourceStateId = convert(nvarchar(128),d.SOS_Voter_ID)

		-- Update existing data 
		UPDATE v
		SET BirthDate = o.Date_Of_Birth
			,StateRegistrationDate = o.Registration_Date
			,VoterActiveOnRoles = CASE 
				WHEN o.Voter_Status = 'Active'
					THEN 1
				ELSE 0
				END
			,FirstName = o.First_Name
			,LastName = o.Last_Name
			,[Residential_Address1] = o.Residential_Address1
			,[Residential_Address_2_] = o.Residential_Address_2_
			,[Residential_City] = o.Residential_City
			,[Residential_State] = o.Residential_State
			,[Residential_Zip] = o.Residential_Zip
			,[Residential_Zip_Plus_4] = o.Residential_Zip_Plus_4
			,[Residential_Postal_Code] = o.Residential_Postal_Code
			,[Mailing_Address1] = o.Mailing_Address1
			,[Mailing_Address_2_] = o.Mailing_Address_2_
			,[Mailing_City] = o.Mailing_City
			,[Mailing_State] = o.Mailing_State
			,[Mailing_Zip] = o.Mailing_Zip
			,[Mailing_Zip_Plus_4] = o.Mailing_Zip_Plus_4
			,[Mailing_Postal_Code] = o.Mailing_Postal_Code
			,[CountyKey] = p.CountyKey
			,[PrecinctKey] = p.PrecinctKey
			,[VoterInformationLastUpdated] = getdate()
		--[VoterActiveFlipped], [LastElectionVotedIn]
		FROM Voter v
		INNER JOIN #TempLoadTable d ON v.VoterKey = d.VoterKey
		INNER JOIN ElectioneerStaging.staging.OhioVoterLoad o ON d.StagingId = o.StagingId
		INNER JOIN Precinct p ON o.Precinct_Code_ = p.StatePrecinctLookup

		-- Add missing
		INSERT INTO Voter (
			[VoterId]
			,[SourceState]
			,[SourceStateId]
			,[BirthDate]
			,[StateRegistrationDate]
			,[VoterActiveOnRoles]
			,[FirstName]
			,[LastName]
			,[Residential_Address1]
			,[Residential_Address_2_]
			,[Residential_City]
			,[Residential_State]
			,[Residential_Zip]
			,[Residential_Zip_Plus_4]
			,[Residential_Postal_Code]
			,[Mailing_Address1]
			,[Mailing_Address_2_]
			,[Mailing_City]
			,[Mailing_State]
			,[Mailing_Zip]
			,[Mailing_Zip_Plus_4]
			,[Mailing_Postal_Code]
			,[CountyKey]
			,[PrecinctKey]
			,[PrimaryPhoneNumber]
			,[SecondaryPhoneNumber]
			,[PrimaryEmailAddress]
			,[SecondaryEmailAddress]
			,[VoterInformationLastUpdated]
			,[VoterActiveFlipped]
			,[LastElectionVotedIn]
			,[VoterInformationAdded]
			)
		SELECT newid()
			,@SourceStateId
			,o.SOS_Voter_Id
			,o.Date_Of_Birth
			,o.Registration_Date
			,CASE 
				WHEN o.Voter_Status = 'Active'
					THEN 1
				ELSE 0
				END
			,o.First_Name
			,o.Last_Name
			,o.[Residential_Address1]
			,o.[Residential_Address_2_]
			,o.[Residential_City]
			,o.[Residential_State]
			,o.[Residential_Zip]
			,o.[Residential_Zip_Plus_4]
			,o.[Residential_Postal_Code]
			,o.[Mailing_Address1]
			,o.[Mailing_Address_2_]
			,o.[Mailing_City]
			,o.[Mailing_State]
			,o.[Mailing_Zip]
			,o.[Mailing_Zip_Plus_4]
			,o.[Mailing_Postal_Code]
			,
			--		o.Precinct,
			p.[CountyKey]
			,p.[PrecinctKey]
			,NULL
			,NULL
			,NULL
			,NULL
			,getdate()
			,1
			,NULL
			,getdate()
		FROM #TempLoadTable d
		INNER JOIN ElectioneerStaging.staging.OhioVoterLoad o ON d.StagingId = o.StagingId and d.VoterKey is null
		INNER JOIN Precinct p ON o.Precinct_Code_ = p.StatePrecinctLookup

		-- Update Ids
		UPDATE d
		SET VoterKey = v.VoterKey
			,Existed = 0
		FROM #TempLoadTable d
		INNER JOIN dbo.Voter v ON v.SourceState = @SourceStateId
			AND v.SourceStateId = d.SOS_Voter_ID and d.VoterKey is null 

		SET @FirstStagingId = @LastStagingId 


		WHILE EXISTS (
				SELECT *
				FROM #TempLoadTable
				WHERE ProcessedElections IS NULL
					AND VoterKey IS NOT NULL
				)
		BEGIN
			UPDATE TOP (500) #TempLoadTable
			SET ProcessedElections = 0
			WHERE ProcessedElections IS NULL
				AND VoterKey IS NOT NULL
			--print @@rowcount

			-- Load Data into temp table
			insert into #Elections(VoterKey, ElectionId,VoterRegisteredAs)
			select a.VoterKey, ecr.ElectionId, a.VoterRegisteredAs from (
			SELECT t.VoterKey, oer.[SOS_Voter_Id], oer.VoterRegisteredAs, oer.ElectionName 
			from ElectioneerStaging.staging.OhioVoterElectionRecord  oer inner join #TempLoadTable t on oer.[SOS_Voter_Id] = t.SOS_Voter_ID 
			and ProcessedElections =0) a
			inner join #ElectionCrossReference ecr on a.ElectionName = ecr.ElectionName
			
			update e set PartyId = opl.MainPartyId
			from 
			#Elections e inner join ElectioneerStaging.staging.OhioPartyLookup opl on e.VoterRegisteredAs = opl.OhioLookupCode

			insert into [dbo].[VoterElectionHistory]
			select e.VoterKey, e.ElectionId, e.PartyId, case when e.PartyId is not null then 1 else 0 end Voted from #Elections e left join [dbo].[VoterElectionHistory] veh on 
			e.VoterKey = veh.voterkey and e.ElectionId = veh.electionId
			where veh.voterkey is null
			--set @VoterHistoryRecordsLoaded = @VoterHistoryRecordsLoaded+ @@rowcount
			--print 'Processed ' + format(#ElectionsRecordsLoaded, 'N0') + ' AND Loaded '+ format(@VoterHistoryRecordsLoaded, 'N0') 

			UPDATE #TempLoadTable
			SET ProcessedElections = 1
			WHERE ProcessedElections = 0
			truncate table #Elections
		--	BREAK;
		END

		-- process elections
		truncate table  #TempLoadTable

		

		--select * from #Elections
		PRINT 'FirstStagingId='+format( @FirstStagingId,'N0') + ' and LastStagingId='+format( @LastStagingId,'N0') 

		--BREAK;
	END
END
GO
