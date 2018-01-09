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


    public int VisitorNumber
    {
        get => visitorNumber;
        set => visitorNumber = value;
    }

    public int TownNumber
    {
        get => townNumber;
        set => townNumber = value;
    }

    public string Email
    {
        get => email;
        set => email = value;
    }

    public string FirstName
    {
        get => firstName;
        set => firstName = value;
    }

    public string Surname
    {
        get => surname;
        set => surname = value;
    }

    public string TelephoneNumber
    {
        get => telephoneNumber;
        set => telephoneNumber = value;
    }

    public DateTime Birthdate
    {
        get => birthdate;
        set => birthdate = value;
    }

    public string TwitterUsername
    {
        get => twitterUsername;
        set => twitterUsername = value;
    }

    public string FacebookUsername
    {
        get => facebookUsername;
        set => facebookUsername = value;
    }

    public string Street
    {
        get => street;
        set => street = value;
    }

    public int HouseNumber
    {
        get => houseNumber;
        set => houseNumber = value;
    }

    public List<Genre> GenrePreferences
    {
        get => genrePreferences;
        set => genrePreferences = value;
    }

    public List<Performance> PerformancesLiked
    {
        get => performancesLiked;
        set => performancesLiked = value;
    }

    public List<Performance> PerformancesVisited
    {
        get => performancesVisited;
        set => performancesVisited = value;
    }
}