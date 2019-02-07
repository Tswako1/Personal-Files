<%@ Page Language="C#" AutoEventWireup="true" CodeFile="search.aspx.cs" Inherits="search" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link rel="stylesheet" href="bootstrap-3.3.7/css/bootstrap.min.css"/>

</head>
<body>

        <form id="form1" runat="server">

<div class="navbar navbar-default navbar-static-top" role="navigation">
    <div class="container">
 
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="search.aspx">Home</a>
			
        </div>
 
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active">
                    <a href="search.aspx">Home</a>
                </li>
                <li>
                    <a href="WebForm1.aspx">Documents</a>
                </li>
                <li>
                    <a href="contact.aspx">Administrator</a>
                </li>
            </ul>
        </div><!--/.nav-collapse -->
 
    </div>
</div>

<div class="container">

<div class="col-md-12">
    <div class="page-header">
        <h1>MISA SEARCH CONTACTS FORM</h1>
    </div>
</div>

<div class="col-md-12">
    <div class="alert alert-info">
        <strong>Heads up!</strong> Enter name and click search button </a>!
    </div>
</div>

<div class="auto-style1">
 
    <table class='table table-hover table-responsive table-bordered'>
 
        <tr>
            <td>Name</td>
            <td><input type='text' name='name' class='form-control'></td>
        </tr>
 
       
 
    </table>
    <div>
        <td>
                <asp:Button ID="inputSearch" runat="server" Text="Search " Width="87px" OnClick="Search_Click" />
            </td></div>


     <div class="col-md-12">
        <div class="panel-heading">
            <h3>List of results</h3>

        </div>
        
		<div class="auto-style1">
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Search" />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" EmptyDataText="There are no data records to display." ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Mobile" HeaderText="Mobile" SortExpression="Mobile" />
                    <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                <SortedAscendingCellStyle BackColor="#FDF5AC" />
                <SortedAscendingHeaderStyle BackColor="#4D0000" />
                <SortedDescendingCellStyle BackColor="#FCF6C0" />
                <SortedDescendingHeaderStyle BackColor="#820000" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ASPCRUDConnectionString %>" SelectCommand="SELECT [Name], [Mobile], [Address] FROM [Contact] WHERE ([Name] LIKE '%' + @Name + '%')">
                <SelectParameters>
                    <asp:ControlParameter ControlID="TextBox1" Name="Name" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
		

        </div>

    </div>


</div>
   
 
</div>
 
 
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
