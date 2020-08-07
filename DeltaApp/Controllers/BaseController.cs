using AlbatrosSoft.Common.Web;
using DeltaApp.Models;
using DeltaApp.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DeltaApp.Controllers
{
    public class BaseController : Controller
    {
        UserTypeModuleRepository UserTypeModuleRepository = new UserTypeModuleRepository();


        public UserLoggedInfo CurrentUser
        {
            get
            {
                UserLoggedInfo userInfo = new UserLoggedInfo();
                if (Session["UserLoggedInfo"] != null)
                {
                    userInfo = (UserLoggedInfo)Session["UserLoggedInfo"];
                }
                return userInfo;
            }
        }

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            base.OnActionExecuting(filterContext);
            //Establece nombre de usuario
            this.LoadUserName();
            //Cargar permisos de usuario.
            this.LoadUserPermission();

        }

        //Nombre de usuario
        private void LoadUserName()
        {
            if (this.CurrentUser != null)
            {
                this.ViewBag.CurrentUserName = this.CurrentUser.UserName;
            }
        }

        //Cargar permisos de usuario.
        private void LoadUserPermission()
        {
            if (this.CurrentUser != null)
            {
                var loadPermission = this.LoadUserPermission(this.CurrentUser.UserType);
                this.ViewBag.UserPermission = this.BuildLoadPermission(loadPermission);
            }
        }

        private IEnumerable<UserTypeModulePermission> LoadUserPermission(int userTypeId)
        {
            return this.UserTypeModuleRepository.GetUserPermission(userTypeId);
        }


        private string BuildLoadPermission(IEnumerable<UserTypeModulePermission> userPermissions)
        {
            string jSonResult = string.Empty;
            if (userPermissions != null)
            {
                jSonResult = JsonHelper.Serialize<List<UserTypeModulePermission>>(userPermissions.ToList());
            }
            return jSonResult;
        }
    }
}