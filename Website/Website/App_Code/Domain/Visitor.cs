using System;
using System.Collections.Generic;

namespace Domain
{
    /// <summary>
    /// Summary description for Visitor
    /// </summary>
    public class Visitor
    {
        public Visitor() { }

        public Visitor(int visitorNumber, Town town, string email, string firstName, string surname, string telephoneNumber, DateTime birthdate, string twitterUsername, string facebookUsername, string street, int houseNumber)
        {
            this.VisitorNumber = visitorNumber;
            this.Town = town;
            this.Email = email;
            this.FirstName = firstName;
            this.Surname = surname;
            this.TelephoneNumber = telephoneNumber;
            this.Birthdate = birthdate;
            this.TwitterUsername = twitterUsername;
            this.FacebookUsername = facebookUsername;
            this.Street = street;
            this.HouseNumber = houseNumber;
        }

        public Visitor(int visitorNumber, Town town, string email, string firstName, string surname, string telephoneNumber, DateTime birthdate, string twitterUsername, string facebookUsername, string street, int houseNumber, List<Genre> genrePreferences, List<Performance> performancesLiked, List<Performance> performancesVisited)
        {
            this.VisitorNumber = visitorNumber;
            this.Town = town;
            this.Email = email;
            this.FirstName = firstName;
            this.Surname = surname;
            this.TelephoneNumber = telephoneNumber;
            this.Birthdate = birthdate;
            this.TwitterUsername = twitterUsername;
            this.FacebookUsername = facebookUsername;
            this.Street = street;
            this.HouseNumber = houseNumber;
            this.GenrePreferences = genrePreferences;
            this.PerformancesLiked = performancesLiked;
            this.PerformancesVisited = performancesVisited;
        }

        public int VisitorNumber { get; set; }

        public Town Town { get; set; }

        public string Email { get; set; }

        public string FirstName { get; set; }

        public string Surname { get; set; }

        public string TelephoneNumber { get; set; }

        public DateTime Birthdate { get; set; }

        public string TwitterUsername { get; set; }

        public string FacebookUsername { get; set; }

        public string Street { get; set; }

        public int HouseNumber { get; set; }

        public List<Genre> GenrePreferences { get; set; }

        public List<Performance> PerformancesLiked { get; set; }

        public List<Performance> PerformancesVisited { get; set; }
    }
}