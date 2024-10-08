USE [Electioneer]
GO
/****** Object:  View [dbo].[Ml_DataView5]    Script Date: 9/19/2024 3:30:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Ml_DataView5]
AS
SELECT        d.SourceState, d.TimeRegisteredGeneralElection, d.GeneralElectionGeoId20, d.TimeRegisteredPrimaryElection, d.Residential_Zip, 
CASE WHEN d.ElectionYear % 4 = 0 THEN 'Presidential' 
WHEN d.ElectionYear 
                         % 2 = 0 THEN 'Congressional' ELSE 'Off-Year' END AS NationalElectionType, CASE WHEN ltrim(isnull(GenParties.PartyName, '')) 
                         = '' THEN 'Voted without declaring party affiliation' ELSE GenParties.PartyName END AS GeneralPartyAffiliation, CASE WHEN ltrim(isnull(PrimParties.PartyName, '')) 
                         = '' THEN 'Voted without declaring party affiliation' ELSE PrimParties.PartyName END AS PrimaryPartyAffiliation, 
						 d .GeneralElectionVoted , 
                         d .PrimaryElectionVoted, d.BirthYear, d.ElectionYear
FROM            dbo.Ml_Data4 AS d LEFT OUTER JOIN
                         dbo.Parties AS GenParties ON d.PartyAffiliationDuringGeneralElection = GenParties.PartyId LEFT OUTER JOIN
                         dbo.Parties AS PrimParties ON d.PartyAffiliationDuringPrimaryElection = PrimParties.PartyId
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "d"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 270
               Right = 325
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GenParties"
            Begin Extent = 
               Top = 6
               Left = 363
               Bottom = 119
               Right = 539
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PrimParties"
            Begin Extent = 
               Top = 197
               Left = 701
               Bottom = 310
               Right = 877
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Ml_DataView5'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Ml_DataView5'
GO
