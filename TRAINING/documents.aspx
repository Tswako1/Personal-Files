<%@ Page Language="C#" AutoEventWireup="true" CodeFile="documents.aspx.cs" Inherits="documents" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Skip</title>

    <link rel="stylesheet" href="bootstrap-3.3.7/css/bootstrap.min.css"/>

<div id="header">
        <div class="header-wrap">
            <div class="calligraphy-wrapper">
                <div class="calligraphy">
				
				<div class="topline"></div>

            
	<img src="images/MISA Logo Dec 2013.jpg" width="320" height="100">
	<img style="float: right;" alt="" src="images/Ndp.jpg" width=6% height=6% />
				
				
				</div>
</head>

<div class="container">

<div class="col-md-12">
</div>
<body style="height: 453px">
    <form id="form1" runat="server" class="auto-style1">
        <div>
        </div>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Policies" />
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Leave Forms" />
        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Change Rquest Forms" />
        <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="Open Selected File" />
        <asp:TreeView ID="TreeView1" runat="server" CssClass="auto-style2" Height="280px" Width="869px">
        </asp:TreeView>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        SELECT TO DOWNLOAD<p>
        <asp:Button ID="Button6" runat="server" OnClick="Button6_Click" Text="1 TELEPHONE AND MOBILE POLICY.PDF" />
        <asp:Button ID="Button5" runat="server" OnClick="Button5_Click" Text="2 IT SECURITY POLICY" />
            <asp:Button ID="Button7" runat="server" OnClick="Button7_Click" Text="3 USE AND STANDARDIATION OF IT.PDF" />
            <asp:Button ID="Button8" runat="server" OnClick="Button8_Click" Text="4 IT EMAIL AND INTERNET ACCEPTABLE USE.PDF" />
            <asp:Button ID="Button9" runat="server" OnClick="Button9_Click" Text="5 CORPEERATE GOVERNANCE OF ICT Policy.pdf" />
        </p>
<script src="jquery-3.3.1.min.js"></script>
<script src="bootstrap-3.3.7/js/bootstrap.min.js"></script>

<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
