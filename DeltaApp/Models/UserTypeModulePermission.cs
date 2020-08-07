using System.Runtime.Serialization;

namespace DeltaApp.Models
{
    [DataContract(Name = "UserTypeModulePermission")]
    public class UserTypeModulePermission
    {

        [DataMember(Name = "TYPE_ID")]
        public int? TYPE_ID { get; set; }
        [DataMember(Name = "TYPE_NAME")]
        public string TYPE_NAME { get; set; }
        [DataMember(Name = "MODULES_MODULE_ID")]
        public int MODULES_MODULE_ID { get; set; }
        [DataMember(Name = "MODULE_NAME")]
        public string MODULE_NAME { get; set; }
        [DataMember(Name = "MODULE_ID")]
        public int? MODULE_ID { get; set; }
        [DataMember(Name = "MODULES_ALIAS")]
        public string MODULES_ALIAS { get; set; }


        public UserTypeModulePermission()
        {

        }

        public UserTypeModulePermission(USER_TYPE_MODULES userTypeModule)
        {
            this.TYPE_ID = userTypeModule.TYPE_ID;
            this.TYPE_NAME = userTypeModule.TYPE_NAME;
            this.MODULES_MODULE_ID = userTypeModule.MODULES_MODULE_ID;
            this.MODULE_NAME = userTypeModule.MODULE_NAME;
            this.MODULE_ID = userTypeModule.MODULE_ID;
            this.MODULES_ALIAS = userTypeModule.MODULES_ALIAS;
        }
    }
}