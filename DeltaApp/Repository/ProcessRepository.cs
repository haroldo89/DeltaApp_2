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
    public class ProcessRepository : IRepository<PROCESS_N0_VIEW>
    {
        private DataContext DataContext;

        public ProcessRepository()
        {
            this.DataContext = new DataContext();
        }

        public ProcessRepository(DataContext dataContext)
        {
            this.DataContext = dataContext;
        }

        #region IRepository
        public string Delete(int entityId)
        {
            return this.DataContext.spDeleteProcess0(entityId);
        }

        public IEnumerable<PROCESS_N0_VIEW> GetAll()
        {
            return this.DataContext.spGetProcess0();
        }

        public PROCESS_N0_VIEW GetById(int id)
        {
            return this.GetAll().FirstOrDefault(a => a.PROC_N0_ID.Equals(id));
        }

        public string Insert(PROCESS_N0_VIEW entity)
        {
            return this.DataContext.spCreateProcess0(entity);
        }

        public string Update(PROCESS_N0_VIEW entity)
        {
            return this.DataContext.spUpdateProcess0(entity);
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
        public IEnumerable<PROCESS_N0_VIEW> GetProcess0(string name, int startIndex, int count, string sorting)
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
        public int GetProcessCount(string name)
        {
            var areas = this.GetAll();
            //Filters
            areas = this.SearchInfo(areas, name);
            return areas.Count();
        }

        #endregion Metodos jTable

        #region Busqueda y ordenamiento
        private IEnumerable<PROCESS_N0_VIEW> SearchInfo(IEnumerable<PROCESS_N0_VIEW> areas, string name)
        {
            var dataSource = areas;
            IEnumerable<PROCESS_N0_VIEW> searchResult = null;
            Func<PROCESS_N0_VIEW, bool> filterCriteria = p => true;
            var filterHelper = new FilterHelper<PROCESS_N0_VIEW>();
            //Nombre
            if (!string.IsNullOrEmpty(name))
            {
                filterCriteria = filterHelper.AddFilterExpression(filterCriteria, p => p.PROC_N0_NAME.ToUpper(CultureInfo.InvariantCulture)
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
        private IEnumerable<PROCESS_N0_VIEW> Sorting(string sortExpression, IEnumerable<PROCESS_N0_VIEW> areas)
        {
            if (!string.IsNullOrEmpty(sortExpression))
            {
                string[] sortProperties = sortExpression.Split(' ');
                string sortColumn = sortProperties[0];
                string sortDirection = sortProperties[1];
                IEnumerable<PROCESS_N0_VIEW> sortedData = null;
                if (areas != null)
                {
                    sortedData = SortingHelper<PROCESS_N0_VIEW>.SortBy(areas, sortColumn, sortDirection);
                }
                return sortedData;
            }
            return areas;
        }

        #endregion Busqueda y ordenamiento

        public IEnumerable<SelectListItem> GetProcessItems()
        {
            List<SelectListItem> processList = new List<SelectListItem>();
            try
            {
                var process = this.GetAll();
                foreach (var item in process)
                {
                    processList.Add(new SelectListItem(item.PROC_N0_ID.ToString(), item.PROC_N0_NAME));
                }
            }
            catch
            {
                processList = new List<SelectListItem>();
            }
            return processList;
        }
    }
}