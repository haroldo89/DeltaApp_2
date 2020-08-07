using DeltaApp.DAL;
using DeltaApp.Models;
using DeltaApp.Repository;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DeltaApp.Controllers
{
    public class RolController : BaseController
    {
        private const string DEFAULT_ITEM_VALUE = "0";

        /// <summary>
        /// Repositorio de Rol de usuario
        /// </summary>
        RolRepository RolRepository = new RolRepository();
        /// <summary>
        /// Repositorio de Producto.
        /// </summary>
        ProductRepository ProductRepository = new ProductRepository();

        // GET: Rol
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
        public ActionResult GetRols(string name = "", int jtStartIndex = 0, int jtPageSize = 0, string jtSorting = null)
        {
            ActionResult result = null;
            try
            {
                //Lista de usuario con filtro
                var rols = this.RolRepository.GetRoles(name, jtStartIndex, jtPageSize, jtSorting);
                //Conteo de usuario con filtros
                var rolCount = this.RolRepository.GetAreasCount(name);
                //Resultado para control de jtable.
                result = Json(new { Result = "OK", Records = rols.ToList(), TotalRecordCount = rolCount }, JsonRequestBehavior.AllowGet);
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
        /// <param name="rolInfo">Informacion de usuario</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult CreateRol(ROL_VIEW rolInfo)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                if (!this.ModelState.IsValid)
                {
                    throw new Exception("Form is not valid! Please correct it and try again.");
                }
                resultMessage = this.RolRepository.Insert(rolInfo);
                if (string.IsNullOrEmpty(resultMessage))
                {
                    result = this.Json(new { Result = "OK", Record = rolInfo }, JsonRequestBehavior.AllowGet);
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
        /// <param name="rolInfo">Informacion de tipo de servicio</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult UpdateRol(ROL_VIEW rolInfo)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                if (!this.ModelState.IsValid)
                {
                    throw new Exception("Form is not valid! Please correct it and try again.");
                }
                resultMessage = this.RolRepository.Update(rolInfo);
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
        /// Eliminar rol de usuario
        /// </summary>
        /// <param name="ROL_ID">Id de rol de usuario</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult DeleteRol(int ROL_ID)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                resultMessage = this.RolRepository.Delete(ROL_ID);
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

        [HttpPost]
        public JsonResult GetRolOptions()
        {
            try
            {
                var rols = this.RolRepository.GetAll().Select(c => new { DisplayText = c.ROL_NAME, Value = c.ROL_ID });
                return Json(new { Result = "OK", Options = rols });
            }
            catch (Exception ex)
            {
                return Json(new { Result = "ERROR", Message = ex.Message });
            }
        }

        #region PopUp EventCategory

        /// <summary>
        /// Obtener los productos asociados a un rol de usuario.
        /// </summary>
        /// <param name="userRoleId">Id de rol de usuario</param>
        /// <returns>cadena de texto formato json</returns>
        public ActionResult GetProductsByUserRole(string userRoleId = "0")
        {
            try
            {
                if (userRoleId.Trim().Equals(DEFAULT_ITEM_VALUE))
                {
                    return this.Json(new { errorMessage = "No se ha seleccionado rol de usuario." }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    //Lista de las categorias
                    var productList = this.ProductRepository.GetUserRoleProducts(Convert.ToInt32(userRoleId));
                    List<System.Web.Mvc.SelectListItem> products = productList
                        .Select(c => new System.Web.Mvc.SelectListItem
                        {
                            Selected = c.IS_RELATIONED.Equals(0) ? false : true,
                            Text = c.PDT_NAME,
                            Value = c.PDT_ID.ToString(CultureInfo.InvariantCulture)
                        }).ToList();
                    ViewBag.AvaliableProducts = products;
                    return this.PartialView("_UserRolByProductContainer");
                }
            }
            catch (Exception ex)
            {
                return Json(new { errorMessage = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Crea la asociacion entre un rol de usuario y productos
        /// </summary>
        /// <param name="userRoleId">Id de Rol de usuario</param>
        /// <param name="productIds">Listado con los Id de productos a asociar</param>
        /// <returns></returns>
        public ActionResult AssociateUserRoleProducts(int userRoleId, string productIds)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                resultMessage = this.ProductRepository.InsertRolProducts(userRoleId, productIds);
                string message = string.Empty;
                if (string.IsNullOrEmpty(message))
                {
                    result = this.Json(new { resultMessage = "La operación ha sido ejecutada con exito." }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    result = this.Json(new { errorMessage = message }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                result = this.Json(new { errorMessage = ex.Message }, JsonRequestBehavior.AllowGet);
            }
            return result;
        }

        /// <summary>
        /// Desvincula los productos a un rol de usuario especifico.
        /// </summary>
        /// <param name="userRoleId">Id de rol de usuario</param>
        /// <returns></returns>
        public ActionResult DisassociateUserRoleProducts(int userRoleId)
        {
            ActionResult result = null;
            try
            {
                //message = this.ViewEventCategoryLabelBll.TryDelete(eventTypeId, this.CurrentUser);
                string message = string.Empty;
                if (string.IsNullOrEmpty(message))
                {
                    result = this.Json(new { resultMessage = "Los productos se desvincularon exitosamente del rol de usuario." }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    result = this.Json(new { Result = "ERROR", errorMessage = message }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                result = this.Json(new { Result = "ERROR", errorMessage = ex.Message }, JsonRequestBehavior.AllowGet);
            }
            return result;
        }

        #endregion PopUp EventCategory


    }
}