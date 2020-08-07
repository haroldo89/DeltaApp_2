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
    public class PertinenceController : BaseController
    {
        PertinenceRepository PertinenceRepository = new PertinenceRepository(new DataContext());

        // GET: Pertinence
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
        public ActionResult GetPertinences(string name = "", int jtStartIndex = 0, int jtPageSize = 0, string jtSorting = null)
        {
            ActionResult result = null;
            try
            {
                //Lista de usuario con filtro
                var pertinencences = this.PertinenceRepository.GetPertinences(name, jtStartIndex, jtPageSize, jtSorting);
                //Conteo de usuario con filtros
                var pertinenceCount = this.PertinenceRepository.GetPertinencesCount(name);
                //Resultado para contPertinence de jtable.
                result = Json(new { Result = "OK", Records = pertinencences.ToList(), TotalRecordCount = pertinenceCount }, JsonRequestBehavior.AllowGet);
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
        /// <param name="pertinenceInfo">Informacion de usuario</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult CreatePertinence(PERTINENCES_VIEW pertinenceInfo)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                if (!this.ModelState.IsValid)
                {
                    throw new Exception("Form is not valid! Please correct it and try again.");
                }
                resultMessage = this.PertinenceRepository.Insert(pertinenceInfo);
                if (string.IsNullOrEmpty(resultMessage))
                {
                    result = this.Json(new { Result = "OK", Record = pertinenceInfo }, JsonRequestBehavior.AllowGet);
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
        /// <param name="pertinenceInfo">Informacion de tipo de servicio</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult UpdatePertinence(PERTINENCES_VIEW pertinenceInfo)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                if (!this.ModelState.IsValid)
                {
                    throw new Exception("Form is not valid! Please correct it and try again.");
                }
                resultMessage = this.PertinenceRepository.Update(pertinenceInfo);
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
        /// Eliminar Pertinence de usuario
        /// </summary>
        /// <param name="PERT_ID">Id de Pertinence de usuario</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult DeletePertinence(int PERT_ID)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                resultMessage = this.PertinenceRepository.Delete(PERT_ID);
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
        #endregion Metodos jTable
    }
}