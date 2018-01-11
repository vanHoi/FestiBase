using System.Collections.Generic;
using DAO;
using Domain;

namespace Model
{
    /// <summary>
    /// Summary description for FestivalModel
    /// </summary>
    public class FestivalModel
    {
        private readonly FestivalDAO _festivalDao;

        public FestivalModel()
        {
            _festivalDao = new FestivalDAO();
        }

        public List<Festival> getAllFestivals()
        {
            return _festivalDao.getAllFestivals();
        }

        public Festival getFestivalByNumber(int number)
        {
            return _festivalDao.getFestivalbyNumber(number);
        }
    }
}