using System;
using System.Web.UI;
using UserCRUDApp.DAL;

namespace UserCRUDApp
{
    public partial class Register : System.Web.UI.Page
    {
        DatabaseHelper dbHelper = new DatabaseHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is already logged in
                if (Session["Username"] != null)
                {
                    Response.Redirect("Dashboard.aspx");
                }
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            // Validation
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                ShowMessage("All fields are required!", "error");
                return;
            }

            if (password != confirmPassword)
            {
                ShowMessage("Passwords do not match!", "error");
                return;
            }

            if (password.Length < 6)
            {
                ShowMessage("Password must be at least 6 characters long!", "error");
                return;
            }

            // Check if username already exists
            if (dbHelper.UsernameExists(username))
            {
                ShowMessage("Username already exists! Please choose another.", "error");
                return;
            }

            // Register user
            bool result = dbHelper.RegisterUser(username, email, password);

            if (result)
            {
                ShowMessage("Registration successful! Redirecting to login...", "success");

                // Clear form
                txtUsername.Text = "";
                txtEmail.Text = "";
                txtPassword.Text = "";
                txtConfirmPassword.Text = "";

                // Redirect to login after 2 seconds
                Response.AddHeader("REFRESH", "2;URL=Login.aspx");
            }
            else
            {
                ShowMessage("Registration failed! Please try again.", "error");
            }
        }

        private void ShowMessage(string message, string type)
        {
            pnlMessage.Visible = true;
            lblMessage.Text = message;
            pnlMessage.CssClass = "message " + type;
        }
    }
}