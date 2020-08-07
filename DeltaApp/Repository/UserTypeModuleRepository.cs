using DeltaApp.DAL;
using DeltaApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DeltaApp.Repository
{
    public class UserTypeModuleRepository : IRepository<USER_TYPE_MODULES>
    {
        private DataContext DataContext;

        public UserTypeModuleRepository()
        {
            this.DataContext = new DataContext();
        }

        public UserTypeModuleRepository(DataContext dataContext)
        {
            this.DataContext = dataContext;
        }

        public string Delete(int entityId)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<USER_TYPE_MODULES> GetAll()
        {
            throw new NotImplementedException();
        }

        public IEnumerable<USER_TYPE_MODULES> GetUserTypeModule(int userTypeId)
        {
            return this.DataContext.spGetUserTypeModules(userTypeId).ToList();
        }

        public IEnumerable<UserTypeModulePermission> GetUserPermission(int userTypeId)
        {
            return this.GetUserTypeModule(userTypeId)
                .Select(u => new UserTypeModulePermission(u)).ToList();
        }


        public USER_TYPE_MODULES GetById(int id)
        {
            throw new NotImplementedException();
        }

        public string Insert(USER_TYPE_MODULES entity)
        {
            throw new NotImplementedException();
        }

        public string Update(USER_TYPE_MODULES entity)
        {
            throw new NotImplementedException();
        }
    }
}