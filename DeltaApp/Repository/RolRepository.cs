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
    public class RolRepository : IRepository<ROL_VIEW>
    {
        private DataContext DataContext;

        public RolRepository()
        {
            this.DataContext = new DataContext();
        }

        public RolRepository(DataContext dataContext)
        {
            this.DataContext = dataContext;
        }

        public IEnumerable<ROL_VIEW> GetAll()
        {
            return this.DataContext.spGetRols().ToList();
        }

        public ROL_VIEW GetById(int id)
        {
            return this.GetAll().FirstOrDefault(r => r.ROL_ID.Equals(id));
        }

        public string Insert(ROL_VIEW entity)
        {
            return this.DataContext.spCreateRol(entity);
        }

        public string Update(ROL_VIEW entity)
        {
            return this.DataContext.spUpdateRol(entity);
        }

        public string Delete(int entityId)
        {
            return this.DataContext.spDeleteRol(entityId);
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
        public IEnumerable<ROL_VIEW> GetRoles(string name, int startIndex, int count, string sorting)
        {
            var rols = this.GetAll();
            //Filters
            rols = this.SearchInfo(rols, name);
            //Sorting
            rols = this.Sorting(sorting, rols);
            return count > 0
                       ? rols.Skip(startIndex).Take(count).ToList() //Paging
                       : rols.ToList(); //No paging
        }

        /// <summary>
        /// Numero de todos los datos disponibles
        /// </summary>
        /// <returns></returns>
        public int GetAreasCount(string name)
        {
            var rols = this.GetAll();
            //Filters
            rols = this.SearchInfo(rols, name);
            return rols.Count();
        }

        #endregion Metodos jTable

        #region Busqueda y ordenamiento
        private IEnumerable<ROL_VIEW> SearchInfo(IEnumerable<ROL_VIEW> rols, string name)
        {
            var dataSource = rols;
            IEnumerable<ROL_VIEW> searchResult = null;
            Func<ROL_VIEW, bool> filterCriteria = p => true;
            var filterHelper = new FilterHelper<ROL_VIEW>();
            //Nombre
            if (!string.IsNullOrEmpty(name))
            {
                filterCriteria = filterHelper.AddFilterExpression(filterCriteria, p => p.ROL_NAME.ToUpper(CultureInfo.InvariantCulture)
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
        /// <param name="rols">Lista a ordenar</param>
        /// <returns></returns>      
        private IEnumerable<ROL_VIEW> Sorting(string sortExpression, IEnumerable<ROL_VIEW> rols)
        {
            if (!string.IsNullOrEmpty(sortExpression))
            {
                string[] sortProperties = sortExpression.Split(' ');
                string sortColumn = sortProperties[0];
                string sortDirection = sortProperties[1];
                IEnumerable<ROL_VIEW> sortedData = null;
                if (rols != null)
                {
                    sortedData = SortingHelper<ROL_VIEW>.SortBy(rols, sortColumn, sortDirection);
                }
                return sortedData;
            }
            return rols;
        }



        #endregion Busqueda y ordenamiento
    }
}