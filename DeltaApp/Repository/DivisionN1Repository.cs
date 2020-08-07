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
    public class DivisionN1Repository : IRepository<DIVISION_N1_VIEW>
    {
        private DataContext DataContext;

        public DivisionN1Repository()
        {
            this.DataContext = new DataContext();
        }

        public DivisionN1Repository(DataContext dataContext)
        {
            this.DataContext = dataContext;
        }

        public string Delete(int entityId)
        {
            return this.DataContext.spDeleteDivisionN1(entityId);
        }

        public IEnumerable<DIVISION_N1_VIEW> GetAll()
        {
            return this.DataContext.spGetDivisionN1();
        }

        public DIVISION_N1_VIEW GetById(int id)
        {
            return this.GetAll().FirstOrDefault(a => a.DIV_N1_ID.Equals(id));
        }

        public string Insert(DIVISION_N1_VIEW entity)
        {
            return this.DataContext.spCreateDivisionN1(entity);
        }

        public string Update(DIVISION_N1_VIEW entity)
        {
            return this.DataContext.spUpdateDivisionN1(entity);
        }


        public IEnumerable<SelectListItem> GeDivisionN1Items(int AreaId)
        {
            List<SelectListItem> DivisionsList = new List<SelectListItem>();
            try
            {
                var DivisionsN1 = this.GetAll().Where(p => p.AREA_ID.Equals(AreaId));
                foreach (var item in DivisionsN1)
                {
                    DivisionsList.Add(new SelectListItem(item.DIV_N1_ID.ToString(), item.DIV_N1_NAME));
                }
            }
            catch
            {
                DivisionsList = new List<SelectListItem>();
            }
            return DivisionsList;
        }

        #region Metodos jTable
        /// <summary>
        /// Obtener datos
        /// </summary>
        /// <param name="name">Nombre</param>
        /// <param name="description">Descripcion</param>
        /// <param name="startIndex">Indice inicial</param>
        /// <param name="count">total de registros</param>
        /// <param name="sorting">ordenamiento</param>
        /// <returns></returns>
        public IEnumerable<DIVISION_N1_VIEW> GetDivisions1(string name, int startIndex, int count, string sorting)
        {
            var entities = this.GetAll();
            //Filters
            entities = this.SearchInfo(entities, name);
            //Sorting
            entities = this.Sorting(sorting, entities);
            return count > 0
                       ? entities.Skip(startIndex).Take(count).ToList() //Paging
                       : entities.ToList(); //No paging
        }

        public IEnumerable<DIVISION_N1_VIEW> GetDivisions1(int areaId, int startIndex, int count, string sorting)
        {
            //Entidades
            var entities = this.GetAll().Where(d => d.AREA_ID.Equals(areaId));
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
        public int GetDivisions1Count(string name)
        {
            var entities = this.GetAll();
            //Filters
            entities = this.SearchInfo(entities, name);
            return entities.Count();
        }

        public int GetDivisions1Count(int areaId)
        {
            //Entidades
            var entities = this.GetAll().Where(d => d.AREA_ID.Equals(areaId));
            return entities.Count();
        }

        #endregion Metodos jTable

        #region Busqueda y ordenamiento
        private IEnumerable<DIVISION_N1_VIEW> SearchInfo(IEnumerable<DIVISION_N1_VIEW> entities, string name)
        {
            var dataSource = entities;
            IEnumerable<DIVISION_N1_VIEW> searchResult = null;
            Func<DIVISION_N1_VIEW, bool> filterCriteria = p => true;
            var filterHelper = new FilterHelper<DIVISION_N1_VIEW>();
            //Nombre
            if (!string.IsNullOrEmpty(name))
            {
                filterCriteria = filterHelper.AddFilterExpression(filterCriteria, p => p.DIV_N1_NAME.ToUpper(CultureInfo.InvariantCulture)
                    .Contains(name.ToUpper(CultureInfo.InvariantCulture)));
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
        private IEnumerable<DIVISION_N1_VIEW> Sorting(string sortExpression, IEnumerable<DIVISION_N1_VIEW> entities)
        {
            if (!string.IsNullOrEmpty(sortExpression))
            {
                string[] sortProperties = sortExpression.Split(' ');
                string sortColumn = sortProperties[0];
                string sortDirection = sortProperties[1];
                IEnumerable<DIVISION_N1_VIEW> sortedData = null;
                if (entities != null)
                {
                    sortedData = SortingHelper<DIVISION_N1_VIEW>.SortBy(entities, sortColumn, sortDirection);
                }
                return sortedData;
            }
            return entities;
        }

        #endregion Busqueda y ordenamiento
    }
}