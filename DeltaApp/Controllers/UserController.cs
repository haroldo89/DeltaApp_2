using DeltaApp.Models;
using DeltaApp.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DeltaApp.Controllers
{
    public class UserController : BaseController
    {
        UserRepository UserRepository = new UserRepository(new DAL.DataContext());

        // GET: User
        public ActionResult Index()
        {
            return View();
        }


        #region jTable
        /// <summary>
        /// Obtener usuarios.
        /// </summary>
        /// <param name="name">Nombre de usuario</param>
        /// <param name="jtStartIndex"></param>
        /// <param name="jtPageSize"></param>
        /// <param name="jtSorting"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult GetUser(string name = "", string document = "", int jtStartIndex = 0, int jtPageSize = 0, string jtSorting = null)
        {
            ActionResult result = null;
            try
            {
                //Lista de usuario con filtro
                var users = this.UserRepository.GetUsers(name,document, jtStartIndex, jtPageSize, jtSorting);
                //Conteo de usuario con filtros
                var usersCount = this.UserRepository.GetUsersCount(name,document);
                //Resultado para contPertinence de jtable.
                result = Json(new { Result = "OK", Records = users.ToList(), TotalRecordCount = usersCount }, JsonRequestBehavior.AllowGet);
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
        /// <param name="userInfo">Informacion de usuario</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult CreateUser(USERS_VIEW userInfo)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                if (!this.ModelState.IsValid)
                {
                    throw new Exception("Form is not valid! Please correct it and try again.");
                }
                resultMessage = this.UserRepository.Insert(userInfo);
                if (string.IsNullOrEmpty(resultMessage))
                {
                    result = this.Json(new { Result = "OK", Record = userInfo }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    result = this.Json(new { Result = "ERROR", Message = resultMessage }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                string message = ex.InnerException.ToString();
                message = message + "";
                result = this.Json(new { Result = "ERROR", Message = ex.InnerException.ToString() }, JsonRequestBehavior.AllowGet);
            }
            return result;
        }

        /// <summary>
        /// Actualizar tipo de servicio
        /// </summary>
        /// <param name="userInfo">Informacion de tipo de servicio</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult UpdateUser (USERS_VIEW userInfo)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                if (!this.ModelState.IsValid)
                {
                    throw new Exception("Form is not valid! Please correct it and try again.");
                }
                resultMessage = this.UserRepository.Update(userInfo);
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
        /// <param name="USR_ID">Id de Pertinence de usuario</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult DeleteUser(int USR_ID)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                resultMessage = this.UserRepository.Delete(USR_ID);
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
        #endregion

    }
}