using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DeltaApp.Repository
{
    public interface IRepository<T> where T : new()
    {
        IEnumerable<T> GetAll();
        T GetById(int id);
        string Insert(T entity);
        string Update(T entity);
        string Delete(int entityId);
    }
}