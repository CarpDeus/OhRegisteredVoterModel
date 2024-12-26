using CommandLine;
using System.ComponentModel.DataAnnotations;
using System.Reflection.Metadata.Ecma335;

namespace PreprocessingData
{
    class Program
    {
        static void Main(string[] args)
        {
            Parser.Default.ParseArguments<Options>(args)
                    .WithParsed<Options>(o =>
                    {
                        FileProcessor.ProcessFiles(o.inputFolder, o.outputFolder, o.logFile, o.connectionString);
                    });
        }

       
    }

    public class Options
    {
        [Option('i', "inputFolder", Required = true, HelpText = "Input directory with text files to process")]
        public string inputFolder { get; set; }

        [Option('o', "outputFolder", Required = true, HelpText = "Output directory with text files to process")]
        public string outputFolder { get; set; }

        [Option('l', "logFile", Required = true, HelpText = "File to log data in")]
        public string logFile { get; set; }

        [Option('c', "connectionString", Required = true, HelpText = "Sql Connection String")]
        public string connectionString { get; set; }
    }
}

