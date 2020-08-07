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
    public class AreaRepository : IRepository<AREA_VIEW>
    {
        private DataContext DataContext;

        public AreaRepository()
        {
            this.DataContext = new DataContext();
        }

        public AreaRepository(DataContext dataContext)
        {
            this.DataContext = dataContext;
        }

        #region IRepository
        public string Delete(int entityId)
        {
            return this.DataContext.spDeleteArea(entityId);
        }

        public IEnumerable<AREA_VIEW> GetAll()
        {
            return this.DataContext.spGetAreas();
        }

        public AREA_VIEW GetById(int id)
        {
            return this.GetAll().FirstOrDefault(a => a.AREA_ID.Equals(id));
        }

        public string Insert(AREA_VIEW entity)
        {
            return this.DataContext.spCreateArea(entity);
        }

        public string Update(AREA_VIEW entity)
        {
            return this.DataContext.spUpdateArea(entity);
        }
        #endregion IRepository

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
        public IEnumerable<AREA_VIEW> GetAreas(string name, int startIndex, int count, string sorting)
        {
            var areas = this.GetAll();
            //Filters
            areas = this.SearchInfo(areas, name);
            //Sorting
            areas = this.Sorting(sorting, areas);
            return count > 0
                       ? areas.Skip(startIndex).Take(count).ToList() //Paging
                       : areas.ToList(); //No paging
        }

        /// <summary>
        /// Numero de todos los datos disponibles
        /// </summary>
        /// <returns></returns>
        public int GetAreasCount(string name)
        {
            var areas = this.GetAll();
            //Filters
            areas = this.SearchInfo(areas, name);
            return areas.Count();
        }

        #endregion Metodos jTable

        #region Busqueda y ordenamiento
        private IEnumerable<AREA_VIEW> SearchInfo(IEnumerable<AREA_VIEW> areas, string name)
        {
            var dataSource = areas;
            IEnumerable<AREA_VIEW> searchResult = null;
            Func<AREA_VIEW, bool> filterCriteria = p => true;
            var filterHelper = new FilterHelper<AREA_VIEW>();
            //Nombre
            if (!string.IsNullOrEmpty(name))
            {
                filterCriteria = filterHelper.AddFilterExpression(filterCriteria, p => p.AREA_NAME.ToUpper(CultureInfo.InvariantCulture)
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
        /// <param name="areas">Lista a ordenar</param>
        /// <returns></returns>      
        private IEnumerable<AREA_VIEW> Sorting(string sortExpression, IEnumerable<AREA_VIEW> areas)
        {
            if (!string.IsNullOrEmpty(sortExpression))
            {
                string[] sortProperties = sortExpression.Split(' ');
                string sortColumn = sortProperties[0];
                string sortDirection = sortProperties[1];
                IEnumerable<AREA_VIEW> sortedData = null;
                if (areas != null)
                {
                    sortedData = SortingHelper<AREA_VIEW>.SortBy(areas, sortColumn, sortDirection);
                }
                return sortedData;
            }
            return areas;
        }

        #endregion Busqueda y ordenamiento
    }
}