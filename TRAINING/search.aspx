<%@ Page Language="C#" AutoEventWireup="true" CodeFile="search.aspx.cs" Inherits="search" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link rel="stylesheet" href="bootstrap-3.3.7/css/bootstrap.min.css"/>

<div id="header">
        <div class="header-wrap">
            <div class="calligraphy-wrapper">
                <div class="calligraphy">
				
				<div class="topline"></div>

            
	<img src="images/MISA Logo Dec 2013.jpg" width="320" height="100">
				
				
				</div>

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
            <a class="navbar-brand" href="Index.html">Home</a>
			
        </div>
 
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active">
                  
                <a href='https://www.dropbox.com/sh/f7ow38fj3112l1e/AAAn2U97TCC-uSSFI9XLe99Ja?dl=0'">Share Folder</a>
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
        <div class="col-md-12">
            <div class="col-xs-10">
                <asp:GridView CssClass="table table-bordered"
                    ID="gvSearchResults" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource">
                    <Columns>
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="Mobile" HeaderText="Mobile" SortExpression="Mobile" />
                        <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                    </Columns>

                </asp:GridView>

                <asp:SqlDataSource ID="SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ASPCRUDConnectionString %>" SelectCommand="SELECT [Name], [Mobile], [Address] FROM [Contact]"></asp:SqlDataSource>

                <asp:SqlDataSource ID="SqlDataSource2" runat="server"></asp:SqlDataSource>

                
            </div>

        </div>

    </div>


</div>
   
 
</div>
 
<div class="clear">
              <p>&nbsp;</p>
              <table width="922" border="0">
                <tr>
                  <td width="385"><img src="images/dragon_logo.png" width="389" height="115"></td>
                  <td width="521"><div align="right"><img src="images/MISA Logo Dec 2013.jpg" width="307" height="94"></div></td>
                </tr>
              </table>
              <p>&nbsp;</p>
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
