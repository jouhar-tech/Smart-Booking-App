using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using UserCRUDApp.DAL;

namespace UserCRUDApp
{
    public partial class Dashboard : System.Web.UI.Page
    {
        DatabaseHelper dbHelper = new DatabaseHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is logged in
            if (Session["Username"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblUsername.Text = Session["Username"].ToString();
                LoadUsers();
            }
        }

        private void LoadUsers()
        {
            DataTable dt = dbHelper.GetAllUsers();
            gvUsers.DataSource = dt;
            gvUsers.DataBind();

            // Update total users count
            lblTotalUsers.Text = dt.Rows.Count.ToString();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int userId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "EditUser")
            {
                // Load user data for editing
                DataRow user = dbHelper.GetUserById(userId);
                if (user != null)
                {
                    pnlUpdateForm.Visible = true;
                    hfUserId.Value = user["UserId"].ToString();
                    txtUpdateUsername.Text = user["Username"].ToString();
                    txtUpdateEmail.Text = user["Email"].ToString();

                    // Scroll to update form
                    ScriptManager.RegisterStartupScript(this, GetType(), "ScrollToForm",
                        "window.scrollTo(0, document.querySelector('.form-section').offsetTop - 20);", true);
                }
            }
            else if (e.CommandName == "DeleteUser")
            {
                // Delete user
                bool result = dbHelper.DeleteUser(userId);
                if (result)
                {
                    ShowMessage("User deleted successfully!", "success");
                    LoadUsers();
                }
                else
                {
                    ShowMessage("Failed to delete user!", "error");
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(hfUserId.Value);
            string username = txtUpdateUsername.Text.Trim();
            string email = txtUpdateEmail.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(email))
            {
                ShowMessage("All fields are required!", "error");
                return;
            }

            bool result = dbHelper.UpdateUser(userId, username, email);

            if (result)
            {
                ShowMessage("User updated successfully!", "success");
                pnlUpdateForm.Visible = false;
                ClearUpdateForm();
                LoadUsers();
            }
            else
            {
                ShowMessage("Failed to update user!", "error");
            }
        }

        protected void btnCancelUpdate_Click(object sender, EventArgs e)
        {
            pnlUpdateForm.Visible = false;
            ClearUpdateForm();
        }

        private void ClearUpdateForm()
        {
            hfUserId.Value = "";
            txtUpdateUsername.Text = "";
            txtUpdateEmail.Text = "";
        }

        private void ShowMessage(string message, string type)
        {
            pnlMessage.Visible = true;
            lblMessage.Text = message;
            pnlMessage.CssClass = "message " + type;
        }
    }
}