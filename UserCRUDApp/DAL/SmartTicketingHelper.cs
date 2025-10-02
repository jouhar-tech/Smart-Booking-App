using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace UserCRUDApp.DAL
{
    public class SmartTicketingHelper
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["UserDBConnection"].ConnectionString;

        // Get all active movies
        public DataTable GetAllMovies()
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT MovieId, Title, Description, Genre, Duration, 
                                   Language, Rating, ReleaseDate, PosterUrl 
                                   FROM Movies WHERE IsActive = 1 
                                   ORDER BY ReleaseDate DESC";
                    SqlDataAdapter adapter = new SqlDataAdapter(query, conn);
                    adapter.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error fetching movies: " + ex.Message);
            }
            return dt;
        }

        // Get movie by ID
        public DataRow GetMovieById(int movieId)
       {
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT * FROM Movies WHERE MovieId = @MovieId";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@MovieId", movieId);
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    adapter.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error fetching movie: " + ex.Message);
            }
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        // Get shows by movie ID
        public DataTable GetShowsByMovie(int movieId)
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT * FROM vw_MovieShows 
                                   WHERE MovieId = @MovieId 
                                   AND ShowDate >= CAST(GETDATE() AS DATE)
                                   ORDER BY ShowDate, ShowTime";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@MovieId", movieId);
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    adapter.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error fetching shows: " + ex.Message);
            }
            return dt;
        }

        // Get show details
        public DataRow GetShowDetails(int showId)
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT * FROM vw_MovieShows WHERE ShowId = @ShowId";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@ShowId", showId);
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    adapter.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error fetching show details: " + ex.Message);
            }
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        // Create booking
        public bool CreateBooking(int userId, int showId, int totalSeats, string seatNumbers,
                                 out int bookingId, out string bookingReference)
        {
            bookingId = 0;
            bookingReference = "";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand("sp_CreateBooking", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@ShowId", showId);
                    cmd.Parameters.AddWithValue("@TotalSeats", totalSeats);
                    cmd.Parameters.AddWithValue("@SeatNumbers", seatNumbers);

                    SqlParameter bookingIdParam = new SqlParameter("@BookingId", SqlDbType.Int);
                    bookingIdParam.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(bookingIdParam);

                    SqlParameter bookingRefParam = new SqlParameter("@BookingReference", SqlDbType.NVarChar, 50);
                    bookingRefParam.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(bookingRefParam);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    bookingId = Convert.ToInt32(bookingIdParam.Value);
                    bookingReference = bookingRefParam.Value.ToString();

                    return true;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error creating booking: " + ex.Message);
            }
        }

        // Get user bookings
        public DataTable GetUserBookings(int userId)
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT * FROM vw_UserBookings 
                                   WHERE UserId = @UserId 
                                   ORDER BY BookingDate DESC";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    adapter.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error fetching bookings: " + ex.Message);
            }
            return dt;
        }

        // Get booking details
        public DataRow GetBookingDetails(int bookingId)
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT * FROM vw_UserBookings WHERE BookingId = @BookingId";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@BookingId", bookingId);
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    adapter.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error fetching booking details: " + ex.Message);
            }
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        // Cancel booking
        public bool CancelBooking(int bookingId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlTransaction transaction = conn.BeginTransaction();

                    try
                    {
                        // Get booking details
                        string getBookingQuery = @"SELECT ShowId, TotalSeats FROM Bookings WHERE BookingId = @BookingId";
                        SqlCommand getCmd = new SqlCommand(getBookingQuery, conn, transaction);
                        getCmd.Parameters.AddWithValue("@BookingId", bookingId);
                        SqlDataReader reader = getCmd.ExecuteReader();

                        int showId = 0;
                        int totalSeats = 0;

                        if (reader.Read())
                        {
                            showId = Convert.ToInt32(reader["ShowId"]);
                            totalSeats = Convert.ToInt32(reader["TotalSeats"]);
                        }
                        reader.Close();

                        // Update booking status
                        string updateQuery = @"UPDATE Bookings SET BookingStatus = 'Cancelled' 
                                             WHERE BookingId = @BookingId";
                        SqlCommand updateCmd = new SqlCommand(updateQuery, conn, transaction);
                        updateCmd.Parameters.AddWithValue("@BookingId", bookingId);
                        updateCmd.ExecuteNonQuery();

                        // Return seats to show
                        string returnSeatsQuery = @"UPDATE Shows SET AvailableSeats = AvailableSeats + @TotalSeats 
                                                  WHERE ShowId = @ShowId";
                        SqlCommand returnCmd = new SqlCommand(returnSeatsQuery, conn, transaction);
                        returnCmd.Parameters.AddWithValue("@ShowId", showId);
                        returnCmd.Parameters.AddWithValue("@TotalSeats", totalSeats);
                        returnCmd.ExecuteNonQuery();

                        transaction.Commit();
                        return true;
                    }
                    catch
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error cancelling booking: " + ex.Message);
            }
        }

        // Get user ID by username
        public int GetUserIdByUsername(string username)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT UserId FROM Users WHERE Username = @Username";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Username", username);

                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    return result != null ? Convert.ToInt32(result) : 0;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error fetching user ID: " + ex.Message);
            }
        }
    }
}