using DeltaApp.DAL;
using DeltaApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DeltaApp.Repository
{
    public class GoalConfiabilityRepository : IRepository<GOAL_CONFIABILITY_INDEX>
    {

        protected DataContext DataContext { get; private set; }

        public GoalConfiabilityRepository()
        {
            this.DataContext = new DataContext();
        }

        public GoalConfiabilityRepository(DataContext dataContext)
        {
            this.DataContext = dataContext;
        }

        public string Delete(int entityId)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<GOAL_CONFIABILITY_INDEX> GetAll()
        {
            return this.DataContext.GoalConfiability.ToList();
        }

        public GOAL_CONFIABILITY_INDEX GetById(int id)
        {
            throw new NotImplementedException();
        }

        public string Insert(GOAL_CONFIABILITY_INDEX entity)
        {
            throw new NotImplementedException();
        }

        public string Update(GOAL_CONFIABILITY_INDEX entity)
        {
            throw new NotImplementedException();
        }
    }
}