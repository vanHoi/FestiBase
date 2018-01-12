namespace Domain
{
    /// <summary>
    /// Summary description for Organisation
    /// </summary>
    public class Organisation
    {
        public Organisation() { }

        public Organisation(int organisationNumber, int name)
        {
            this.OrganisationNumber = organisationNumber;
            this.Name = name;
        }

        public int OrganisationNumber { get; set; }

        public int Name { get; set; }
    }
}