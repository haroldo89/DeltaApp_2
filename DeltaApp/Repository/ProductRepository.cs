using AlbatrosSoft.Common;
using AlbatrosSoft.Common.Web;
using DeltaApp.DAL;
using DeltaApp.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;

namespace DeltaApp.Repository
{
    public class ProductRepository : IRepository<PRODUCT_VIEW>
    {

        protected DataContext DataContext { get; private set; }

        public ProductRepository()
        {
            this.DataContext = new DataContext();
        }

        public ProductRepository(DataContext dataContext)
        {
            this.DataContext = dataContext;
        }

        public string Delete(int entityId)
        {
            return this.DataContext.spDeleteProduct(entityId);
        }

        public IEnumerable<PRODUCT_VIEW> GetAll()
        {
            return this.DataContext.spGetProducts();
        }

        public IEnumerable<PRODUCT_VIEW> GetProducts(string PDT_NAME = "", string PDT_SIGLA = "", string PDT_DESC = "",
             int startIndex = 0, int count = 0, string sorting = "")
        {
            var entities = this.GetAll();
            //Filters
            entities = this.SearchInfo(entities, PDT_NAME, PDT_SIGLA, PDT_DESC);
            //Sorting
            entities = this.Sorting(sorting, entities);
            return count > 0
                       ? entities.Skip(startIndex).Take(count).ToList() //Paging
                       : entities.ToList(); //No paging
        }

        /// <summary>
        /// Numero de todos los datos disponibles
        /// </summary>
        /// <returns></returns>
        public int GetProductsCount(string PDT_NAME = "", string PDT_SIGLA = "", string PDT_DESC = "")
        {
            var entities = this.GetAll();
            //Filters
            entities = this.SearchInfo(entities, PDT_NAME, PDT_SIGLA, PDT_DESC);
            return entities.Count();
        }

        public PRODUCT_VIEW GetById(int id)
        {
            return this.GetAll().FirstOrDefault(p => p.PDT_ID.Equals(id));
        }

        public string Insert(PRODUCT_VIEW entity)
        {
            throw new NotImplementedException();
        }

        public string Insert(string PDT_NAME, string PDT_SIGLA, bool PDT_HASCODE, int? PROC_N0_ID, int? PROC_N1_ID, int? PROC_N2_ID,
            int? PROC_N3_ID, string PDT_DESC, int? OP_TYPE_ID, DateTime? PDT_OPORTUNITY_DATE_ACCORDED, string PDT_OPORTUNITY_PTO_REF,
            int? PDT_OPORTUNITY_DAYS, int? PDT_OPORTUNITY_HOURS, int? PDT_OPORTUNITY_MINUTES, int GOAL_TYPE_ID, string GOAL_QUANTITY_MONTH,
            string GOAL_POBLATION, int? GOAL_CONFIABILITY_INDEX, int? GOAL_SAMPLES, string checkList)
        {
            PRODUCT_VIEW entity = this.SetProductProperties(PDT_NAME, PDT_SIGLA, PDT_HASCODE, PROC_N0_ID, PROC_N1_ID, PROC_N2_ID, PROC_N3_ID,
                PDT_DESC, OP_TYPE_ID, PDT_OPORTUNITY_DATE_ACCORDED, PDT_OPORTUNITY_PTO_REF, PDT_OPORTUNITY_DAYS, PDT_OPORTUNITY_HOURS,
                PDT_OPORTUNITY_MINUTES, GOAL_TYPE_ID, GOAL_QUANTITY_MONTH, GOAL_POBLATION, GOAL_CONFIABILITY_INDEX, GOAL_SAMPLES);

            return DataContext.spCreateProduct(entity, checkList);
        }

        public IEnumerable<PRODUCT_PERTINENCES_VIEW> GetProductPertineces(int pdtId)
        {
            return this.DataContext.spGetProductPertinences(pdtId).ToList();

        }

        public string Insert(PRODUCT_VIEW entity, string checkList)
        {
            return DataContext.spCreateProduct(entity, checkList);
        }

        public string Update(PRODUCT_VIEW entity)
        {
            throw new NotImplementedException();
        }

        public string Update(int PDT_ID, string PDT_NAME, string PDT_SIGLA, bool PDT_HASCODE, int? PROC_N0_ID, int? PROC_N1_ID, int? PROC_N2_ID,
           int? PROC_N3_ID, string PDT_DESC, int? OP_TYPE_ID, DateTime? PDT_OPORTUNITY_DATE_ACCORDED, string PDT_OPORTUNITY_PTO_REF,
           int? PDT_OPORTUNITY_DAYS, int? PDT_OPORTUNITY_HOURS, int? PDT_OPORTUNITY_MINUTES, int GOAL_TYPE_ID, string GOAL_QUANTITY_MONTH,
           string GOAL_POBLATION, int? GOAL_CONFIABILITY_INDEX, int? GOAL_SAMPLES, string checkList)
        {
            PRODUCT_VIEW entity = this.SetProductProperties(PDT_NAME, PDT_SIGLA, PDT_HASCODE, PROC_N0_ID, PROC_N1_ID, PROC_N2_ID, PROC_N3_ID,
                PDT_DESC, OP_TYPE_ID, PDT_OPORTUNITY_DATE_ACCORDED, PDT_OPORTUNITY_PTO_REF, PDT_OPORTUNITY_DAYS, PDT_OPORTUNITY_HOURS,
                PDT_OPORTUNITY_MINUTES, GOAL_TYPE_ID, GOAL_QUANTITY_MONTH, GOAL_POBLATION, GOAL_CONFIABILITY_INDEX, GOAL_SAMPLES, PDT_ID);

            return DataContext.spUpdateProduct(entity, checkList);
        }

