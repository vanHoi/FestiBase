using System;

/// <summary>
/// Summary description for Class1
/// </summary>
public class DatabaseTest
{
    private SqlConnection conn;

    public DatabaseTest()
	{
        conn = new SqlConnection("user id=sa;" +
                                "password=wachtwoord123;" +
                                "server=localhost;" +
                                "Trusted_Connection=yes;" +
                                "database=FestiBase; " +
                                "connection timeout=30");

        try
        {
            conn.Open();
        }
        catch(Exception e)
        {
            Console.WriteLine(e.ToString());
        }
    }
}
