<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Movies.aspx.cs" Inherits="UserCRUDApp.Movies" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Smart Ticketing - Movies</title>
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

        /* Navigation Bar */
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
            background-clip: text;
        }

        .logo i {
            margin-right: 10px;
            color: #6366f1;
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

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            padding: 60px 50px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 30% 50%, rgba(99, 102, 241, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 70% 50%, rgba(139, 92, 246, 0.1) 0%, transparent 50%);
            pointer-events: none;
        }

        .hero h1 {
            color: white;
            font-size: 48px;
            font-weight: 800;
            margin-bottom: 20px;
            position: relative;
            z-index: 1;
        }

        .hero p {
            color: #94a3b8;
            font-size: 18px;
            position: relative;
            z-index: 1;
        }

        /* Container */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 50px;
        }

        .section-title {
            color: white;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 30px;
            position: relative;
            padding-bottom: 15px;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 80px;
            height: 4px;
            background: linear-gradient(90deg, #6366f1 0%, #8b5cf6 100%);
            border-radius: 2px;
        }

        /* Movies Grid */
        .movies-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }

        .movie-card {
            background: rgba(30, 41, 59, 0.6);
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid rgba(255, 255, 255, 0.1);
            cursor: pointer;
            position: relative;
        }

        .movie-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.3);
            border-color: rgba(99, 102, 241, 0.5);
        }

        .movie-poster {
            width: 100%;
            height: 400px;
            object-fit: cover;
            transition: transform 0.4s ease;
        }

        .movie-card:hover .movie-poster {
            transform: scale(1.05);
        }

        .movie-info {
            padding: 20px;
        }

        .movie-title {
            color: white;
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 10px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .movie-meta {
            display: flex;
            gap: 15px;
            margin-bottom: 10px;
            flex-wrap: wrap;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
            color: #94a3b8;
            font-size: 13px;
        }

        .meta-item i {
            color: #6366f1;
        }

        .rating {
            display: flex;
            align-items: center;
            gap: 5px;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            padding: 5px 12px;
            border-radius: 6px;
            color: white;
            font-weight: 700;
            font-size: 14px;
        }

        .genre {
            color: #94a3b8;
            font-size: 14px;
            margin-bottom: 15px;
        }

        .btn-book {
            width: 100%;
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 15px;
        }

        .btn-book:hover {
            box-shadow: 0 5px 15px rgba(99, 102, 241, 0.4);
            transform: translateY(-2px);
        }

        .message {
            padding: 18px 24px;
            border-radius: 12px;
            margin-bottom: 30px;
            text-align: center;
            font-weight: 600;
            animation: slideDown 0.4s ease-out;
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

        .no-movies {
            text-align: center;
            padding: 100px 50px;
            color: #64748b;
        }

        .no-movies i {
            font-size: 80px;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .navbar {
                padding: 15px 20px;
                flex-direction: column;
                gap: 20px;
            }

            .nav-links {
                flex-direction: column;
                gap: 15px;
            }

            .hero h1 {
                font-size: 32px;
            }

            .container {
                padding: 30px 20px;
            }

            .movies-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 20px;
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
                <asp:HyperLink ID="lnkMyBookings" runat="server" NavigateUrl="~/MyBookings.aspx" CssClass="nav-link">
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

        <!-- Hero Section -->
        <div class="hero">
            <h1>🎬 Book Your Favorite Movies</h1>
            <p>Experience cinema like never before with Smart Ticketing</p>
        </div>

        <!-- Main Content -->
        <div class="container">
            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="message">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>

            <h2 class="section-title">Now Showing</h2>

            <asp:Panel ID="pnlNoMovies" runat="server" Visible="false" CssClass="no-movies">
                <i class="fas fa-film"></i>
                <h3>No movies available at the moment</h3>
                <p>Please check back later for new releases</p>
            </asp:Panel>

            <div class="movies-grid">
                <asp:Repeater ID="rptMovies" runat="server" OnItemCommand="rptMovies_ItemCommand">
                    <ItemTemplate>
                        <div class="movie-card">
                            <img src='<%# Eval("PosterUrl") %>' alt='<%# Eval("Title") %>' class="movie-poster" />
                            <div class="movie-info">
                                <h3 class="movie-title"><%# Eval("Title") %></h3>
                                
                                <div class="movie-meta">
                                    <div class="rating">
                                        <i class="fas fa-star"></i>
                                        <%# Eval("Rating") %>
                                    </div>
                                    <div class="meta-item">
                                        <i class="fas fa-clock"></i>
                                        <%# Eval("Duration") %> min
                                    </div>
                                    <div class="meta-item">
                                        <i class="fas fa-language"></i>
                                        <%# Eval("Language") %>
                                    </div>
                                </div>

                                <div class="genre">
                                    <i class="fas fa-film"></i> <%# Eval("Genre") %>
                                </div>

                                <asp:Button ID="btnBookTicket" runat="server" 
                                    Text="Book Tickets" 
                                    CssClass="btn-book"
                                    CommandName="BookTicket"
                                    CommandArgument='<%# Eval("MovieId") %>' />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>
</body>
</html>