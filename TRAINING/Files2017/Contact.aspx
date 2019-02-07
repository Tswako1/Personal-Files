<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContactStilTEsting.aspx.cs" Inherits="Contact" %>

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

      <table class='table table-hover table-responsive table-bordered'>
 
        <tr>
           

            <div>

               <asp:HiddenField ID="hfContactID" runat="server" OnValueChanged="hfContactID_ValueChanged" />
            
                <td>
                        <asp:Label ID="Label1" runat="server" Text="Name"></asp:Label>

                    </td>
                    <td colspan="2" class="auto-style2">

                        <asp:TextBox ID="txtName" runat="server"></asp:TextBox>

                    </td>

                </tr>

                <tr>
                    
                    <td>

                        <asp:Label ID="Label2" runat="server" Text="Mobile"></asp:Label>

                    </td>
                    <td colspan="2" class="auto-style2">

                        <asp:TextBox ID="txtMobile" runat="server"></asp:TextBox>

                    </td>

                </tr>


                <tr>
                    
                    <td>

                        <asp:Label ID="Label3" runat="server" Text="Address"></asp:Label>

                    </td>
                    <td colspan="2" class="auto-style2">

                        <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine"></asp:TextBox>

                    </td>

                </tr>

                
                <tr>
                    
                    <td>

                        &nbsp;</td>
                    <td colspan="2" class="auto-style2">

                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" />
                        <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" />

                        

                    </td>

                </tr>


                <td>

                    </td>
                    <td colspan="2" class="auto-style2">

                        <asp:Label ID="lblSuccessMessage" runat="server" Text="" ForeColor="Green"></asp:Label>

                    </td>

                </tr>

                <td>

                    &nbsp;</td>
                    <td colspan="2" class="auto-style2">

                         <asp:Label ID="lblErrorMessage" runat="server" Text="" ForeColor="Red" ></asp:Label>
                    </td>

                </tr>
                
                

                     

                

           
            <input type="button" onclick="window.open('index.html', 'Done Capturing');"/>
            <br />
            

            <asp:GridView ID="gvContact" runat="server" AutoGenerateColumns="false"> 
           
            <Columns>

                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="Mobile" HeaderText="Mobile" />
                <asp:BoundField DataField="Address" HeaderText="Address" />

                <asp:TemplateField>
                    <ItemTemplate>


                <asp:LinkButton ID="lnkview" runat="server" CommandArgument='<%# Eval("ContactID") %>' OnClick="lnk_Onclick">view</asp:LinkButton>
                    
                    </ItemTemplate>

                </asp:TemplateField>
                  
            </Columns>
                </asp:GridView>


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
