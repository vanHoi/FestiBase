using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Visitor
/// </summary>
public class Visitor
{
    private int visitorNumber;
    private int townNumber;
    private string email;
    private string firstName;
    private string surname;
    private string telephoneNumber;
    private DateTime birthdate;
    private string twitterUsername;
    private string facebookUsername;
    private string street;
    private int houseNumber;
    private List<Genre> genrePreferences;
    private List<Performance> performancesLiked;
    private List<Performance> performancesVisited;

    public Visitor(int visitorNumber, int townNumber, string email, string firstName, string surname, string telephoneNumber, 
        DateTime birthdate, string twitterUsername, string facebookUsername, string street, int houseNumber)
    {
        this.visitorNumber = visitorNumber;
        this.townNumber = townNumber;
        this.email = email;
        this.firstName = firstName;
        this.surname = surname;
        this.telephoneNumber = telephoneNumber;
        this.birthdate = birthdate;
        this.twitterUsername = twitterUsername;
        this.facebookUsername = facebookUsername;
        this.street = street;
        this.houseNumber = houseNumber;
        this.genrePreferences = new List<Genre>();
        this.performancesLiked = new List<Performance>();
        this.performancesVisited = new List<Performance>();
    }

    public Visitor(int visitorNumber, int townNumber, string email, string firstName, string surname, string telephoneNumber, 
        DateTime birthdate, string twitterUsername, string facebookUsername, string street, int houseNumber, 
        List<Genre> genrePreferences, List<Performance> performancesLiked, List<Performance> performancesVisited) : 
            this(visitorNumber, townNumber, email, firstName, surname, telephoneNumber, birthdate, twitterUsername, 
            facebookUsername, street, houseNumber)
    {
        this.genrePreferences = genrePreferences;
        this.performancesLiked = performancesLiked;
        this.performancesVisited = performancesVisited;
    }
}