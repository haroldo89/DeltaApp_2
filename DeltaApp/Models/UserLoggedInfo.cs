namespace DeltaApp.Models
{
    /// <summary>
    /// Informacion de autenticacion de usuario.
    /// </summary>
    public class UserLoggedInfo
    {
        /// <summary>
        /// ID de Usuario
        /// </summary>
        public int UserID { get; set; }
        /// <summary>
        /// Nombre de usuario
        /// </summary>
        public string UserName { get; set; }

        /// <summary>
        /// Contraseña
        /// </summary>
        public string Password { get; set; }

        /// <summary>
        /// Tipo de usuario
        /// </summary>
        public int UserType { get; set; }
    }
}