using System;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using UserCRUDApp.DAL;

namespace UserCRUDApp
{
    public partial class ShowTimes : System.Web.UI.Page
    {
        SmartTicketingHelper helper = new SmartTicketingHelper();
        private int movieId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!int.TryParse(Request.QueryString["movieId"], out movieId))
            {
                Response.Redirect("Movies.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadMovieDetails();
                LoadShows();
            }
        }

        private void LoadMovieDetails()
        {
            try
            {
                DataRow movie = helper.GetMovieById(movieId);

                if (movie != null)
                {
                    lblMovieTitle.Text = movie["Title"].ToString();
                    lblRating.Text = movie["Rating"].ToString();
                    lblDuration.Text = movie["Duration"].ToString();
                    lblLanguage.Text = movie["Language"].ToString();
                    lblGenre.Text = movie["Genre"].ToString();
                    lblDescription.Text = movie["Description"].ToString();
                    imgPoster.ImageUrl = movie["PosterUrl"].ToString();
                }
                else
                {
                    Response.Redirect("Movies.aspx");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading movie details: " + ex.Message, "error");
            }
        }

        private void LoadShows()
        {
            try
            {
                DataTable dtShows = helper.GetShowsByMovie(movieId);

                if (dtShows.Rows.Count > 0)
                {
                    // Group shows by date
                    var groupedByDate = dtShows.AsEnumerable()
                        .GroupBy(row => row.Field<DateTime>("ShowDate"))
                        .Select(g => new
                        {
                            ShowDate = g.Key,
                            Shows = g.CopyToDataTable()
                        })
                        .ToList();

                    rptDates.DataSource = groupedByDate;
                    rptDates.DataBind();
                    pnlNoShows.Visible = false;
                }
                else
                {
                    pnlNoShows.Visible = true;
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading shows: " + ex.Message, "error");
            }
        }

        protected void rptDates_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                dynamic dateGroup = e.Item.DataItem;
                Repeater rptShows = (Repeater)e.Item.FindControl("rptShows");

                if (rptShows != null)
                {
                    rptShows.DataSource = dateGroup.Shows;
                    rptShows.DataBind();
                }
            }
        }

        protected void rptShows_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectShow")
            {
                int showId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"SeatSelection.aspx?showId={showId}");
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