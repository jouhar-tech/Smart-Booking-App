using System
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using UserCRUDApp.DAL;

namespace UserCRUDApp
{
    public partial class Movies : System.Web.UI.Page
    {
        SmartTicketingHelper helper = new SmartTicketingHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblUsername.Text = Session["Username"].ToString();
                LoadMovies();
            }
        }

        private void LoadMovies()
        {
            try
            {
                DataTable dt = helper.GetAllMovies();

                if (dt.Rows.Count > 0)
                {
                    rptMovies.DataSource = dt;
                    rptMovies.DataBind();
                    pnlNoMovies.Visible = false;
                }
                else
                {
                    pnlNoMovies.Visible = true;
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading movies: " + ex.Message, "error");
            }
        }

        protected void rptMovies_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "BookTicket")
            {
                int movieId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"ShowTimes.aspx?movieId={movieId}");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        private void ShowMessage(string message, string type)
        {
            pnlMessage.Visible = true;
            lblMessage.Text = message;
            pnlMessage.CssClass = "message " + type;
        }
    }
}