using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;


namespace PreprocessingData
{
    public class DataProcessing
    {
        public static void ClearData(string connectionString)
        {
            string sqlClearData = "truncate table staging.OhioVoterLoad;\r\ntruncate table staging.OhioVoterElectionRecord;\r\ntruncate table [staging].[OhioVoterElectionCount];\r\ntruncate table [staging].[OhioElections];";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(sqlClearData, connection);
                connection.Open();
                command.ExecuteNonQuery();
            }
        }

        public static void AddElectionsToDb(ElectionData ed, string connectionString)
        {
            string jsonData = JsonSerializer.Serialize(ed);
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("staging.ProcessElections", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@JsonData", jsonData);
                connection.Open();
                command.ExecuteNonQuery();
            }
        }

        public static void AddVoterDataToDb(List<LineProcessor> lp, string connectionString)
        {
            string jsonData = JsonSerializer.Serialize(lp);
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("staging.ProcessData", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@JsonData", jsonData);
                connection.Open();
                command.ExecuteNonQuery();
            }
        }
    }
}
