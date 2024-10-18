# OhRegisteredVoterModel
All of the bits and bobs used to generate a ML Model for Ohio Registered Voters.

## Download the data from the Ohio Secretary of State Website
The first thing to do is to download the files from [Statewide Voter Files Download Page](https://www6.ohiosos.gov/ords/f?p=VOTERFTP:STWD:::#stwdVtrFiles) There are other options that have the same data diced differently but I want the whole state
so, download all of the files on that page, currently 4 files. Once you have the files, since they are gz files, you will need to extract them to a folder so you have the text files to process.

Once the files are extracted, they need to be processed. To do that, use the executable created from the [PreProcessing solution](https://github.com/CarpDeus/OhRegisteredVoterModel/tree/main/Data/PreprocessingData). It takes three parameters, the
location of the input files, the location of the output files and the log file. Here's an example:
```
.\PreprocessingData.exe -i F:\VoterData\Input\Ohio -o F:\VoterData\Output\Ohio\PreprocessedData -l F:\VoterData\Output\Ohio\2024-Oct-18.log
```
