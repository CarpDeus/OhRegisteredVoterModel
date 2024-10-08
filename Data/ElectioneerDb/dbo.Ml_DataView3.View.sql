USE [Electioneer]
GO
/****** Object:  View [dbo].[Ml_DataView3]    Script Date: 9/19/2024 3:30:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Ml_DataView3]
AS
SELECT     v.SourceState, DATEDIFF(Month, v.StateRegistrationDate, eg.ElectionDate) / 12.0 AS TimeRegisteredGeneralElection, vehg.Voted GeneralElectionVoted, 
CASE WHEN ltrim(isnull(GenParties.PartyName, '')) 
                         = '' THEN 'Voted without declaring party affiliation' ELSE GenParties.PartyName END AS PartyAffiliationDuringGeneralElection, 
						 vehg.GeoId20  GeneralElectionGeoId20, 
						 DATEDIFF(Month, v.StateRegistrationDate, 
                         ep.ElectionDate) / 12.0 AS TimeRegisteredPrimaryElection, 
						 v.Residential_Zip, CASE WHEN year(eg.ElectionDate) % 4 = 0 THEN 'Presidential' WHEN year(eg.ElectionDate) 
                         % 2 = 0 THEN 'Congressional' ELSE 'Off-Year' END AS NationalElectionType
FROM            dbo.OutputOhVoters AS oov INNER JOIN
                         dbo.Voter AS v ON oov.VoterKey = v.VoterKey INNER JOIN
                         dbo.StateCounty AS sc ON sc.CountyKey = v.CountyKey INNER JOIN
                         dbo.Precinct ON v.PrecinctKey = dbo.Precinct.PrecinctKey INNER JOIN
						 dbo.VoterElectionHistory AS vehG on vehg.VoterKey = oov.VoterKey
						 INNER JOIN dbo.Elections AS eg ON eg.ElectionTypeId = 2 AND MONTH(eg.ElectionDate) = 11 AND DAY(eg.ElectionDate) BETWEEN 2 AND 8 and vehg.ElectionId = eg.ElectionId
						 inner join  dbo.VoterElectionHistory AS vehP on vehP.VoterKey = oov.VoterKey
						 INNER JOIN dbo.Elections AS ep ON ep.ElectionTypeId = 1 AND MONTH(ep.ElectionDate) between 4 and 6 and vehP.ElectionId = ep.ElectionId
LEFT OUTER JOIN dbo.Parties AS GenParties ON Vehg.PartyAffiliation = GenParties.PartyId LEFT OUTER JOIN
                         dbo.Parties AS PrimParties ON vehP.PartyAffiliation = PrimParties.PartyId
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
         Begin Table = "oov"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 349
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "v"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 284
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sc"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Precinct"
            Begin Extent = 
               Top = 600
               Left = 38
               Bottom = 730
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GenElect"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 496
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PrimElect"
            Begin Extent = 
               Top = 6
               Left = 534
               Bottom = 136
               Right = 743
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GenParties"
            Begin Extent = 
               Top = 384
               Left = 273
               Bottom = 497
               Right = 449
            End
            DisplayFlags = 280
          ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Ml_DataView3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  TopColumn = 0
         End
         Begin Table = "PrimParties"
            Begin Extent = 
               Top = 6
               Left = 781
               Bottom = 119
               Right = 957
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Ml_DataView3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Ml_DataView3'
GO
