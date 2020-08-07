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
    public class UserRepository : IRepository<USERS_VIEW>
    {
        private DataContext DataContext;

        public UserRepository(DataContext dataContext)
        {
            this.DataContext = dataContext;
        }

        public USERS_VIEW GetLogedUser(string userName, string password)
        {
            string message = this.AuthenticateUser(userName, password);

            if (message == string.Empty)
            {
                return this.GetByNick(userName);
            }
            else
            {
                return null;
            }
        }

        public string AuthenticateUser(string userName, string password)
        {
            string resultMessage = string.Empty;
            var users = this.GetAll();
            try
            {
                var user = users.FirstOrDefault(e => e.USR_NICK.Equals(userName, StringComparison.InvariantCultureIgnoreCase) &&
                               e.USR_PASS.Equals(password, StringComparison.InvariantCultureIgnoreCase));

                if (user == null)
                {
                    resultMessage = "usuario no existe en el sistema";
                }
                return resultMessage;

            }
            catch
            {
                resultMessage = "usuario no existe en el sistema";

                return resultMessage;
            }

        }

        public USERS_VIEW GetByNick(string nick)
        {
            USERS_VIEW user = null;
            try
            {
                var users = this.GetAll();
                if (users != null)
                {
                    user = users.FirstOrDefault(d => d.USR_NICK.Equals(nick));
                }
            }
            catch
            {
                user = null;
            }
            return user;
        }

        #region IRepository

        public IEnumerable<USERS_VIEW> GetAll()
        {
            return this.DataContext.spGetUser();
        }

        public USERS_VIEW GetById(int id)
        {
            USERS_VIEW user = null;
            try
            {
                var users = this.GetAll();
                if (users != null)
                {
                    user = users.FirstOrDefault(d => d.USR_ID.Equals(id));
                }
            }
            catch
            {
                user = null;
            }
            return user;
        }

        public string Insert(USERS_VIEW entity)
        {
            return this.DataContext.spCreateUser(entity);
        }

        public string Update(USERS_VIEW entity)
        {
            return this.DataContext.spUpdateUser(entity);
        }

        public string Delete(int entityId)
        {
            return this.DataContext.spDeleteUser(entityId);
        }


        #endregion

        #region jTable

        /// <summary>
        /// Obtener datos
        /// </summary>
        /// <param name="name">Nombre</param>
        /// <param name="name">Documento</param>
        /// <param name="description">Descripcion</param>
        /// <param name="startIndex">Indice inicial</param>
        /// <param name="count">total de registros</param>
        /// <param name="sorting">ordenamiento</param>
        /// <returns></returns>
        public IEnumerable<USERS_VIEW> GetUsers(string name, string document, int startIndex, int count, string sorting)
        {
            var user = this.GetAll();
            //Filters
            user = this.SearchInfo(user, name, document);
            //Sorting
            user = this.Sorting(sorting, user);
            return count > 0
                       ? user.Skip(startIndex).Take(count).ToList() //Paging
                       : user.ToList(); //No paging
        }

        /// <summary>
        /// Numero de todos los datos disponibles
        /// </summary>
        /// <returns></returns>
        public int GetUsersCount(string name, string document)
        {
            var user = this.GetAll();
            //Filters
            user = this.SearchInfo(user, name, document);
            return user.Count();
        }




        #endregion jTable



        #region Busqueda y ordenamiento
        /// <summary>
        /// Busqueda de Datos
        /// </summary>
        /// <param name="users">entidad</param>
        /// <param name="name">nombre usuario</param>
        /// <param name="document">documento usuario</param>
        /// <returns></returns>
        private IEnumerable<USERS_VIEW> SearchInfo(IEnumerable<USERS_VIEW> users, string name, string document)
        {
            var dataSource = users;
            IEnumerable<USERS_VIEW> searchResult = null;
            Func<USERS_VIEW, bool> filterCriteria = p => true;
            var filterHelper = new AlbatrosSoft.Common.FilterHelper<USERS_VIEW>();
            //Nombre
            if (!string.IsNullOrEmpty(name))
            {
                filterCriteria = filterHelper.AddFilterExpression(filterCriteria, p => p.USR_NAME.ToUpper(CultureInfo.InvariantCulture)
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
        private IEnumerable<USERS_VIEW> Sorting(string sortExpression, IEnumerable<USERS_VIEW> user)
        {
            if (!string.IsNullOrEmpty(sortExpression))
            {
                string[] sortProperties = sortExpression.Split(' ');
                string sortColumn = sortProperties[0];
                string sortDirection = sortProperties[1];
                IEnumerable<USERS_VIEW> sortedData = null;
                if (user != null)
                {
                    sortedData = SortingHelper<USERS_VIEW>.SortBy(user, sortColumn, sortDirection);
                }
                return sortedData;
            }
            return user;
        }

        #endregion Busqueda y ordenamiento
    }
}