<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyBookings.aspx.cs" Inherits="UserCRUDApp.MyBookings" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Bookings - Smart Ticketing</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: #0f172a;
            min-height: 100vh;
        }

        .navbar {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            padding: 20px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 2px solid rgba(99, 102, 241, 0.3);
        }

        .logo {
            font-size: 28px;
            font-weight: 800;
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .nav-links {
            display: flex;
            gap: 30px;
            align-items: center;
        }

        .nav-link {
            color: #94a3b8;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            font-size: 15px;
        }

        .nav-link:hover {
            color: #6366f1;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .username {
            color: #e2e8f0;
            font-weight: 600;
        }

        .btn-logout {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-logout:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(239, 68, 68, 0.4);
        }

        .container {
            max-width: 1400px;
            margin: 50px auto;
            padding: 0 50px;
        }

        .page-header {
            margin-bottom: 40px;
        }

        .page-title {
            color: white;
            font-size: 36px;
            font-weight: 800;
            margin-bottom: 10px;
        }

        .page-subtitle {
            color: #94a3b8;
            font-size: 16px;
        }

        .bookings-grid {
            display: grid;
            gap: 25px;
        }

        .booking-card {
            background: rgba(30, 41, 59, 0.6);
            border-radius: 16px;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: all 0.3s ease;
            display: grid;
            grid-template-columns: 200px 1fr auto;
            gap: 30px;
        }

        .booking-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(99, 102, 241, 0.2);
            border-color: rgba(99, 102, 241, 0.5);
        }

        .movie-poster-booking {
            width: 200px;
            height: 280px;
            object-fit: cover;
        }

        .booking-info {
            padding: 30px 0;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .movie-title-booking {
            color: white;
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .booking-meta {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        .meta-item-booking {
            display: flex;
            align-items: flex-start;
            gap: 10px;
        }

        .meta-icon {
            color: #6366f1;
            margin-top: 3px;
        }

        .meta-content {
            flex: 1;
        }

        .meta-label {
            color: #64748b;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 3px;
        }

        .meta-value {
            color: #e2e8f0;
            font-weight: 600;
        }

        .booking-ref {
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            padding: 10px 15px;
            border-radius: 8px;
            display: inline-block;
            color: white;
            font-weight: 700;
            letter-spacing: 1px;
            font-size: 14px;
        }

        .seats-badge {
            background: rgba(99, 102, 241, 0.2);
            color: #a5b4fc;
            padding: 8px 15px;
            border-radius: 8px;
            font-weight: 600;
            display: inline-block;
        }

        .booking-actions {
            padding: 30px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: flex-end;
            border-left: 1px solid rgba(255, 255, 255, 0.1);
        }

        .status-badge {
            padding: 8px 20px;
            border-radius: 8px;
            font-weight: 700;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-confirmed {
            background: rgba(16, 185, 129, 0.2);
            color: #6ee7b7;
        }

        .status-cancelled {
            background: rgba(239, 68, 68, 0.2);
            color: #fca5a5;
        }

        .amount-display {
            text-align: right;
            margin-top: 20px;
        }

        .amount-label {
            color: #64748b;
            font-size: 12px;
            margin-bottom: 5px;
        }

        .amount-value {
            color: #10b981;
            font-size: 28px;
            font-weight: 800;
        }

        .btn-cancel {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            margin-top: 15px;
        }

        .btn-cancel:hover {
            box-shadow: 0 5px 15px rgba(239, 68, 68, 0.4);
            transform: translateY(-2px);
        }

        .btn-cancel:disabled {
            background: linear-gradient(135deg, #64748b 0%, #475569 100%);
            cursor: not-allowed;
            transform: none;
        }

        .no-bookings {
            text-align: center;
            padding: 100px 50px;
            color: #64748b;
        }

        .no-bookings i {
            font-size: 80px;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .no-bookings h3 {
            color: #94a3b8;
            font-size: 24px;
            margin-bottom: 15px;
        }

        .btn-browse {
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            color: white;
            padding: 14px 35px;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-weight: 700;
            transition: all 0.3s ease;
            margin-top: 30px;
            text-decoration: none;
            display: inline-block;
        }

        .btn-browse:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.4);
        }

        .message {
            padding: 18px 24px;
            border-radius: 12px;
            margin-bottom: 30px;
            text-align: center;
            font-weight: 600;
        }

        .success {
            background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            color: #065f46;
            border: 2px solid #6ee7b7;
        }

        .error {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            color: #991b1b;
            border: 2px solid #fca5a5;
        }

        @media (max-width: 1024px) {
            .booking-card {
                grid-template-columns: 150px 1fr;
            }

            .booking-actions {
                grid-column: 1 / -1;
                flex-direction: row;
                border-left: none;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
            }

            .movie-poster-booking {
                width: 150px;
                height: 220px;
            }
        }

        @media (max-width: 768px) {
            .booking-card {
                grid-template-columns: 1fr;
            }

            .movie-poster-booking {
                width: 100%;
                height: 300px;
            }

            .booking-meta {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navigation Bar -->
        <div class="navbar">
            <div class="logo">
                <i class="fas fa-ticket-alt"></i>
                Smart Ticketing
            </div>
            <div class="user-info">
                <asp:HyperLink ID="lnkMovies" runat="server" NavigateUrl="~/Movies.aspx" CssClass="nav-link">
                    <i class="fas fa-film"></i> Movies
                </asp:HyperLink>
                <asp:HyperLink ID="lnkMyBookings" runat="server" NavigateUrl="~/MyBookings.aspx" CssClass="nav-link" style="color: #6366f1;">
                    <i class="fas fa-ticket"></i> My Bookings
                </asp:HyperLink>
                <span class="username">
                    <i class="fas fa-user-circle"></i>
                    <asp:Label ID="lblUsername" runat="server"></asp:Label>
                </span>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" 
                    CssClass="btn-logout" OnClick="btnLogout_Click" />
            </div>
        </div>

        <div class="container">
            <div class="page-header">
                <h1 class="page-title">🎫 My Bookings</h1>
                <p class="page-subtitle">View and manage your movie ticket bookings</p>
            </div>

            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="message">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>

            <asp:Panel ID="pnlNoBookings" runat="server" Visible="false" CssClass="no-bookings">
                <i class="fas fa-ticket-alt"></i>
                <h3>No bookings yet!</h3>
                <p>Start booking your favorite movies now</p>
                <asp:HyperLink ID="lnkBrowseMovies" runat="server" NavigateUrl="~/Movies.aspx" CssClass="btn-browse">
                    Browse Movies
                </asp:HyperLink>
            </asp:Panel>

            <div class="bookings-grid">
                <asp:Repeater ID="rptBookings" runat="server" OnItemCommand="rptBookings_ItemCommand">
                    <ItemTemplate>
                        <div class="booking-card">
                            <img src='<%# Eval("PosterUrl") %>' alt='<%# Eval("MovieTitle") %>' class="movie-poster-booking" />
                            
                            <div class="booking-info">
                                <div>
                                    <h3 class="movie-title-booking"><%# Eval("MovieTitle") %></h3>
                                    <span class="booking-ref"><%# Eval("BookingReference") %></span>
                                </div>

                                <div class="booking-meta">
                                    <div class="meta-item-booking">
                                        <i class="fas fa-building meta-icon"></i>
                                        <div class="meta-content">
                                            <div class="meta-label">Theater</div>
                                            <div class="meta-value"><%# Eval("TheaterName") %></div>
                                        </div>
                                    </div>

                                    <div class="meta-item-booking">
                                        <i class="fas fa-calendar meta-icon"></i>
                                        <div class="meta-content">
                                            <div class="meta-label">Date & Time</div>
                                            <div class="meta-value">
                                                <%# Convert.ToDateTime(Eval("ShowDate")).ToString("dd MMM yyyy") %> 
                                                <%# Convert.ToDateTime(Eval("ShowTime")).ToString("hh:mm tt") %>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="meta-item-booking">
                                        <i class="fas fa-map-marker-alt meta-icon"></i>
                                        <div class="meta-content">
                                            <div class="meta-label">Location</div>
                                            <div class="meta-value"><%# Eval("Location") %></div>
                                        </div>
                                    </div>

                                    <div class="meta-item-booking">
                                        <i class="fas fa-chair meta-icon"></i>
                                        <div class="meta-content">
                                            <div class="meta-label">Seats</div>
                                            <div class="seats-badge"><%# Eval("SeatNumbers") %></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="booking-actions">
                                <div>
                                    <span class='status-badge <%# Eval("BookingStatus").ToString() == "Confirmed" ? "status-confirmed" : "status-cancelled" %>'>
                                        <%# Eval("BookingStatus") %>
                                    </span>
                                    
                                    <div class="amount-display">
                                        <div class="amount-label">Total Amount</div>
                                        <div class="amount-value">₹<%# Convert.ToDecimal(Eval("TotalAmount")).ToString("N2") %></div>
                                    </div>
                                </div>

                                <asp:Button ID="btnCancelBooking" runat="server" 
                                    Text="Cancel Booking" 
                                    CssClass="btn-cancel"
                                    CommandName="CancelBooking"
                                    CommandArgument='<%# Eval("BookingId") %>'
                                    OnClientClick="return confirm('Are you sure you want to cancel this booking?');"
                                    Enabled='<%# Eval("BookingStatus").ToString() == "Confirmed" %>' />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>
</body>
</html>