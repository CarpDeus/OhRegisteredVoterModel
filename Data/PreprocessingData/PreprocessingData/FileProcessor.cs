using System.Reflection.Metadata.Ecma335;
using System.Text;

namespace PreprocessingData
{
    public static class FileProcessor
    {
        static ElectionData ParseHeaders(string[] VoterColumns, string[] HeaderColumns)
        {
            ElectionData retVal = new ElectionData();
            for (int i = VoterColumns.Length; i < HeaderColumns.Length; i++)
            {
                retVal.Add(new ElectionDataPoint(HeaderColumns[i].Replace("\"", "")));
            }
            return retVal;
        }

        public static string ArrayToPipeDelimitedString(string[] arrayToConvert)
        {
            StringBuilder sb = new StringBuilder();
            foreach (string str in arrayToConvert)
            {
                if (!str.StartsWith("\"")) sb.Append($"\"");
                sb.Append($"{str}");
                if (!str.EndsWith("\"")) sb.Append($"\"");
                sb.Append("|");
            }
            //sb.Append("\r\n");
            return sb.ToString();
        }

        public static void WriteData(string fileName, string data)
        {
            using (StreamWriter sw = File.AppendText(fileName))
            {
                sw.Write(data);
            }
        }

        internal static void ProcessFile(string inputFileName, string outputDirectory, string logFile)
        {
            int voterCount = 0;
            int voterElectionRecordsCount = 0;
            string[] ColumnHeaders = new string[1];
            ElectionData electionData = new ElectionData();
            VoterSummary voterSummary = new VoterSummary();
            string outputVoterData;
            string outputVoterElectionHistory;
            string[] VoterColumnHeaders =  { "SOS_VOTERID", "COUNTY_NUMBER",
                    "COUNTY_ID", "LAST_NAME", "FIRST_NAME", "MIDDLE_NAME",
                    "SUFFIX", "DATE_OF_BIRTH", "REGISTRATION_DATE", "VOTER_STATUS",
                    "PARTY_AFFILIATION", "RESIDENTIAL_ADDRESS1", "RESIDENTIAL_SECONDARY_ADDR",
                    "RESIDENTIAL_CITY", "RESIDENTIAL_STATE", "RESIDENTIAL_ZIP",
                    "RESIDENTIAL_ZIP_PLUS4", "RESIDENTIAL_COUNTRY", "RESIDENTIAL_POSTALCODE",
                    "MAILING_ADDRESS1", "MAILING_SECONDARY_ADDRESS", "MAILING_CITY",
                    "MAILING_STATE", "MAILING_ZIP", "MAILING_ZIP_PLUS4", "MAILING_COUNTRY",
                    "MAILING_POSTAL_CODE", "CAREER_CENTER", "CITY", "CITY_SCHOOL_DISTRICT",
                    "COUNTY_COURT_DISTRICT", "CONGRESSIONAL_DISTRICT", "COURT_OF_APPEALS",
                    "EDU_SERVICE_CENTER_DISTRICT", "EXEMPTED_VILL_SCHOOL_DISTRICT", "LIBRARY",
                    "LOCAL_SCHOOL_DISTRICT", "MUNICIPAL_COURT_DISTRICT", "PRECINCT_NAME",
                    "PRECINCT_CODE", "STATE_BOARD_OF_EDUCATION", "STATE_REPRESENTATIVE_DISTRICT",
                    "STATE_SENATE_DISTRICT", "TOWNSHIP", "VILLAGE", "WARD" };
            bool isHeaderRow = true;
            DateTime lastDateTime = DateTime.Now;


            string inputFileNameOnly = System.IO.Path.GetFileNameWithoutExtension(inputFileName);
            string outputVoterFile = $"{outputDirectory}{inputFileNameOnly}.Voter.txt";
            string outputVoterHistoryFile = $"{outputDirectory}{inputFileNameOnly}.ELectionData.txt";
            string outputVoterCheckFile = $"{outputDirectory}{inputFileNameOnly}.VoterCheck.txt";
            string outputElectionsFile = $"{outputDirectory}{inputFileNameOnly}.Elections.txt";

            File.Delete(outputVoterFile);
            File.Delete(outputVoterHistoryFile);
            File.Delete(outputVoterCheckFile);
            File.Delete(outputElectionsFile);

            const Int32 BufferSize = 128;
            using (var fileStream = File.OpenRead(inputFileName))
            using (var streamReader = new StreamReader(fileStream, Encoding.UTF8, true, BufferSize))
            {
                StreamWriter swOutputVoterFile = File.AppendText(outputVoterFile);
                StreamWriter swOutputVoterHistoryFile = File.AppendText(outputVoterHistoryFile);
                String line;
                while ((line = streamReader.ReadLine()) != null)
                {
                    if (isHeaderRow)
                    {
                        ColumnHeaders = line.Split(',');
                        electionData = ParseHeaders(VoterColumnHeaders, ColumnHeaders);
                        isHeaderRow = false;
                        swOutputVoterFile.WriteLine(ArrayToPipeDelimitedString(VoterColumnHeaders));
                        swOutputVoterHistoryFile.WriteLine("\"SOS_VOTERID\"|\"ElectionName\"|\"VoterRegisteredAs\"|");
                        //WriteData(outputVoterFile, ArrayToPipeDelimitedString(VoterColumnHeaders));
                        //WriteData(outputVoterHistoryFile, "\"SOS_VOTERID\"|\"ElectionName\"|\"ElectionType\"\r\n");
                    }
                    else
                    {
                        LineProcessor lp = new LineProcessor(line, VoterColumnHeaders, ColumnHeaders, electionData);
                        swOutputVoterFile.WriteLine(lp.VoterData);
                        //WriteData(outputVoterFile, lp.VoterData);
                        StringBuilder sbElectionData = new StringBuilder();
                        foreach (var x in lp.VoterHistoricalData)
                        {
                            sbElectionData.AppendLine($"{lp.VoterId}|{x.Key}|{x.Value}|");
                        }
                        swOutputVoterHistoryFile.WriteLine(sbElectionData.ToString());
                        //WriteData(outputVoterHistoryFile, sbElectionData.ToString());
                        voterSummary.Add(new VoterSummaryDetail { VoterId = lp.VoterId, DateRegistered = lp.RegistrationDate, NumberOfElectionRecords = lp.VoterHistoricalData.Count });
                        voterCount++;
                        voterElectionRecordsCount += lp.VoterHistoricalData.Count;
                        if (voterCount % 10000 == 0)
                        {
                            Console.WriteLine($"{inputFileNameOnly}: {voterCount.ToString("N0")} - {voterElectionRecordsCount.ToString("N0")}\t{DateTime.Now.Subtract(lastDateTime).Seconds}");
                            lastDateTime = DateTime.Now;
                        }
                    }
                }
                swOutputVoterHistoryFile.Close();
                swOutputVoterHistoryFile.Dispose();
                swOutputVoterHistoryFile = null;
                swOutputVoterFile.Close();
                swOutputVoterFile.Dispose();
                swOutputVoterFile = null;
                using (StreamWriter swOutputElectionsFile = File.AppendText(outputElectionsFile))
                {
                    swOutputElectionsFile.WriteLine($"\"ElectionName\"|\"ElectionDate\"|\"ElectionType\"|");
                    foreach (var x in electionData) { swOutputElectionsFile.WriteLine($"\"{x.ElectionName}\"|\"{x.ElectionDate}\"|\"{x.ElectionType}\"|"); }
                }
                using (StreamWriter swOutputVoterCheckFile = File.AppendText(outputVoterCheckFile))
                {
                    swOutputVoterCheckFile.WriteLine($"\"SOS_VOTERID\"|\"REGISTRATION_DATE\"|\"NumberOfElectionRecords\"|");
                    foreach (var x in voterSummary)
                    { swOutputVoterCheckFile.WriteLine($"{x.VoterId}|\"{x.DateRegistered}\"|\"{x.NumberOfElectionRecords}\"|"); }
                }
                //    WriteData(outputVoterCheckFile, $"\"ElectionName\"|\"ElectionDate\"|\"ElectionType\"|\r\n");
                
                Console.WriteLine($"{inputFileNameOnly}: {voterCount.ToString("N0")} - {voterElectionRecordsCount.ToString("N0")}");
            }
        }

        internal static void ProcessFolders(string inputDirectory, string outputDirectory, string logFile)
        {
            
            foreach (string folderName in System.IO.Directory.EnumerateDirectories(inputDirectory))
            {
                ProcessFolders(inputDirectory, outputDirectory, logFile);
            }
            foreach (string inputFileName in System.IO.Directory.EnumerateFiles(inputDirectory))
            {
                ProcessFile(inputFileName, outputDirectory, logFile);
            }
        }

        internal static string ValidateFolderPath(string folderName)
        { if (!folderName.EndsWith("\\")) return folderName += "\\"; 
        return folderName;
        }

        public static void ProcessFiles(string inputDirectory, string outputDirectory, string logFile)
        {
            ProcessFolders(ValidateFolderPath( inputDirectory), ValidateFolderPath(outputDirectory), logFile);
        }
    }
}

