using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for FestivalModel
/// </summary>
public class FestivalModel
{
    private FestivalDAO festivalDAO;

    public FestivalModel()
    {
        festivalDAO = new FestivalDAO();
    }

    public List<Festival> getAllFestivals()
    {
        return festivalDAO.getAllFestivals();
    }

    public Festival getFestivalByNumber(int number)
    {
        return festivalDAO.getFestivalbyNumber(number);
    }
}