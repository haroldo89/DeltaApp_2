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
    public class DivisionN3Repository : IRepository<DIVISION_N3_VIEW>
    {
        private DataContext DataContext;

        public DivisionN3Repository()
        {
            this.DataContext = new DataContext();
        }

        public DivisionN3Repository(DataContext dataContext)
        {
            this.DataContext = dataContext;
        }

        public string Delete(int entityId)
        {
            return this.DataContext.spDeleteDivisionN3(entityId);
        }

        public IEnumerable<DIVISION_N3_VIEW> GetAll()
        {
            return this.DataContext.spGetDivisionN3();
        }

        public DIVISION_N3_VIEW GetById(int id)
        {
            return this.GetAll().FirstOrDefault(a => a.DIV_N3_ID.Equals(id));
        }

        public string Insert(DIVISION_N3_VIEW entity)
        {
            return this.DataContext.spCreateDivisionN3(entity);
        }

        public string Update(DIVISION_N3_VIEW entity)
        {
            return this.DataContext.spUpdateDivisionN3(entity);
        }

        public IEnumerable<SelectListItem> GeDivisionN3Items(int divisionN2Id)
        {
            List<SelectListItem> DivisionsList = new List<SelectListItem>();
            try
            {
                var DivisionsN1 = this.GetAll().Where(d => d.DIV_N2_ID.Equals(divisionN2Id));
                foreach (var item in DivisionsN1)
                {
                    DivisionsList.Add(new SelectListItem(item.DIV_N3_NAME.ToString(), item.DIV_N3_NAME));
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
        public IEnumerable<DIVISION_N3_VIEW> GetDivision3s(string name, int startIndex, int count, string sorting)
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
        public int GetDivisions3Count(string name)
        {
            var entities = this.GetAll();
            //Filters
            entities = this.SearchInfo(entities, name);
            return entities.Count();
        }

        /// <summary>
        /// Obtener datos
        /// </summary>
        /// <param name="divisionN2Id">Nombre</param>
        /// <param name="description">Descripcion</param>
        /// <param name="startIndex">Indice inicial</param>
        /// <param name="count">total de registros</param>
        /// <param name="sorting">ordenamiento</param>
        /// <returns></returns>
        public IEnumerable<DIVISION_N3_VIEW> GetDivision3s(int divisionN2Id, int startIndex, int count, string sorting)
        {
            var entities = this.GetAll().Where(d => d.DIV_N2_ID.Equals(divisionN2Id));
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
        public int GetDivisions3Count(int divisionN2Id)
        {
            var entities = this.GetAll().Where(d => d.DIV_N2_ID.Equals(divisionN2Id));
            return entities.Count();
        }

        #endregion Metodos jTable

        #region Busqueda y ordenamiento
        private IEnumerable<DIVISION_N3_VIEW> SearchInfo(IEnumerable<DIVISION_N3_VIEW> entities, string name)
        {
            var dataSource = entities;
            IEnumerable<DIVISION_N3_VIEW> searchResult = null;
            Func<DIVISION_N3_VIEW, bool> filterCriteria = p => true;
            var filterHelper = new FilterHelper<DIVISION_N3_VIEW>();
            //Nombre
            if (!string.IsNullOrEmpty(name))
            {
                filterCriteria = filterHelper.AddFilterExpression(filterCriteria, p => p.DIV_N3_NAME.ToUpper(CultureInfo.InvariantCulture)
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
        private IEnumerable<DIVISION_N3_VIEW> Sorting(string sortExpression, IEnumerable<DIVISION_N3_VIEW> entities)
        {
            if (!string.IsNullOrEmpty(sortExpression))
            {
                string[] sortProperties = sortExpression.Split(' ');
                string sortColumn = sortProperties[0];
                string sortDirection = sortProperties[1];
                IEnumerable<DIVISION_N3_VIEW> sortedData = null;
                if (entities != null)
                {
                    sortedData = SortingHelper<DIVISION_N3_VIEW>.SortBy(entities, sortColumn, sortDirection);
                }
                return sortedData;
            }
            return entities;
        }

        #endregion Busqueda y ordenamiento
    }
}