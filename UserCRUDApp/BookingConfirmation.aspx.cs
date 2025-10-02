using System;
using System.Data;
using System.Web.UI;
using UserCRUDApp.DAL;

namespace UserCRUDApp
{
    public partial class BookingConfirmation : System.Web.UI.Page
    {
        SmartTicketingHelper helper = new SmartTicketingHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int bookingId;
            if (!int.TryParse(Request.QueryString["bookingId"], out bookingId))
            {
                Response.Redirect("Movies.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadBookingDetails(bookingId);
            }
        }

        private void LoadBookingDetails(int bookingId)
        {
            try
            {
                DataRow booking = helper.GetBookingDetails(bookingId);

                if (booking != null)
                {
                    lblBookingRef.Text = booking["BookingReference"].ToString();
                    lblMovieTitle.Text = booking["MovieTitle"].ToString();
                    lblTheater.Text = booking["TheaterName"].ToString() + ", " + booking["Location"].ToString();

                    DateTime showDate = Convert.ToDateTime(booking["ShowDate"]);
                    DateTime showTime = Convert.ToDateTime(booking["ShowTime"]);
                    lblDateTime.Text = showDate.ToString("dd MMM yyyy") + " at " + showTime.ToString("hh:mm tt");

                    lblSeats.Text = booking["SeatNumbers"].ToString();
                    lblTicketCount.Text = booking["TotalSeats"].ToString();
                    lblTotalAmount.Text = Convert.ToDecimal(booking["TotalAmount"]).ToString("N2");
                }
                else
                {
                    Response.Redirect("Movies.aspx");
                }
            }
            catch (Exception ex)
            {
                // Log error and redirect
                Response.Redirect("Movies.aspx");
            }
        }
    }
}