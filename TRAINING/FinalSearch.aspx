<%@ Page Language="C#" AutoEventWireup="true" CodeFile="search.aspx.cs" Inherits="search" %>

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
    

    <style type="text/css">
        .auto-style1 {
            position: relative;
            min-height: 1px;
            float: left;
            width: 1187px;
            left: 0px;
            top: 0px;
            padding-left: 15px;
            padding-right: 15px;
        }
    </style>
    

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
                    <a href="https://www.dropbox.com/sh/d9ykrg5csdzlq3p/AABg-6E_ZiwEQ26GOVLELYfKa?dl=0">Share Folders</a>
                </li>
                <li>
                    <a href="WebForm1.aspx">Documents</a>
                </li>
                <li>
                    <a href="contact.aspx">Administrator</a>
                </li>
<li>
                    <a href="test.html">Sub Folders</a>
                </li>
<li>
                    <a href="documents.aspx">Policies</a>
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

<div class="auto-style1">
    <div class="alert alert-info">
        <strong>Heads up!</strong> Enter name and click search button </a>!
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" EmptyDataText="There are no data records to display." ForeColor="#333333" GridLines="None" Width="1119px" >
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="Organisation" HeaderText="Organisation" SortExpression="Organisation" />
                    <asp:BoundField DataField="ContractAmount" HeaderText="ContractAmount" SortExpression="ContractAmount" />
                    <asp:BoundField DataField="AmountPaid" HeaderText="AmountPaid" SortExpression="AmountPaid" />
                    <asp:BoundField DataField="ProgressStatus" HeaderText="ProgressStatus" SortExpression="ProgressStatus" />
					<asp:BoundField DataField="StartDate" HeaderText="StartDate" SortExpression="StartDate" />
					<asp:BoundField DataField="DateOfCompletion" HeaderText="DateOfCompletion" SortExpression="DateOfCompletion" />
					<asp:BoundField DataField="ActualDateOfCompletion" HeaderText="ActualDateOfCompletion" SortExpression="ActualDateOfCompletion" />
					<asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks" />
					<asp:TemplateField></asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFFBD6" ForeColor="#333333"  HorizontalAlign="Left"/>
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                <SortedAscendingCellStyle BackColor="#FDF5AC" />
                <SortedAscendingHeaderStyle BackColor="#4D0000" />
                <SortedDescendingCellStyle BackColor="#FCF6C0" />
                <SortedDescendingHeaderStyle BackColor="#820000" />
            </asp:GridView>
    </div>
</div>


 
    <table class='table table-hover table-responsive table-bordered'>
 
        <tr>

   
        
	
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Search" />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:db %>" SelectCommand="SELECT [Organisation], [ContractAmount], [AmountPaid],
			[ProgressStatus],[StartDate],[DateOfCompletion],[ActualDateOfCompletion],[Remarks] FROM [Contact] WHERE ([Organisation] LIKE '%' + @Organisation + '%')">
                <SelectParameters>
                    <asp:ControlParameter ControlID="TextBox1" Name="Organisation" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>

            

        </tr>
 
       
 
    </table>
    
		

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
