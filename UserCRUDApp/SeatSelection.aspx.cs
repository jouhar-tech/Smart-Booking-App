using System;
using System.Data;
using System.Text;
using System.Web.UI;
using UserCRUDApp.DAL;

namespace UserCRUDApp
{
    public partial class SeatSelection : System.Web.UI.Page
    {
        SmartTicketingHelper helper = new SmartTicketingHelper();
        private int showId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!int.TryParse(Request.QueryString["showId"], out showId))
            {
                Response.Redirect("Movies.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadShowDetails();
                GenerateSeats();
            }
        }

        private void LoadShowDetails()
        {
            try
            {
                DataRow show = helper.GetShowDetails(showId);

                if (show != null)
                {
                    // ✅ your column is Title
                    lblMovieTitle.Text = show["Title"].ToString();
                    lblTheater.Text = show["TheaterName"].ToString();
                    lblShowDate.Text = Convert.ToDateTime(show["ShowDate"]).ToString("dd MMM yyyy");
                    lblShowTime.Text = Convert.ToDateTime(show["ShowTime"]).ToString("hh:mm tt");

                    decimal ticketPrice = 0;
                    if (show.Table.Columns.Contains("TicketPrice") && show["TicketPrice"] != DBNull.Value)
                        ticketPrice = Convert.ToDecimal(show["TicketPrice"]);

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "InitSeats",
                        $"initializeSeatSelection({ticketPrice});",
                        true
                    );
                }
                else
                {
                    Response.Redirect("ShowTimes.aspx");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading show details: " + ex.Message, "error");
            }
        }



        private void GenerateSeats()
{
    try
    {
        DataRow show = helper.GetShowDetails(showId);
        if (show == null) return;

        int totalSeats = Convert.ToInt32(show["TotalSeats"]);
                int availableSeats = Convert.ToInt32(show["AvailableSeats"]);
        int occupiedSeats = totalSeats - availableSeats;

        StringBuilder sb = new StringBuilder();

        // Generate 10 rows (A-J) with 15 seats each for 150 total seats
        string[] rows = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J" };
        int seatsPerRow = 15;
        int seatCounter = 1;
        Random random = new Random(showId); // consistent occupied seats

        foreach (string row in rows)
        {
            sb.Append("<div class='seat-row'>");
            sb.Append($"<span class='row-label'>{row}</span>");

            for (int i = 1; i <= seatsPerRow; i++)
            {
                string seatNumber = $"{row}{i}";
                bool isOccupied = seatCounter <= occupiedSeats && random.Next(100) < 40;
                string seatClass = isOccupied ? "seat occupied" : "seat";
                string onclick = isOccupied ? "" : $"onclick=\"toggleSeat('{seatNumber}', this)\"";
                sb.Append($"<div class='{seatClass}' {onclick}>{i}</div>");
                seatCounter++;
            }

            sb.Append("</div>");
        }

        litSeats.Text = sb.ToString();
    }
    catch (Exception ex)
    {
        ShowMessage("Error generating seats: " + ex.Message, "error");
    }
}


        protected void btnBookNow_Click(object sender, EventArgs e)
        {
            try
            {
                string selectedSeats = hfSelectedSeats.Value;

                if (string.IsNullOrEmpty(selectedSeats))
                {
                    ShowMessage("Please select at least one seat!", "error");
                    return;
                }

                string[] seats = selectedSeats.Split(',');
                int totalSeats = seats.Length;

                if (totalSeats > 10)
                {
                    ShowMessage("You can book maximum 10 seats at a time!", "error");
                    return;
                }

                string username = Session["Username"].ToString();
                int userId = helper.GetUserIdByUsername(username);

                if (userId == 0)
                {
                    ShowMessage("User not found. Please login again.", "error");
                    return;
                }

                int bookingId;
                string bookingReference;

                bool result = helper.CreateBooking(userId, showId, totalSeats, selectedSeats,
                                                   out bookingId, out bookingReference);

                if (result)
                {
                    Response.Redirect($"BookingConfirmation.aspx?bookingId={bookingId}");
                }
                else
                {
                    ShowMessage("Booking failed! Please try again.", "error");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error creating booking: " + ex.Message, "error");
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("ShowTimes.aspx");
        }

        private void ShowMessage(string message, string type)
        {
            pnlMessage.Visible = true;
            lblMessage.Text = message;
            pnlMessage.CssClass = "message " + type;
        }
    }
}