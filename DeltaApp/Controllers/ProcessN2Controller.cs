using DeltaApp.DAL;
using DeltaApp.Models;
using DeltaApp.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
namespace DeltaApp.Controllers
{
    public class ProcessN2Controller : BaseController
    {
        Process1Repository Process1Repository = new Process1Repository();
        Process2Repository Process2Repository = new Process2Repository();

        // GET: Process
        public ActionResult Index()
        {
            return View();
        }

        #region Metodos jTable
        /// <summary>
        /// Obtener usuarios.
        /// </summary>
        /// <param name="name">Nombre de usuario</param>
        /// <param name="jtStartIndex"></param>
        /// <param name="jtPageSize"></param>
        /// <param name="jtSorting"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult GetProcess2(string name = "", int jtStartIndex = 0, int jtPageSize = 0, string jtSorting = null)
        {
            ActionResult result = null;
            try
            {
                //Lista de usuario con filtro
                var entities = this.Process2Repository.GetProcess2(name, jtStartIndex, jtPageSize, jtSorting);
                //Conteo de usuario con filtros
                var entitiesCount = this.Process2Repository.GetProcess2Count(name);
                //Resultado para contArea de jtable.
                result = Json(new { Result = "OK", Records = entities.ToList(), TotalRecordCount = entitiesCount }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                result = Json(new { Result = "ERROR", Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
            return result;
        }

        /// <summary>
        /// Obtener usuarios.
        /// </summary>
        /// <param name="processId1">Nombre de usuario</param>
        /// <param name="jtStartIndex"></param>
        /// <param name="jtPageSize"></param>
        /// <param name="jtSorting"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult GetProcess2ByProcess1(int processId1 = 0, int jtStartIndex = 0, int jtPageSize = 0, string jtSorting = null)
        {
            ActionResult result = null;
            try
            {
                //Lista de usuario con filtro
                var entities = this.Process2Repository.GetProcess2(processId1, jtStartIndex, jtPageSize, jtSorting);
                //Conteo de usuario con filtros
                var entitiesCount = this.Process2Repository.GetProcess2Count(processId1);
                //Resultado para contArea de jtable.
                result = Json(new { Result = "OK", Records = entities.ToList(), TotalRecordCount = entitiesCount }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                result = Json(new { Result = "ERROR", Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
            return result;
        }

        /// <summary>
        /// Crear nuevo tipo de servicio.
        /// </summary>
        /// <param name="entity">Informacion de usuario</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult CreateProcess2(PROCESS_N2_VIEW entity)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                if (!this.ModelState.IsValid)
                {
                    throw new Exception("Form is not valid! Please correct it and try again.");
                }
                resultMessage = this.Process2Repository.Insert(entity);
                if (string.IsNullOrEmpty(resultMessage))
                {
                    result = this.Json(new { Result = "OK", Record = entity }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    result = this.Json(new { Result = "ERROR", Message = resultMessage }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                result = this.Json(new { Result = "ERROR", Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
            return result;
        }

        /// <summary>
        /// Actualizar tipo de servicio
        /// </summary>
        /// <param name="entity">Informacion de tipo de servicio</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult UpdateProcess2(PROCESS_N2_VIEW entity)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                if (!this.ModelState.IsValid)
                {
                    throw new Exception("Form is not valid! Please correct it and try again.");
                }
                resultMessage = this.Process2Repository.Update(entity);
                if (string.IsNullOrEmpty(resultMessage))
                {
                    result = Json(new { Result = "OK" }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    result = Json(new { Result = "ERROR", Message = resultMessage }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                result = Json(new { Result = "ERROR", Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
            return result;
        }

        /// <summary>
        /// Eliminar Area de usuario
        /// </summary>
        /// <param name="PROC_N2_ID">Id de Area de usuario</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult DeleteProcess2(int PROC_N2_ID)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                resultMessage = this.Process2Repository.Delete(PROC_N2_ID);
                if (string.IsNullOrEmpty(resultMessage))
                {
                    result = this.Json(new { Result = "OK" }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    result = this.Json(new { Result = "ERROR", Message = resultMessage }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                result = this.Json(new { Result = "ERROR", Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
            return result;
        }

        [HttpPost]
        public ActionResult GetProcess1Options()
        {
            try
            {
                var entities = this.Process1Repository.GetAll()
                    .Select(c => new { DisplayText = c.PROC_N1_NAME, Value = c.PROC_N1_ID });
                return this.Json(new { Result = "OK", Options = entities });
            }
            catch (Exception ex)
            {
                return this.Json(new { Result = "ERROR", Message = ex.Message });
            }
        }
        #endregion Metodos jTable
    }
}