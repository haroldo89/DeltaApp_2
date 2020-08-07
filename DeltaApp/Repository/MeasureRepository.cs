using DeltaApp.DAL;
using DeltaApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DeltaApp.Repository
{
    public class MeasureRepository : IRepository<MEASURE_VIEW>
    {

        private DataContext DataContext;

        public MeasureRepository ()
        {
            this.DataContext = new DataContext();
        }

        public MeasureRepository (DataContext dataContext)
        {
            this.DataContext = dataContext;
        }



        public string Delete(int entityId)
        {

           return  this.DataContext.spDeleteMeasure(entityId);
        }

        public IEnumerable<MEASURE_VIEW> GetAll()
        {
            return this.DataContext.spGetMeasures();
        }


        public IEnumerable<SelectListItem> GetMeasureCodes(int pdtID)
        {
            List<SelectListItem> measureCodesList = new List<SelectListItem>();
            try
            {
               var codes = this.GetAll().Where(p => p.PDT_ID.Equals(pdtID)).OrderBy(p => p.PDT_RAST_CODE);
               
                foreach (var item in codes)
                {
                    measureCodesList.Add(new SelectListItem(item.PDT_RAST_CODE.ToString(), item.PDT_RAST_CODE));
                }
            }
            catch
            {
                measureCodesList = new List<SelectListItem>();
            }
            return measureCodesList;
        }

        public MEASURE_VIEW GetById(int id)
        {
            return this.GetAll().FirstOrDefault(m => m.MSR_ID.Equals(id));
        }

        public MEASURE_VIEW GetPertinencesById(int id)
        {
            return this.GetAll().FirstOrDefault(m => m.MSR_ID.Equals(id));
        }

        public IEnumerable <PERTINENCES_BY_MEASURE_VIEW>GetPertinencesbyCode (string code)
        {
            return this.DataContext.spGetPertinencesbyCode(code);
        }

        public IEnumerable<MEASURE_PERTINENCES_VIEW> GetMeasurePertinences(string code, string pdtID)
        {
            return this.DataContext.spGetMeasurePertinences().Where(p=> p.PDT_RAST_CODE.Equals(code) && p.PDT_ID.Equals(Convert.ToInt32(pdtID)));
        }

        public MEASURE_VIEW GetByProductId(int pid)
        {
            return this.GetAll().FirstOrDefault(m => m.PDT_RAST_CODE.Equals(pid));
        }

        public MEASURE_VIEW GetByRastCode(int code, int pdtID)
        {
            //return GetAll().FirstOrDefault();
           IEnumerable<MEASURE_VIEW> query = this.GetAll();
              
            return query.FirstOrDefault(m => m.PDT_RAST_CODE.Equals(code.ToString()) && m.PDT_ID.Equals(pdtID));
        }

        public string Insert(MEASURE_VIEW entity)
        {
            throw new NotImplementedException();
        }

        public string Insert(MEASURE_VIEW entity, bool isMsrOk, string checkList)
        {
            return DataContext.spCreateMeasure(entity, isMsrOk, checkList);
        }

        public string Insert( int PDT_ID, string PDT_SIGLA, int  PDT_RAST_CODE, int USR_ID, int AREA_ID, int? DIV_N1_ID,
                                         int? DIV_N2_ID, int? DIV_N3_ID, bool? PDT_DELIVERY_OPT,  int? MSR_DAYS, int? MSR_HOUR,
                                        int? MSR_MINUTES,bool? isMsrOk,int pertOK ,string checkList)
        {
            MEASURE_VIEW entity = this.SetProductProperties(PDT_ID, PDT_SIGLA, PDT_RAST_CODE, USR_ID, AREA_ID, DIV_N1_ID, DIV_N2_ID,
                DIV_N3_ID, PDT_DELIVERY_OPT, MSR_DAYS, MSR_HOUR, MSR_MINUTES, isMsrOk,pertOK);

            return DataContext.spCreateMeasure(entity, isMsrOk,checkList);
        }

        public string Update(MEASURE_VIEW entity)
        {
            throw new NotImplementedException();
        }

        private MEASURE_VIEW SetProductProperties(  int pdt_ID, string pdtSigla, int pdtCode, int usrID, int areaID, 
                                                    int? divN1ID, int? divN2ID, int? divN3ID,bool? delTimely,
                                                    int? days, int? hours, int? minutes, bool? isMsrOK, int? pertOK)
        {
            return new MEASURE_VIEW
            {
                PDT_ID = pdt_ID,
                PDT_SIGLA = pdtSigla,
                PDT_RAST_CODE = pdtCode.ToString(),
                USR_ID = usrID,
                AREA_ID = areaID,
                DIV_N1_ID = divN1ID,
                DIV_N2_ID = divN2ID,
                DIV_N3_ID = divN3ID,
                PDT_DELIVERY_OPT = delTimely,
                MSR_DAYS = days,
                MSR_HOUR = hours,
                MSR_MINUTES = minutes,
                MSR_OK = isMsrOK,
                MSR_PERTINENCES_OK = pertOK

               
            };
        }
    }
}