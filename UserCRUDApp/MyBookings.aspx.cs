using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using UserCRUDApp.DAL;

namespace UserCRUDApp
{
    public partial class MyBookings : System.Web.UI.Page
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
                LoadBookings();
            }
        }

        private void LoadBookings()
        {
            try
            {
                string username = Session["Username"].ToString();
                int userId = helper.GetUserIdByUsername(username);

                if (userId > 0)
                {
                    DataTable dt = helper.GetUserBookings(userId);

                    if (dt.Rows.Count > 0)
                    {
                        rptBookings.DataSource = dt;
                        rptBookings.DataBind();
                        pnlNoBookings.Visible = false;
                    }
                    else
                    {
                        pnlNoBookings.Visible = true;
                    }
                }
                else
                {
                    ShowMessage("User not found. Please login again.", "error");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading bookings: " + ex.Message, "error");
            }
        }

        protected void rptBookings_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "CancelBooking")
            {
                try
                {
                    int bookingId = Convert.ToInt32(e.CommandArgument);
                    bool result = helper.CancelBooking(bookingId);

                    if (result)
                    {
                        ShowMessage("Booking cancelled successfully! Refund will be processed within 5-7 working days.", "success");
                        LoadBookings();
                    }
                    else
                    {
                        ShowMessage("Failed to cancel booking. Please try again.", "error");
                    }
                }
                catch (Exception ex)
                {
                    ShowMessage("Error cancelling booking: " + ex.Message, "error");
                }
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