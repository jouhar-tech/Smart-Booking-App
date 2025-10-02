using System;
using System.Web.UI;
using UserCRUDApp.DAL;

namespace UserCRUDApp
{
    public partial class Login : System.Web.UI.Page
    {
        DatabaseHelper dbHelper = new DatabaseHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is already logged in
                if (Session["Username"] != null)
                {
                    Response.Redirect("Movies.aspx");
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            // Validation
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                ShowMessage("Username and password are required!", "error");
                return;
            }

            // Authenticate user
            bool isAuthenticated = dbHelper.LoginUser(username, password);

            if (isAuthenticated)
            {
                // Create session
                Session["Username"] = username;
                Session.Timeout = 30; // 30 minutes

                // Redirect to dashboard
                Response.Redirect("Movies.aspx");
            }
            else
            {
                ShowMessage("Invalid username or password!", "error");
                txtPassword.Text = "";
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