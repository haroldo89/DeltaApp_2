using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DeltaApp.Models
{
    public partial class PRODUCT_VIEW
    {
        public string PDT_OPORTUNITY_DATE_ACCORDED_FORMAT
        {
            get
            {
                if (this.PDT_OPORTUNITY_DATE_ACCORDED.HasValue)
                {
                    return this.PDT_OPORTUNITY_DATE_ACCORDED.Value.ToString("yyyy-MM-dd");
                }
                return string.Empty;
            }
            set
            {
            }
        }

    }
}