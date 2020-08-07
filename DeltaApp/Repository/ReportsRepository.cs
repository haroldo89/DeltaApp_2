using DeltaApp.DAL;
using DeltaApp.Models;
using DeltaApp.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DeltaApp.Repository
{
    public class ReportsRepository : IRepository<GENERAL_RESUME_VIEW>
    {
        DataContext dataContext = new DataContext();


        public string Delete(int entityId)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<GENERAL_RESUME_VIEW> GetAll()
        {
            return dataContext.spGetGeneralResume(); 
        }

        public IEnumerable<GENERAL_RESUME_VIEW> GetAll_GENERAL_RESUME()
        {
            return dataContext.spGetGeneralResume(); 
        }


        public IEnumerable<USER_PU_RELATION_MEASURE_VIEW> GetAll_USER_PU_RELATION(string dateFrom, string dateTo)
        {
            return dataContext.spGetUserPuRelation(DateTime.Parse(dateFrom) , DateTime.Parse(dateTo));
        }

        public IEnumerable<ROL_RELATION_MEASURE_VIEW> GetRolRelation(string dateFrom, string dateTo)
        {
            return dataContext.spGetRolRelation(DateTime.Parse(dateFrom), DateTime.Parse(dateTo));
        }

        public IEnumerable<EFECTIVITY_VIEW> GetEfectivity(string dateFrom, string dateTo)
        {
            return dataContext.spGetEfectivity(DateTime.Parse(dateFrom), DateTime.Parse(dateTo));
        }

        public IEnumerable<EFECTIVITY_OK_VIEW> GetEfectivityOK(string dateFrom, string dateTo)
        {
            return dataContext.spGetEfectivityOK(DateTime.Parse(dateFrom), DateTime.Parse(dateTo));
        }

        public IEnumerable<PRODUCT_DEFECTS_DETAIL> GetDefectProduct (string dateFrom, string dateTo)
        {
            return dataContext.spGetDefectProducts(DateTime.Parse(dateFrom), DateTime.Parse(dateTo));
        }

        public IEnumerable<PERTINENCES_DEFECTS> GetPertinecesDefects(string dateFrom, string dateTo)
        {
            return dataContext.spGetPertinencesDefects(DateTime.Parse(dateFrom), DateTime.Parse(dateTo));
        }

        public IEnumerable<MEASURE_NO_PRODUCTS_VIEW> GetNoMeasure()
        {
            return dataContext.spGetNoMeasureProducts();
        }

        public GENERAL_RESUME_VIEW GetById(int id)
        {
            throw new NotImplementedException();
        }

        public string Insert(GENERAL_RESUME_VIEW entity)
        {
            throw new NotImplementedException();
        }

        public string Update(GENERAL_RESUME_VIEW entity)
        {
            throw new NotImplementedException();
        }
    }
}