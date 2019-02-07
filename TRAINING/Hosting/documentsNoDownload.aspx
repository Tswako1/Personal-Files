<%@ Page Language="C#" AutoEventWireup="true" CodeFile="documents.aspx.cs" Inherits="documents" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 318px;
        }
        .auto-style2 {
            margin-right: 0px;
        }
    </style>
</head>
<body style="height: 453px">
    <form id="form1" runat="server" class="auto-style1">
        <div>
        </div>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Policies" />
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Leave Forms" />
        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Change Rquest Forms" />
        <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="Open Selected File" />
        <asp:TreeView ID="TreeView1" runat="server" CssClass="auto-style2" Height="266px" Width="314px">
        </asp:TreeView>
        
    </form>
</body>
</html>
