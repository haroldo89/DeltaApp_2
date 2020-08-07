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
    public class PertinenceRepository : IRepository<PERTINENCES_VIEW>
    {

        DataContext DataContext;

        public PertinenceRepository(DataContext dataContext)
        {
            this.DataContext = dataContext;
        }

        #region IRepository
        public string Delete(int entityId)
        {
            return this.DataContext.spDeletePertinence(entityId);
        }

        public IEnumerable<PERTINENCES_VIEW> GetAll()
        {
            return this.DataContext.spGetPertinences();
        }

        public PERTINENCES_VIEW GetById(int id)
        {
            return this.GetAll().FirstOrDefault(p => p.PERT_ID.Equals(id));
        }

        public string Insert(PERTINENCES_VIEW entity)
        {
            return this.DataContext.spCreatePertinence(entity);
        }

        public string Update(PERTINENCES_VIEW entity)
        {
            return this.DataContext.spUpdatePertinence(entity);
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
        public IEnumerable<PERTINENCES_VIEW> GetPertinences(string name, int startIndex, int count, string sorting)
        {
            var pertinences = this.GetAll();
            //Filters
            pertinences = this.SearchInfo(pertinences, name);
            //Sorting
            pertinences = this.Sorting(sorting, pertinences);
            return count > 0
                       ? pertinences.Skip(startIndex).Take(count).ToList() //Paging
                       : pertinences.ToList(); //No paging
        }

        /// <summary>
        /// Numero de todos los datos disponibles
        /// </summary>
        /// <returns></returns>
        public int GetPertinencesCount(string name)
        {
            var pertinences = this.GetAll();
            //Filters
            pertinences = this.SearchInfo(pertinences, name);
            return pertinences.Count();
        }

        #endregion Metodos jTable

        #region Busqueda y ordenamiento
        private IEnumerable<PERTINENCES_VIEW> SearchInfo(IEnumerable<PERTINENCES_VIEW> pertinences, string name)
        {
            var dataSource = pertinences;
            IEnumerable<PERTINENCES_VIEW> searchResult = null;
            Func<PERTINENCES_VIEW, bool> filterCriteria = p => true;
            var filterHelper = new FilterHelper<PERTINENCES_VIEW>();
            //Nombre
            if (!string.IsNullOrEmpty(name))
            {
                filterCriteria = filterHelper.AddFilterExpression(filterCriteria, p => p.PERT_DETAIL.ToUpper(CultureInfo.InvariantCulture)
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
        /// <param name="pertinences">Lista a ordenar</param>
        /// <returns></returns>      
        private IEnumerable<PERTINENCES_VIEW> Sorting(string sortExpression, IEnumerable<PERTINENCES_VIEW> pertinences)
        {
            if (!string.IsNullOrEmpty(sortExpression))
            {
                string[] sortProperties = sortExpression.Split(' ');
                string sortColumn = sortProperties[0];
                string sortDirection = sortProperties[1];
                IEnumerable<PERTINENCES_VIEW> sortedData = null;
                if (pertinences != null)
                {
                    sortedData = SortingHelper<PERTINENCES_VIEW>.SortBy(pertinences, sortColumn, sortDirection);
                }
                return sortedData;
            }
            return pertinences;
        }

        #endregion Busqueda y ordenamiento
    }
}