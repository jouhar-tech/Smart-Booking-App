<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowTimes.aspx.cs" Inherits="UserCRUDApp.ShowTimes" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Select Show Time - Smart Ticketing</title>
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
            border-bottom: 2px solid rgba(99, 102, 241, 0.3);
        }

        .logo {
            font-size: 28px;
            font-weight: 800;
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .btn-back {
            background: linear-gradient(135deg, #64748b 0%, #475569 100%);
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(100, 116, 139, 0.4);
        }

        .container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 0 50px;
        }

        .movie-header {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            border-radius: 16px;
            padding: 40px;
            margin-bottom: 40px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            display: flex;
            gap: 40px;
            align-items: center;
        }

        .movie-poster-small {
            width: 200px;
            height: 300px;
            border-radius: 12px;
            object-fit: cover;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }

        .movie-details {
            flex: 1;
        }

        .movie-title {
            color: white;
            font-size: 36px;
            font-weight: 800;
            margin-bottom: 15px;
        }

        .movie-meta-row {
            display: flex;
            gap: 30px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .meta-badge {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 18px;
            background: rgba(99, 102, 241, 0.2);
            border-radius: 8px;
            color: #a5b4fc;
            font-weight: 600;
        }

        .movie-description {
            color: #94a3b8;
            line-height: 1.8;
            margin-top: 15px;
        }

        .section-title {
            color: white;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .date-group {
            margin-bottom: 40px;
        }

        .date-header {
            color: #6366f1;
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .shows-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

        .show-card {
            background: rgba(30, 41, 59, 0.6);
            border-radius: 12px;
            padding: 25px;
            border: 2px solid rgba(255, 255, 255, 0.1);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .show-card:hover {
            border-color: rgba(99, 102, 241, 0.5);
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.2);
        }

        .show-time {
            color: white;
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .theater-info {
            color: #94a3b8;
            margin-bottom: 15px;
        }

        .theater-name {
            font-weight: 600;
            color: #cbd5e1;
            font-size: 16px;
        }

        .theater-location {
            font-size: 14px;
            color: #64748b;
        }

        .show-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .price {
            font-size: 20px;
            font-weight: 700;
            color: #10b981;
        }

        .seats-info {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #94a3b8;
            font-size: 14px;
        }

        .seats-available {
            background: rgba(16, 185, 129, 0.2);
            color: #6ee7b7;
            padding: 5px 12px;
            border-radius: 6px;
            font-weight: 600;
        }

        .seats-limited {
            background: rgba(251, 146, 60, 0.2);
            color: #fdba74;
            padding: 5px 12px;
            border-radius: 6px;
            font-weight: 600;
        }

        .btn-select {
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            font-size: 14px;
        }

        .btn-select:hover {
            box-shadow: 0 5px 15px rgba(99, 102, 241, 0.4);
        }

        .no-shows {
            text-align: center;
            padding: 80px 50px;
            color: #64748b;
        }

        .no-shows i {
            font-size: 60px;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .message {
            padding: 18px 24px;
            border-radius: 12px;
            margin-bottom: 30px;
            text-align: center;
            font-weight: 600;
        }

        .error {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            color: #991b1b;
            border: 2px solid #fca5a5;
        }

        @media (max-width: 768px) {
            .movie-header {
                flex-direction: column;
                text-align: center;
            }

            .shows-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navigation -->
        <div class="navbar">
            <div class="logo">
                <i class="fas fa-ticket-alt"></i>
                Smart Ticketing
            </div>
            <asp:HyperLink ID="lnkBack" runat="server" NavigateUrl="~/Movies.aspx" CssClass="btn-back">
                <i class="fas fa-arrow-left"></i> Back to Movies
            </asp:HyperLink>
        </div>

        <div class="container">
            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="message">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>

            <!-- Movie Header -->
            <asp:Panel ID="pnlMovieHeader" runat="server" CssClass="movie-header">
                <asp:Image ID="imgPoster" runat="server" CssClass="movie-poster-small" />
                <div class="movie-details">
                    <h1 class="movie-title">
                        <asp:Label ID="lblMovieTitle" runat="server"></asp:Label>
                    </h1>
                    <div class="movie-meta-row">
                        <div class="meta-badge">
                            <i class="fas fa-star"></i>
                            <asp:Label ID="lblRating" runat="server"></asp:Label>
                        </div>
                        <div class="meta-badge">
                            <i class="fas fa-clock"></i>
                            <asp:Label ID="lblDuration" runat="server"></asp:Label> min
                        </div>
                        <div class="meta-badge">
                            <i class="fas fa-language"></i>
                            <asp:Label ID="lblLanguage" runat="server"></asp:Label>
                        </div>
                        <div class="meta-badge">
                            <i class="fas fa-film"></i>
                            <asp:Label ID="lblGenre" runat="server"></asp:Label>
                        </div>
                    </div>
                    <p class="movie-description">
                        <asp:Label ID="lblDescription" runat="server"></asp:Label>
                    </p>
                </div>
            </asp:Panel>

            <!-- Shows Section -->
            <h2 class="section-title">
                <i class="fas fa-calendar-alt"></i>
                Select Show Time
            </h2>

            <asp:Panel ID="pnlNoShows" runat="server" Visible="false" CssClass="no-shows">
                <i class="fas fa-calendar-times"></i>
                <h3>No shows available</h3>
                <p>Please check back later for new showtimes</p>
            </asp:Panel>

            <asp:Repeater ID="rptDates" runat="server" OnItemDataBound="rptDates_ItemDataBound">
                <ItemTemplate>
                    <div class="date-group">
                        <div class="date-header">
                            <i class="fas fa-calendar-day"></i>
                            <%# Convert.ToDateTime(Eval("ShowDate")).ToString("dddd, MMMM dd, yyyy") %>
                        </div>
                        
                        <div class="shows-grid">
                            <asp:Repeater ID="rptShows" runat="server" OnItemCommand="rptShows_ItemCommand">
                                <ItemTemplate>
                                    <div class="show-card">
                                        <div class="show-time">
                                            <i class="fas fa-clock"></i>
                                            <%# DateTime.Today.Add((TimeSpan)Eval("ShowTime")).ToString("hh:mm tt") %>


                                        </div>
                                        
                                        <div class="theater-info">
                                            <div class="theater-name">
                                                <i class="fas fa-building"></i>
                                                <%# Eval("TheaterName") %>
                                            </div>
                                            <div class="theater-location">
                                                <i class="fas fa-map-marker-alt"></i>
                                                <%# Eval("Location") %>
                                            </div>
                                        </div>

                                        <div class="show-details">
                                            <div>
                                                <div class="price">
                                                    ₹<%# Eval("TicketPrice", "{0:N2}") %>
                                                </div>
                                                <div class="seats-info">
                                                    <asp:Label ID="lblSeatsLabel" runat="server" 
                                                        CssClass='<%# Convert.ToInt32(Eval("AvailableSeats")) > 50 ? "seats-available" : "seats-limited" %>'>
                                                        <%# Eval("AvailableSeats") %> seats
                                                    </asp:Label>
                                                </div>
                                            </div>
                                            
                                            <asp:Button ID="btnSelectShow" runat="server" 
                                                Text="Select" 
                                                CssClass="btn-select"
                                                CommandName="SelectShow"
                                                CommandArgument='<%# Eval("ShowId") %>'
                                                Enabled='<%# Convert.ToInt32(Eval("AvailableSeats")) > 0 %>' />
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>