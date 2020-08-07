using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DeltaApp.Models
{
    public class SelectListItem
    {
        /// <summary>
        /// Valor de un itemList
        /// </summary>
        public string Value { get; set; }

        /// <summary>
        /// Valor a mostrar en un itemList
        /// </summary>
        public string DisplayText { get; set; }

        /// <summary>
        /// Constructor basico
        /// </summary>
        public SelectListItem()
        {

        }

        /// <summary>
        /// Constructor que recibe los valores para la creacion de un itemList
        /// </summary>
        /// <param name="value"></param>
        /// <param name="displayText"></param>
        public SelectListItem(string value, string displayText)
        {
            if (string.IsNullOrWhiteSpace(displayText))
            {
                throw new ArgumentNullException("displayText", "El valor de DisplayText no puede ser un valor nulo o vacio.");
            }
            this.Value = value;
            this.DisplayText = displayText;
        }
    }
}