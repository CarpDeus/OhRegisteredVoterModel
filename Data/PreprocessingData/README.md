# Preprocessing Data
This program takes the variable number of columns in the input file and transforms it into 4 output files with consistent columns that are easier to load into the database. Each of these files will be the name of the input file minus the extension plus an identifier. These are:
* ElectionData contains a voter id, the election identifier and the VoterRegisteredAs flag. No flag indicates the voter did not vote.
* Voter contains voter information
* Elections contains the list of elections from the column headers
* VoterCheck contains the VoterId, their registration date and the number of election data rows in contained in the ElectionData file. This is used for validating the load.

