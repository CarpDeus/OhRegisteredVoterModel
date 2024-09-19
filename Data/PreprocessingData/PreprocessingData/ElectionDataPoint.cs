namespace PreprocessingData
{

    public class ElectionData : List<ElectionDataPoint> { }

    public class ElectionDataPoint
    {
        public DateOnly ElectionDate { get; set; }
        public string ElectionName { get; set; }
        public string ElectionType { get; set; }

        public ElectionDataPoint(string columnHeader) 
        {
            ElectionName = columnHeader;
            DateOnly electDate = new DateOnly();
            string[] columnHeaderParts = columnHeader.Split('-');
            DateOnly.TryParse(columnHeaderParts[1], out electDate);
            ElectionDate = electDate;
            ElectionType = columnHeaderParts[0];
        }

    }
}

