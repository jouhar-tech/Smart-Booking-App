<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="UserCRUDApp.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard - User Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .header {
            background: white;
            padding: 20px 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            animation: slideDown 0.5s ease-out;
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

        .header h1 {
            color: #333;
            font-size: 26px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .welcome {
            color: #667eea;
            font-weight: 600;
        }

        .btn-logout {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            transition: transform 0.2s ease;
        }

        .btn-logout:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(245, 87, 108, 0.4);
        }

        .container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            animation: fadeIn 0.6s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 3px solid #667eea;
        }

        .message {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: 500;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .gridview {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            overflow: hidden;
            border-radius: 8px;
        }

        .gridview th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
        }

        .gridview td {
            padding: 12px 15px;
            border-bottom: 1px solid #e0e0e0;
        }

        .gridview tr:hover {
            background-color: #f5f5f5;
            transition: background-color 0.3s ease;
        }

        .gridview .btn-action {
            padding: 6px 15px;
            margin: 0 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-edit {
            background-color: #4CAF50;
            color: white;
        }

        .btn-edit:hover {
            background-color: #45a049;
            transform: translateY(-2px);
        }

        .btn-delete {
            background-color: #f44336;
            color: white;
        }

        .btn-delete:hover {
            background-color: #da190b;
            transform: translateY(-2px);
        }

        .form-section {
            background: #f9f9f9;
            padding: 25px;
            border-radius: 8px;
            margin-bottom: 30px;
            border: 2px solid #e0e0e0;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            color: #555;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 10px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-cancel {
            background: #6c757d;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            margin-left: 10px;
            transition: all 0.3s ease;
        }

        .btn-cancel:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }

        .no-data {
            text-align: center;
            padding: 30px;
            color: #999;
            font-size: 16px;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .stat-card h3 {
            font-size: 36px;
            margin-bottom: 10px;
        }

        .stat-card p {
            font-size: 14px;
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <h1>🎯 User Management Dashboard</h1>
            <div class="user-info">
                <span class="welcome">Welcome, <asp:Label ID="lblUsername" runat="server"></asp:Label>!</span>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" 
                    CssClass="btn-logout" OnClick="btnLogout_Click" />
            </div>
        </div>

        <div class="container">
            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="message">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>

            <div class="stats">
                <div class="stat-card">
                    <h3><asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label></h3>
                    <p>Total Users</p>
                </div>
            </div>

            <!-- Update Form (Initially Hidden) -->
            <asp:Panel ID="pnlUpdateForm" runat="server" Visible="false" CssClass="form-section">
                <h2>✏️ Update User</h2>
                <asp:HiddenField ID="hfUserId" runat="server" />
                
                <div class="form-group">
                    <label>Username</label>
                    <asp:TextBox ID="txtUpdateUsername" runat="server" CssClass="form-control" 
                        placeholder="Enter username"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <asp:TextBox ID="txtUpdateEmail" runat="server" CssClass="form-control" 
                        TextMode="Email" placeholder="Enter email"></asp:TextBox>
                </div>

                <asp:Button ID="btnUpdate" runat="server" Text="Update User" 
                    CssClass="btn-submit" OnClick="btnUpdate_Click" />
                <asp:Button ID="btnCancelUpdate" runat="server" Text="Cancel" 
                    CssClass="btn-cancel" OnClick="btnCancelUpdate_Click" />
            </asp:Panel>

            <h2>👥 All Users</h2>
            
            <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" 
                CssClass="gridview" OnRowCommand="gvUsers_RowCommand"
                EmptyDataText="No users found.">
                <Columns>
                    <asp:BoundField DataField="UserId" HeaderText="ID" />
                    <asp:BoundField DataField="Username" HeaderText="Username" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" 
                        DataFormatString="{0:MM/dd/yyyy}" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" Text="Edit" 
                                CommandName="EditUser" CommandArgument='<%# Eval("UserId") %>' 
                                CssClass="btn-action btn-edit" />
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" 
                                CommandName="DeleteUser" CommandArgument='<%# Eval("UserId") %>' 
                                CssClass="btn-action btn-delete" 
                                OnClientClick="return confirm('Are you sure you want to delete this user?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>