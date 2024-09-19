using Microsoft.VisualBasic.FileIO;
using System.Text;

namespace PreprocessingData
{
    public class LineProcessor
    {
        public string VoterData { get; set; }
        public Dictionary<string, string> VoterHistoricalData { get; set; }
        public Dictionary<string, string> ErrorLog { get; set; }
        public string VoterId { get; set; }
        public DateOnly RegistrationDate { get; set; }

        public LineProcessor()
        {
            VoterData = string.Empty;
            VoterHistoricalData = new Dictionary<string, string>();
            ErrorLog = new Dictionary<string, string>();
            VoterId = string.Empty;
        }

        public LineProcessor(string voterInputData, string[] VoterColumns, string[] HeaderColumns, ElectionData electionData)
        {
            VoterData = string.Empty;
            StringBuilder sbVoterData = new StringBuilder();
            VoterHistoricalData = new Dictionary<string, string>();
            ErrorLog = new Dictionary<string, string>();
            TextFieldParser parser = new TextFieldParser(new StringReader(voterInputData))
            {
                HasFieldsEnclosedInQuotes = true
            };
            parser.SetDelimiters(",");
            string[] parsedData = parser.ReadFields();
            DateOnly birthDate;

            if (!DateOnly.TryParse(parsedData[7].Replace("\"", ""), out birthDate))
            {
                // TODO: Log Error
                ErrorLog["Birthdate incorrectly formatted"] = parsedData[7];
            }
            if (!DateOnly.TryParse(parsedData[8].Replace("\"", ""), out DateOnly registrationDate))
            {
                // TODO: Log Error
                ErrorLog["Registration Date incorrectly formatted"] = parsedData[8];
            }
            else RegistrationDate = registrationDate;

            for (int i = 0; i < VoterColumns.Length; i++)
            {
                sbVoterData.Append(parsedData[i]).Append('|');
            }
            VoterData = sbVoterData.ToString();
            VoterId = parsedData[0];

            var electionDataDict = electionData.ToDictionary(x => x.ElectionName, x => x.ElectionDate);
            for (int iElectionData = VoterColumns.Length; iElectionData < HeaderColumns.Length; iElectionData++)
            {
                string headerColumn = HeaderColumns[iElectionData].Replace("\"", "");
                if (electionDataDict.TryGetValue(headerColumn, out DateOnly electionDate) && (registrationDate < electionDate || parsedData[iElectionData].Length < 2))
                {
                    VoterHistoricalData[headerColumn] = parsedData[iElectionData];
                }
            }
        }
    }
}