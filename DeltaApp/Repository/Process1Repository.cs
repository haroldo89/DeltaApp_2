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
    public class Process1Repository : IRepository<PROCESS_N1_VIEW>
    {
        private DataContext DataContext;

        public Process1Repository()
        {
            this.DataContext = new DataContext();
        }

        public Process1Repository(DataContext dataContext)
        {
            this.DataContext = dataContext;
        }

        public string Delete(int entityId)
        {
            return this.DataContext.spDeleteProcess1(entityId);
        }

        public IEnumerable<PROCESS_N1_VIEW> GetAll()
        {
            return this.DataContext.spGetProcess1();
        }

        public PROCESS_N1_VIEW GetById(int id)
        {
            return this.GetAll().FirstOrDefault(a => a.PROC_N1_ID.Equals(id));
        }

        public string Insert(PROCESS_N1_VIEW entity)
        {
            return this.DataContext.spCreateProcess1(entity);
        }

        public string Update(PROCESS_N1_VIEW entity)
        {
            return this.DataContext.spUpdateProcess1(entity);
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
        public IEnumerable<PROCESS_N1_VIEW> GetProcess1(string name, int startIndex, int count, string sorting)
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

        public IEnumerable<PROCESS_N1_VIEW> GetProcess1(int processId, int startIndex, int count, string sorting)
        {
            //Entidades
            var entities = this.GetAll().Where(d => d.PROC_N0_ID.Equals(processId));
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
        public int GetProcess1Count(string name)
        {
            var entities = this.GetAll();
            //Filters
            entities = this.SearchInfo(entities, name);
            return entities.Count();
        }

        public int GetProcess1Count(int processId)
        {
            //Entidades
            var entities = this.GetAll().Where(d => d.PROC_N0_ID.Equals(processId));
            return entities.Count();
        }

        #endregion Metodos jTable

        #region Busqueda y ordenamiento
        private IEnumerable<PROCESS_N1_VIEW> SearchInfo(IEnumerable<PROCESS_N1_VIEW> entities, string name)
        {
            var dataSource = entities;
            IEnumerable<PROCESS_N1_VIEW> searchResult = null;
            Func<PROCESS_N1_VIEW, bool> filterCriteria = p => true;
            var filterHelper = new FilterHelper<PROCESS_N1_VIEW>();
            //Nombre
            if (!string.IsNullOrEmpty(name))
            {
                filterCriteria = filterHelper.AddFilterExpression(filterCriteria, p => p.PROC_N1_NAME.ToUpper(CultureInfo.InvariantCulture)
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
        private IEnumerable<PROCESS_N1_VIEW> Sorting(string sortExpression, IEnumerable<PROCESS_N1_VIEW> entities)
        {
            if (!string.IsNullOrEmpty(sortExpression))
            {
                string[] sortProperties = sortExpression.Split(' ');
                string sortColumn = sortProperties[0];
                string sortDirection = sortProperties[1];
                IEnumerable<PROCESS_N1_VIEW> sortedData = null;
                if (entities != null)
                {
                    sortedData = SortingHelper<PROCESS_N1_VIEW>.SortBy(entities, sortColumn, sortDirection);
                }
                return sortedData;
            }
            return entities;
        }

        #endregion Busqueda y ordenamiento

        public IEnumerable<SelectListItem> GetProcess1Items()
        {
            List<SelectListItem> processList = new List<SelectListItem>();
            try
            {
                var process = this.GetAll()
                    .Select(item => new SelectListItem(item.PROC_N1_ID.ToString(), item.PROC_N1_NAME));
                processList = process.ToList();
            }
            catch
            {
                processList = new List<SelectListItem>();
            }
            return processList;
        }

        public IEnumerable<SelectListItem> GetProcess1Items(int processId)
        {
            List<SelectListItem> processList = new List<SelectListItem>();
            try
            {
                var process = this.GetAll().Where(p => p.PROC_N0_ID.Equals(processId))
                    .Select(item => new SelectListItem(item.PROC_N1_ID.ToString(), item.PROC_N1_NAME));
                processList = process.ToList();
            }
            catch
            {
                processList = new List<SelectListItem>();
            }
            return processList;
        }
    }
}