using System.Collections.Generic;
using DAO;
using Domain;

namespace Model
{
    /// <summary>
    /// Summary description for GenreModel
    /// </summary>
    public class GenreModel
    {
        private readonly GenreDAO _genreDao;

        public GenreModel()
        {
            _genreDao = new GenreDAO();
        }

        public List<Genre> GetAllGenres()
        {
            return _genreDao.GetAllGenres();
        }

    }
}