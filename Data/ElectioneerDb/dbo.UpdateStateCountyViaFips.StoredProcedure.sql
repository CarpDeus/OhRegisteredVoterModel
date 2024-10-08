USE [Electioneer]
GO
/****** Object:  StoredProcedure [dbo].[UpdateStateCountyViaFips]    Script Date: 9/19/2024 3:30:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Josef Finsel
-- Create date: 2012-11-10
-- Description:	Add/Update a FIPS Entry
-- =============================================
CREATE PROCEDURE [dbo].[UpdateStateCountyViaFips]
	@FipsId char(6),
	@StateCode char(3),
	@StateName nvarchar(128),
	@County nvarchar(128),
	@StatusCode int OUTPUT,
	@StatusMessage nvarchar(1024) OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set @County = LTRIM(RTRIM(@County))

	IF NOT EXISTS(SELECT * FROM StateCounty WHERE (StateCode = @StateCode AND County = @County) OR FipsId = @FipsId)
	  BEGIN
	  	INSERT INTO dbo.StateCounty (StateCode, County, FipsID) VALUES(@StateCode, @County, @FipsId)
	  	SELECT @StatusCode = 0, @StatusMessage = 'Successfully Added ' + @County + ' to ' + @StateCode
	  END
	ELSE
	  IF EXISTS(SELECT * FROM StateCounty WHERE FipsId = @FipsId AND StateCode = @StateCode AND County = @County)
	    BEGIN
			SELECT @StatusCode = 1, @StatusMessage='Data already exists for '+ @County + ' in ' + @StateCode
		END
	  ELSE
	    BEGIN
			SELECT @StatusCode = 2, @StatusMessage = 'Changed State to ' + @StateCode + ' FROM ' + ISNULL(StateCode, '') 
				+ ' AND County to ' + @County + ' FROM ' + ISNULL(County, '') + ' FOR FIPS ' + @FipsId FROM
				StateCounty WHERE FipsId = @FipsId
			UPDATE StateCounty SET StateCode = @StateCode, County = @County WHERE FipsId = @FipsId
	    END
END
/*

DECLARE @StatusCode int, @StatusMessage nvarchar(1024)
DELETE FROM StateInformation WHERE StateCode in ('NIL', 'NON')
DELETE FROM StateCounty WHERE FipsID = 'AATEST'
exec UpdateStateCountyViaFips 'AATEST', 'NIL', 'TESTING!!', 'TESTING', @StatusCode OUTPUT, @StatusMessage OUTPUT
SELECT @StatusCode, @StatusMessage
exec UpdateStateCountyViaFips 'AATEST', 'NIL', 'TESTING!!', 'TESTING', @StatusCode OUTPUT, @StatusMessage OUTPUT
SELECT @StatusCode, @StatusMessage
exec UpdateStateCountyViaFips 'AATEST', 'NIL', 'TESTING!!', 'TESTINGer', @StatusCode OUTPUT, @StatusMessage OUTPUT
SELECT @StatusCode, @StatusMessage
exec UpdateStateCountyViaFips 'AATEST', 'NON', 'TESTING!!','TESTINGer', @StatusCode OUTPUT, @StatusMessage OUTPUT
SELECT @StatusCode, @StatusMessage
exec UpdateStateCountyViaFips 'AATEST', 'NIL', 'TESTING!!', 'TESTING', @StatusCode OUTPUT, @StatusMessage OUTPUT
SELECT @StatusCode, @StatusMessage
exec UpdateStateCountyViaFips 'AATEST', 'NIL', 'TESTING!!', 'TESTING', @StatusCode OUTPUT, @StatusMessage OUTPUT
SELECT @StatusCode, @StatusMessage
SELECT * FROM StateInformation
DELETE FROM StateCounty WHERE FipsID = 'AATEST'
DELETE FROM StateInformation WHERE StateCode in ('NIL', 'NON')
*/

GO
