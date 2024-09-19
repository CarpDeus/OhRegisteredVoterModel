using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PreprocessingData
{
    public class VoterSummary : List<VoterSummaryDetail> { }

    public class VoterSummaryDetail
    {
        public string VoterId {  get; set; }
        public DateOnly DateRegistered { get; set; }
        public int NumberOfElectionRecords { get; set; }
    }
}
