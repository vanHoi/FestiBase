using Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GenreModel
/// </summary>
public class GenreModel
{
    private readonly GenreDao _genreDao;

    public GenreModel()
    {
        _genreDao = new GenreDao();
    }

    public List<Genre> getAllGenres()
    {
        return _genreDao.GetAllGenres();
    }

}