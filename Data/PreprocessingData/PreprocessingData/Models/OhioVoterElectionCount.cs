﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace PreprocessingData.Models;

public partial class OhioVoterElectionCount
{
    public long ElectionCountID { get; set; }

    public string SOS_Voter_Id { get; set; }

    public DateOnly Registration_Date { get; set; }

    public int NumberOfElectionRecords { get; set; }
}