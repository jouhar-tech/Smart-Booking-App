<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookingConfirmation.aspx.cs" Inherits="UserCRUDApp.BookingConfirmation" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Booking Confirmed - Smart Ticketing</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 50px;
        }

        .confirmation-container {
            max-width: 700px;
            width: 100%;
            background: rgba(30, 41, 59, 0.8);
            border-radius: 24px;
            padding: 50px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .success-icon {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
            animation: scaleIn 0.5s ease-out 0.3s both;
        }

        @keyframes scaleIn {
            from {
                transform: scale(0);
            }
            to {
                transform: scale(1);
            }
        }

        .success-icon i {
            font-size: 50px;
            color: white;
        }

        .success-title {
            color: white;
            font-size: 32px;
            font-weight: 800;
            text-align: center;
            margin-bottom: 15px;
        }

        .success-subtitle {
            color: #94a3b8;
            text-align: center;
            margin-bottom: 40px;
            font-size: 16px;
        }

        .booking-reference {
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            padding: 20px;
            border-radius: 12px;
            text-align: center;
            margin-bottom: 40px;
        }

        .ref-label {
            color: rgba(255, 255, 255, 0.8);
            font-size: 14px;
            margin-bottom: 8px;
        }

        .ref-number {
            color: white;
            font-size: 28px;
            font-weight: 800;
            letter-spacing: 2px;
        }

        .booking-details {
            background: rgba(15, 23, 42, 0.6);
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 30px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            color: #94a3b8;
            font-weight: 500;
        }

        .detail-value {
            color: white;
            font-weight: 600;
            text-align: right;
        }

        .seats-display {
            background: rgba(99, 102, 241, 0.2);
            padding: 12px 20px;
            border-radius: 8px;
            color: #6366f1;
            font-weight: 700;
        }

        .total-amount {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
        }

        .amount-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .amount-label {
            color: white;
            font-size: 20px;
            font-weight: 700;
        }

        .amount-value {
            color: #10b981;
            font-size: 32px;
            font-weight: 800;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 16px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            text-align: center;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.4);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #64748b 0%, #475569 100%);
            color: white;
        }

        .btn-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(100, 116, 139, 0.4);
        }

        @media (max-width: 768px) {
            .confirmation-container {
                padding: 30px;
            }

            .action-buttons {
                flex-direction: column;
            }

            .success-title {
                font-size: 24px;
            }

            .ref-number {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="confirmation-container">
            <div class="success-icon">
                <i class="fas fa-check"></i>
            </div>

            <h1 class="success-title">🎉 Booking Confirmed!</h1>
            <p class="success-subtitle">Your tickets have been booked successfully</p>

            <div class="booking-reference">
                <div class="ref-label">Booking Reference</div>
                <div class="ref-number">
                    <asp:Label ID="lblBookingRef" runat="server"></asp:Label>
                </div>
            </div>

            <div class="booking-details">
                <div class="detail-row">
                    <span class="detail-label">Movie</span>
                    <span class="detail-value">
                        <asp:Label ID="lblMovieTitle" runat="server"></asp:Label>
                    </span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Theater</span>
                    <span class="detail-value">
                        <asp:Label ID="lblTheater" runat="server"></asp:Label>
                    </span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Date & Time</span>
                    <span class="detail-value">
                        <asp:Label ID="lblDateTime" runat="server"></asp:Label>
                    </span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Seats</span>
                    <span class="detail-value seats-display">
                        <asp:Label ID="lblSeats" runat="server"></asp:Label>
                    </span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Number of Tickets</span>
                    <span class="detail-value">
                        <asp:Label ID="lblTicketCount" runat="server"></asp:Label>
                    </span>
                </div>
            </div>

            <div class="total-amount">
                <div class="amount-row">
                    <span class="amount-label">Total Amount Paid</span>
                    <span class="amount-value">
                        ₹<asp:Label ID="lblTotalAmount" runat="server"></asp:Label>
                    </span>
                </div>
            </div>

            <div class="action-buttons">
                <asp:HyperLink ID="lnkMyBookings" runat="server" 
                    NavigateUrl="~/MyBookings.aspx" 
                    CssClass="btn btn-primary">
                    View My Bookings
                </asp:HyperLink>
                <asp:HyperLink ID="lnkMovies" runat="server" 
                    NavigateUrl="~/Movies.aspx" 
                    CssClass="btn btn-secondary">
                    Book More Tickets
                </asp:HyperLink>
            </div>
        </div>
    </form>
</body>
</html>