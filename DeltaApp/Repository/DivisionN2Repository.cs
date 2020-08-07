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
    public class DivisionN2Repository : IRepository<DIVISION_N2_VIEW>
    {
        private DataContext DataContext;

        public DivisionN2Repository()
        {
            this.DataContext = new DataContext();
        }

        public DivisionN2Repository(DataContext dataContext)
        {
            this.DataContext = dataContext;
        }

        public string Delete(int entityId)
        {
            return this.DataContext.spDeleteDivisionN2(entityId);
        }

        public IEnumerable<DIVISION_N2_VIEW> GetAll()
        {
            return this.DataContext.spGetDivisionN2();
        }

        public DIVISION_N2_VIEW GetById(int id)
        {
            return this.GetAll().FirstOrDefault(a => a.DIV_N2_ID.Equals(id));
        }

        public string Insert(DIVISION_N2_VIEW entity)
        {
            return this.DataContext.spCreateDivisionN2(entity);
        }

        public string Update(DIVISION_N2_VIEW entity)
        {
            return this.DataContext.spUpdateDivisionN2(entity);
        }

        public IEnumerable<SelectListItem> GeDivisionN2Items(int DivisionN1)
        {
            List<SelectListItem> DivisionsList = new List<SelectListItem>();
            try
            {
                var DivisionsN2 = this.GetAll().Where(d => d.DIV_N1_ID.Equals(DivisionN1));
                foreach (var item in DivisionsN2)
                {
                    DivisionsList.Add(new SelectListItem(item.DIV_N2_ID.ToString(), item.DIV_N2_NAME));
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
        public IEnumerable<DIVISION_N2_VIEW> GetDivisions2(string name, int startIndex, int count, string sorting)
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

        /// <summary>
        /// Numero de todos los datos disponibles
        /// </summary>
        /// <returns></returns>
        public int GetDivisions2Count(string name)
        {
            var entities = this.GetAll();
            //Filters
            entities = this.SearchInfo(entities, name);
            return entities.Count();
        }

        /// <summary>
        /// Obtener datos
        /// </summary>
        /// <param name="divisionN1Id">Nombre</param>
        /// <param name="description">Descripcion</param>
        /// <param name="startIndex">Indice inicial</param>
        /// <param name="count">total de registros</param>
        /// <param name="sorting">ordenamiento</param>
        /// <returns></returns>
        public IEnumerable<DIVISION_N2_VIEW> GetDivisions2(int divisionN1Id, int startIndex, int count, string sorting)
        {
            var entities = this.GetAll().Where(d => d.DIV_N1_ID.Equals(divisionN1Id));
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
        public int GetDivisions2Count(int divisionN1Id)
        {
            var entities = this.GetAll().Where(d => d.DIV_N1_ID.Equals(divisionN1Id));
            return entities.Count();
        }

        #endregion Metodos jTable

        #region Busqueda y ordenamiento
        private IEnumerable<DIVISION_N2_VIEW> SearchInfo(IEnumerable<DIVISION_N2_VIEW> entities, string name)
        {
            var dataSource = entities;
            IEnumerable<DIVISION_N2_VIEW> searchResult = null;
            Func<DIVISION_N2_VIEW, bool> filterCriteria = p => true;
            var filterHelper = new FilterHelper<DIVISION_N2_VIEW>();
            //Nombre
            if (!string.IsNullOrEmpty(name))
            {
                filterCriteria = filterHelper.AddFilterExpression(filterCriteria, p => p.DIV_N2_NAME.ToUpper(CultureInfo.InvariantCulture)
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
        private IEnumerable<DIVISION_N2_VIEW> Sorting(string sortExpression, IEnumerable<DIVISION_N2_VIEW> entities)
        {
            if (!string.IsNullOrEmpty(sortExpression))
            {
                string[] sortProperties = sortExpression.Split(' ');
                string sortColumn = sortProperties[0];
                string sortDirection = sortProperties[1];
                IEnumerable<DIVISION_N2_VIEW> sortedData = null;
                if (entities != null)
                {
                    sortedData = SortingHelper<DIVISION_N2_VIEW>.SortBy(entities, sortColumn, sortDirection);
                }
                return sortedData;
            }
            return entities;
        }

        #endregion Busqueda y ordenamiento
    }
}