        public string Update(PRODUCT_VIEW entity, string checkList)
        {
            return this.DataContext.spUpdateProduct(entity, checkList);
        }

        private PRODUCT_VIEW SetProductProperties(string PDT_NAME, string PDT_SIGLA, bool PDT_HASCODE, int? PROC_N0_ID, int? PROC_N1_ID, int? PROC_N2_ID, int? PROC_N3_ID, string PDT_DESC,
            int? OP_TYPE_ID, DateTime? PDT_OPORTUNITY_DATE_ACCORDED, string PDT_OPORTUNITY_PTO_REF, int? PDT_OPORTUNITY_DAYS, int? PDT_OPORTUNITY_HOURS, int? PDT_OPORTUNITY_MINUTES,
            int GOAL_TYPE_ID, string GOAL_QUANTITY_MONTH, string GOAL_POBLATION, int? GOAL_CONFIABILITY_INDEX, int? GOAL_SAMPLES, int? PDT_ID = null)
        {
            return new PRODUCT_VIEW
            {
                PDT_ID = PDT_ID.HasValue ? PDT_ID.Value : 0,
                PDT_NAME = PDT_NAME,
                PDT_SIGLA = PDT_SIGLA,
                PDT_HASCODE = PDT_HASCODE,
                PROC_N0_ID = PROC_N0_ID,
                PROC_N1_ID = PROC_N1_ID,
                PROC_N2_ID = PROC_N2_ID,
                PROC_N3_ID = PROC_N3_ID,
                PDT_DESC = PDT_DESC,
                OP_TYPE_ID = OP_TYPE_ID,
                PDT_OPORTUNITY_DATE_ACCORDED = PDT_OPORTUNITY_DATE_ACCORDED,
                PDT_OPORTUNITY_PTO_REF = PDT_OPORTUNITY_PTO_REF,
                PDT_OPORTUNITY_DAYS = PDT_OPORTUNITY_DAYS,
                PDT_OPORTUNITY_HOURS = PDT_OPORTUNITY_HOURS,
                PDT_OPORTUNITY_MINUTES = PDT_OPORTUNITY_MINUTES,
                GOAL_TYPE_ID = GOAL_TYPE_ID,
                GOAL_QUANTITY_MONTH = GOAL_QUANTITY_MONTH,
                GOAL_POBLATION = GOAL_POBLATION,
                GOAL_CONFIABILITY_INDEX = GOAL_CONFIABILITY_INDEX,
                GOAL_SAMPLES = GOAL_SAMPLES
            };
        }

        public IEnumerable<PRODUCT_ROL_QUERY_VIEW> GetUserRoleProducts(int userRoleId)
        {
            return this.DataContext.GetProduct(userRoleId);
        }



        public IEnumerable<PRODUCT_ROL_VIEW> GetProductsByUserID(int userID)
        {
            return this.DataContext.spGetUserRoleProducts(userID);
        }


        public string InsertRolProducts(int userRoleId, string productsId)
        {
            return DataContext.spInsertRolProducts(userRoleId, productsId);
        }

        #region Busqueda y ordenamiento
        private IEnumerable<PRODUCT_VIEW> SearchInfo(IEnumerable<PRODUCT_VIEW> entities, string PDT_NAME = "", string PDT_SIGLA = "",
            string PDT_DESC = "")
        {
            var dataSource = entities;
            IEnumerable<PRODUCT_VIEW> searchResult = null;
            Func<PRODUCT_VIEW, bool> filterCriteria = p => true;
            var filterHelper = new FilterHelper<PRODUCT_VIEW>();
            //Nombre
            if (!string.IsNullOrWhiteSpace(PDT_NAME))
            {
                filterCriteria = filterHelper.AddFilterExpression(filterCriteria, p => p.PDT_NAME.ToUpper(CultureInfo.InvariantCulture)
                    .Contains(PDT_NAME.ToUpper(CultureInfo.InvariantCulture)));
            }
            if (!string.IsNullOrWhiteSpace(PDT_SIGLA))
            {
                filterCriteria = filterHelper.AddFilterExpression(filterCriteria, p => p.PDT_SIGLA.ToUpper(CultureInfo.InvariantCulture)
                    .Contains(PDT_SIGLA.ToUpper(CultureInfo.InvariantCulture)));
            }
            if (!string.IsNullOrWhiteSpace(PDT_DESC))
            {
                filterCriteria = filterHelper.AddFilterExpression(filterCriteria, p => p.PDT_DESC.ToUpperInvariant()
                    .Contains(PDT_DESC.ToUpperInvariant()));
            }
            if (filterCriteria != null)
            {
                searchResult = dataSource.Where(filterCriteria);
                return searchResult;
            }
            return dataSource;
        }

        /// <summary>
        /// Ordenamiento
        /// </summary>
        /// <param name="sortExpression">Tipo de ordenamiento</param>
        /// <param name="entities">Lista a ordenar</param>
        /// <returns></returns>      
        private IEnumerable<PRODUCT_VIEW> Sorting(string sortExpression, IEnumerable<PRODUCT_VIEW> entities)
        {
            if (!string.IsNullOrEmpty(sortExpression))
            {
                string[] sortProperties = sortExpression.Split(' ');
                string sortColumn = sortProperties[0];
                string sortDirection = sortProperties[1];
                IEnumerable<PRODUCT_VIEW> sortedData = null;
                if (entities != null)
                {
                    sortedData = SortingHelper<PRODUCT_VIEW>.SortBy(entities, sortColumn, sortDirection);
                }
                return sortedData;
            }
            return entities;
        }

        #endregion Busqueda y ordenamiento
    }
}