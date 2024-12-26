using Microsoft.VisualBasic.FileIO;
using System.Text;

namespace PreprocessingData
{
    public class VoterDataDetails {
        public long StagingID { get; set; }

        public string SOS_Voter_Id { get; set; }

        public string County_Number { get; set; }

        public string County_Id { get; set; }

        public string Last_Name { get; set; }

        public string First_Name { get; set; }

        public string Middle_Name { get; set; }

        public string Suffix { get; set; }

        public string Date_Of_Birth { get; set; }

        public string Registration_Date { get; set; }

        public string Voter_Status { get; set; }

        public string Party_Affiliation { get; set; }

        public string Residential_Address1 { get; set; }

        public string Residential_Address_2_ { get; set; }

        public string Residential_City { get; set; }

        public string Residential_State { get; set; }

        public string Residential_Zip { get; set; }

        public string Residential_Zip_Plus_4 { get; set; }

        public string Residential_Country { get; set; }

        public string Residential_Postal_Code { get; set; }

        public string Mailing_Address1 { get; set; }

        public string Mailing_Address_2_ { get; set; }

        public string Mailing_City { get; set; }

        public string Mailing_State { get; set; }

        public string Mailing_Zip { get; set; }

        public string Mailing_Zip_Plus_4 { get; set; }

        public string Mailing_Country { get; set; }

        public string Mailing_Postal_Code { get; set; }

        public string Career_Center { get; set; }

        public string City { get; set; }

        public string City_School_District { get; set; }

        public string County_Court__District { get; set; }

        public string Congressional_District { get; set; }

        public string Court_of_Appeals { get; set; }

        public string Education_Service_Center { get; set; }

        public string Exempted_Village_School_District { get; set; }

        public string Library_District { get; set; }

        public string Local_School_District { get; set; }

        public string Municipal_Court_District { get; set; }

        public string Precinct { get; set; }

        public string Precinct_Code_ { get; set; }

        public string State_Board_of_Education { get; set; }

        public string State_Representative_District_ { get; set; }

        public string State_Senate_District { get; set; }

        public string Township { get; set; }

        public string Village { get; set; }

        public string Ward { get; set; }
    }

    public class LineProcessor
    {
        public string VoterData { get; set; }
        public VoterDataDetails DataDetails { get; set; }
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
                if(i!=0) sbVoterData.Append("|");
                sbVoterData.Append(parsedData[i]);
            }
            DataDetails = new VoterDataDetails
            {
                SOS_Voter_Id = parsedData[0],
                County_Number = parsedData[1],
                County_Id = parsedData[2],
                Last_Name = parsedData[3],
                First_Name = parsedData[4],
                Middle_Name = parsedData[5],
                Suffix = parsedData[6],
                Date_Of_Birth = parsedData[7],
                Registration_Date = parsedData[8],
                Voter_Status = parsedData[9],
                Party_Affiliation = parsedData[10],
                Residential_Address1 = parsedData[11],
                Residential_Address_2_ = parsedData[12],
                Residential_City = parsedData[13],
                Residential_State = parsedData[14],
                Residential_Zip = parsedData[15],
                Residential_Zip_Plus_4 = parsedData[16],
                Residential_Country = parsedData[17],
                Residential_Postal_Code = parsedData[18],
                Mailing_Address1 = parsedData[19],
                Mailing_Address_2_ = parsedData[20],
                Mailing_City = parsedData[21],
                Mailing_State = parsedData[22],
                Mailing_Zip = parsedData[23],
                Mailing_Zip_Plus_4 = parsedData[24],
                Mailing_Country = parsedData[25],
                Mailing_Postal_Code = parsedData[26],
                Career_Center = parsedData[27],
                City = parsedData[28],
                City_School_District = parsedData[29],
                County_Court__District = parsedData[30],
                Congressional_District = parsedData[31],
                Court_of_Appeals = parsedData[32],
                Education_Service_Center = parsedData[33],
                Exempted_Village_School_District = parsedData[34],
                Library_District = parsedData[35],
                Local_School_District = parsedData[36],
                Municipal_Court_District = parsedData[37],
                Precinct = parsedData[38],
                Precinct_Code_ = parsedData[39],
                State_Board_of_Education = parsedData[40],
                State_Representative_District_ = parsedData[41],
                State_Senate_District = parsedData[42],
                Township = parsedData[43],
                Village = parsedData[44],
                Ward = parsedData[45]
            };
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