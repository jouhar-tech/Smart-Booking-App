<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SeatSelection.aspx.cs" Inherits="UserCRUDApp.SeatSelection" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Select Seats - Smart Ticketing</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        * {margin:0;padding:0;box-sizing:border-box;}
        body {font-family:'Poppins',sans-serif;background:#0f172a;min-height:100vh;}

        .navbar {
            background:linear-gradient(135deg,#1e293b 0%,#0f172a 100%);
            padding:20px 50px;
            display:flex;
            justify-content:space-between;
            align-items:center;
            box-shadow:0 4px 20px rgba(0,0,0,0.5);
            border-bottom:2px solid rgba(99,102,241,0.3);
        }
        .logo {font-size:28px;font-weight:800;
            background:linear-gradient(135deg,#6366f1 0%,#8b5cf6 100%);
            -webkit-background-clip:text;-webkit-text-fill-color:transparent;}
        .btn-back {
            background:linear-gradient(135deg,#64748b 0%,#475569 100%);
            color:white;padding:10px 25px;border:none;border-radius:8px;
            cursor:pointer;font-weight:600;transition:.3s;text-decoration:none;
            display:inline-flex;align-items:center;gap:10px;
        }
        .btn-back:hover {transform:translateY(-2px);box-shadow:0 5px 15px rgba(100,116,139,0.4);}
        .container {max-width:1400px;margin:50px auto;padding:0 50px;display:grid;grid-template-columns:1fr 400px;gap:40px;}
        .seat-section {
            background:rgba(30,41,59,0.6);border-radius:16px;padding:40px;
            border:1px solid rgba(255,255,255,0.1);
        }
        .screen {
            background:linear-gradient(180deg,#6366f1 0%,#8b5cf6 100%);
            height:8px;border-radius:50px;margin-bottom:50px;position:relative;
            box-shadow:0 10px 40px rgba(99,102,241,0.5);
        }
        .screen::before {
            content:'SCREEN';position:absolute;top:-30px;left:50%;transform:translateX(-50%);
            color:#6366f1;font-weight:700;font-size:14px;letter-spacing:3px;
        }
        .seats-grid {display:grid;gap:15px;justify-content:center;}
        .seat-row {display:flex;gap:10px;align-items:center;}
        .row-label {color:#6366f1;font-weight:700;width:30px;text-align:center;}
        .seat {
            width:40px;height:40px;background:rgba(99,102,241,0.2);
            border:2px solid rgba(99,102,241,0.5);
            border-radius:8px;cursor:pointer;transition:.3s;
            display:flex;align-items:center;justify-content:center;
            color:#6366f1;font-weight:600;font-size:12px;
        }
        .seat:hover {background:rgba(99,102,241,0.4);transform:scale(1.1);}
        .seat.selected {
            background:linear-gradient(135deg,#10b981 0%,#059669 100%);
            border-color:#10b981;color:white;box-shadow:0 0 20px rgba(16,185,129,0.5);
        }
        .seat.occupied {
            background:rgba(100,116,139,0.3);
            border-color:#64748b;cursor:not-allowed;color:#64748b;
        }
        .seat.occupied:hover {transform:none;}

        .legend {display:flex;gap:30px;justify-content:center;margin-top:40px;flex-wrap:wrap;}
        .legend-item {display:flex;align-items:center;gap:10px;color:#94a3b8;}
        .legend-box {width:30px;height:30px;border-radius:6px;}
        .legend-available {background:rgba(99,102,241,0.2);border:2px solid rgba(99,102,241,0.5);}
        .legend-selected {background:linear-gradient(135deg,#10b981 0%,#059669 100%);}
        .legend-occupied {background:rgba(100,116,139,0.3);border:2px solid #64748b;}

        .booking-summary {
            background:rgba(30,41,59,0.6);border-radius:16px;padding:30px;
            border:1px solid rgba(255,255,255,0.1);height:fit-content;position:sticky;top:20px;
        }
        .summary-title {color:white;font-size:24px;font-weight:700;margin-bottom:25px;padding-bottom:15px;border-bottom:2px solid rgba(99,102,241,0.3);}
        .movie-info-summary {margin-bottom:25px;}
        .info-row {display:flex;justify-content:space-between;margin-bottom:12px;color:#94a3b8;}
        .info-label {font-weight:500;}
        .info-value {color:white;font-weight:600;}
        .selected-seats-info {background:rgba(99,102,241,0.1);border-radius:12px;padding:20px;margin-bottom:20px;}
        .seats-count {color:white;font-size:18px;font-weight:700;margin-bottom:10px;}
        .seat-numbers {color:#6366f1;font-weight:600;font-size:14px;}

        .price-breakdown {background:linear-gradient(135deg,#1e293b 0%,#0f172a 100%);
            border-radius:12px;padding:20px;margin-bottom:25px;}
        .price-row {display:flex;justify-content:space-between;margin-bottom:12px;color:#94a3b8;}
        .total-row {display:flex;justify-content:space-between;padding-top:15px;border-top:2px solid rgba(99,102,241,0.3);margin-top:15px;}
        .total-label {color:white;font-size:18px;font-weight:700;}
        .total-amount {color:#10b981;font-size:24px;font-weight:800;}

        .btn-book {width:100%;background:linear-gradient(135deg,#10b981 0%,#059669 100%);
            color:white;padding:16px;border:none;border-radius:12px;font-size:18px;font-weight:700;
            cursor:pointer;transition:.3s;text-transform:uppercase;letter-spacing:1px;}
        .btn-book:hover {transform:translateY(-3px);box-shadow:0 10px 30px rgba(16,185,129,0.4);}
        .btn-book:disabled {background:linear-gradient(135deg,#64748b 0%,#475569 100%);cursor:not-allowed;transform:none;}

        .message {padding:18px 24px;border-radius:12px;margin-bottom:30px;text-align:center;font-weight:600;grid-column:1 / -1;}
        .success {background:linear-gradient(135deg,#d1fae5 0%,#a7f3d0 100%);color:#065f46;border:2px solid #6ee7b7;}
        .error {background:linear-gradient(135deg,#fee2e2 0%,#fecaca 100%);color:#991b1b;border:2px solid #fca5a5;}

        @media (max-width:1024px){.container{grid-template-columns:1fr;}.booking-summary{position:static;}}
        @media (max-width:768px){.seat{width:35px;height:35px;}.container{padding:30px 20px;}}
    </style>

    <script type="text/javascript">
        var selectedSeats = [];
        var ticketPrice = 0;

        // called from C# with actual price
        function initializeSeatSelection(price) {
            ticketPrice = parseFloat(price) || 0;
            updateSummary();
        }

        function toggleSeat(seatNumber, element) {
            if (element.classList.contains('occupied')) return;

            var idx = selectedSeats.indexOf(seatNumber);
            if (idx > -1) {
                selectedSeats.splice(idx, 1);
                element.classList.remove('selected');
            } else {
                if (selectedSeats.length >= 10) {
                    alert('You can select maximum 10 seats at a time');
                    return;
                }
                selectedSeats.push(seatNumber);
                element.classList.add('selected');
            }
            updateSummary();
        }

        function updateSummary() {
            var count = selectedSeats.length;
            var total = count * ticketPrice;

            document.getElementById('<%= lblSeatsCount.ClientID %>').innerText = count + ' Seats Selected';
            document.getElementById('<%= lblSeatNumbers.ClientID %>').innerText = count > 0 ? selectedSeats.sort().join(', ') : 'No seats selected';
            document.getElementById('<%= lblTicketCount.ClientID %>').innerText = count + ' x ₹' + ticketPrice.toFixed(2);
            document.getElementById('<%= lblTotalAmount.ClientID %>').innerText = '₹' + total.toFixed(2);
            document.getElementById('<%= hfSelectedSeats.ClientID %>').value = selectedSeats.join(',');

            document.getElementById('<%= btnBookNow.ClientID %>').disabled = count === 0;
        }
    </script>
</head>
<body>
<form id="form1" runat="server">
    <asp:HiddenField ID="hfSelectedSeats" runat="server" />

    <!-- Navigation -->
    <div class="navbar">
        <div class="logo">
            <i class="fas fa-ticket-alt"></i> Smart Ticketing
        </div>
        <asp:Button ID="btnBack" runat="server" Text="← Back" CssClass="btn-back" OnClick="btnBack_Click" />
    </div>

    <div class="container">
        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="message">
            <asp:Label ID="lblMessage" runat="server"></asp:Label>
        </asp:Panel>

        <!-- Seat Selection -->
        <div class="seat-section">
            <div class="screen"></div>
            <div class="seats-grid" id="seatsGrid">
                <asp:Literal ID="litSeats" runat="server"></asp:Literal>
            </div>

            <div class="legend">
                <div class="legend-item"><div class="legend-box legend-available"></div><span>Available</span></div>
                <div class="legend-item"><div class="legend-box legend-selected"></div><span>Selected</span></div>
                <div class="legend-item"><div class="legend-box legend-occupied"></div><span>Occupied</span></div>
            </div>
        </div>

        <!-- Booking Summary -->
        <div class="booking-summary">
            <h2 class="summary-title">Booking Summary</h2>

            <div class="movie-info-summary">
                <div class="info-row">
                    <span class="info-label">Movie:</span>
                    <span class="info-value"><asp:Label ID="lblMovieTitle" runat="server"></asp:Label></span>
                </div>
                <div class="info-row">
                    <span class="info-label">Theater:</span>
                    <span class="info-value"><asp:Label ID="lblTheater" runat="server"></asp:Label></span>
                </div>
                <div class="info-row">
                    <span class="info-label">Date:</span>
                    <span class="info-value"><asp:Label ID="lblShowDate" runat="server"></asp:Label></span>
                </div>
                <div class="info-row">
                    <span class="info-label">Time:</span>
                    <span class="info-value"><asp:Label ID="lblShowTime" runat="server"></asp:Label></span>
                </div>
            </div>

            <div class="selected-seats-info">
                <div class="seats-count">
                    <i class="fas fa-chair"></i>
                    <asp:Label ID="lblSeatsCount" runat="server" Text="0 Seats Selected"></asp:Label>
                </div>
                <div class="seat-numbers">
                    <asp:Label ID="lblSeatNumbers" runat="server" Text="No seats selected"></asp:Label>
                </div>
            </div>

            <div class="price-breakdown">
                <div class="price-row">
                    <span>Tickets:</span>
                    <span><asp:Label ID="lblTicketCount" runat="server" Text="0 x ₹0.00"></asp:Label></span>
                </div>
                <div class="total-row">
                    <span class="total-label">Total:</span>
                    <span class="total-amount"><asp:Label ID="lblTotalAmount" runat="server" Text="₹0.00"></asp:Label></span>
                </div>
            </div>

            <asp:Button ID="btnBookNow" runat="server" Text="Book Now"
                CssClass="btn-book" OnClick="btnBookNow_Click"
                OnClientClick="return confirm('Confirm booking?');" />
        </div>
    </div>
</form>
</body>
</html>
