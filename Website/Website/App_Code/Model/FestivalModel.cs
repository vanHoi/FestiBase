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

        public List<Festival> GetAllFestivals()
        {
            return _festivalDao.GetAllFestivals();
        }

        public Festival GetFestivalByNumber(int number)
        {
            return _festivalDao.GetFestivalbyNumber(number);
        }
    }
}