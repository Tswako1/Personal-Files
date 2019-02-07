<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>


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

<div class="col-md-12">
    <div class="alert alert-info">
        
		
		<a class="glyphicon glyphicon-home" href="Index.html" operation="Home" title="Home"></a>
		
		<a class="glyphicon glyphicon-leaf" href="http://10.116.66.74:8091/contact.aspx" operation="CreateProject" title="Alternative Project"></a>
		
		<a class="glyphicon glyphicon-filter" href="http://10.116.66.74:8091/FinalSearch.aspx" operation="Alternative Project" title="Alter"></a>
		
	</div>
</div>

      <table class='table table-hover table-responsive table-bordered'>
 
        <tr>
           

            <div>

               <asp:HiddenField ID="hfContactID" runat="server" OnValueChanged="hfContactID_ValueChanged" />
            
                <td>
                        <asp:Label ID="Label1" runat="server" Text="Organisation" label1="" required></asp:Label>
						
					

                    </td>
                    <td colspan="2" class="auto-style2">

                        <asp:TextBox ID="txtOrganisation" runat="server"></asp:TextBox>
						
						
					

						
								<asp:RequiredFieldValidator id="RequiredFieldValidator2"
                 ControlToValidate="txtOrganisation"
                 Text="Organisation is a required field"
                 ForeColor="red" 
                 runat=server>
				 </asp:RequiredFieldValidator> 
				 
				   
				 <asp:DropDownList ID="DdlMonths" runat="server">
    <asp:ListItem Enabled="true" Text="Select Month" Value="-1"></asp:ListItem>
    <asp:ListItem Text="January" Value="1"></asp:ListItem>
    <asp:ListItem Text="February" Value="2"></asp:ListItem>
    
    <asp:ListItem Text="December" Value="12"></asp:ListItem>
</asp:DropDownList>
				 
				 
						<td>
                        <asp:Label ID="Label5" runat="server" Text="StartDate" label1="" required></asp:Label>
						

                    </td>
                    <td colspan="2" class="auto-style2">
					
									 <asp:Calendar ID="Calendar1" runat="server"
        onselectionchanged="Calendar1_SelectionChanged"></asp:Calendar>
	


                        <asp:TextBox ID="txtStartDate" runat="server" ></asp:TextBox>

		

										<asp:RequiredFieldValidator id="RequiredFieldValidator3"
                 ControlToValidate="txtStartDate"
                 Text="StartDate is a required field"
                 ForeColor="red" 
                 runat=server>
				 </asp:RequiredFieldValidator> 

                    </td>
					

                </tr>

                <tr>
                    
                    <td>

                        <asp:Label ID="Label2" runat="server" Text="ContractAmount"></asp:Label>

                    </td>
                    <td colspan="2" class="auto-style2">

                        <asp:TextBox ID="txtContractAmount" runat="server"></asp:TextBox>
						
												<asp:RequiredFieldValidator id="RequiredFieldValidator4"
                 ControlToValidate="txtContractAmount"
                 Text="ContractAmount is a required field"
                 ForeColor="red" 
                 runat=server>
				 </asp:RequiredFieldValidator>

                    </td>
					
					
					 <td>

                        <asp:Label ID="Label6" runat="server" Text="DateOfCompletion"></asp:Label>

                    </td>
                    <td colspan="2" class="auto-style2">
					
					
					

                        <asp:TextBox ID="txtDateOfCompletion" runat="server"></asp:TextBox>
						
						
												<asp:RequiredFieldValidator id="RequiredFieldValidator5"
                 ControlToValidate="txtDateOfCompletion"
                 Text="DateOfCompletion is a required field"
                 ForeColor="red" 
                 runat=server>
				 </asp:RequiredFieldValidator>

                    </td>

                </tr>


                <tr>
                    
                    <td>

                        <asp:Label ID="Label3" runat="server" Text="AmountPaid"></asp:Label>

                    </td>
                    <td colspan="2" class="auto-style2">

                        <asp:TextBox ID="txtAmountPaid" runat="server" TextMode="MultiLine"></asp:TextBox>
						
												<asp:RequiredFieldValidator id="RequiredFieldValidator6"
                 ControlToValidate="txtAmountPaid"
                 Text="AmountPaid is a required field"
                 ForeColor="red" 
                 runat=server>
				 </asp:RequiredFieldValidator>

                    </td>

               
                    
                    <td>

                        <asp:Label ID="Label4" runat="server" Text="ProgressStatus"></asp:Label>

                    </td>
                    <td colspan="2" class="auto-style2">

                        <asp:TextBox ID="txtProgressStatus" runat="server" TextMode="MultiLine"></asp:TextBox>
												<asp:RequiredFieldValidator id="RequiredFieldValidator7"
                 ControlToValidate="txtProgressStatus"
                 Text="ProgressStatus is a required field"
                 ForeColor="red" 
                 runat=server>
				 </asp:RequiredFieldValidator>

                    </td>

                </tr>
				
				
				<td>

                        <asp:Label ID="Label7" runat="server" Text="ActualDateOfCompletion"></asp:Label>

                    </td>
                    <td colspan="2" class="auto-style2">

                        <asp:TextBox ID="txtActualDateOfCompletion" runat="server" TextMode="MultiLine"></asp:TextBox>
						
												<asp:RequiredFieldValidator id="RequiredFieldValidator8"
                 ControlToValidate="txtActualDateOfCompletion"
                 Text="ActualDateOfCompletion is a required field"
                 ForeColor="red" 
                 runat=server>
				 </asp:RequiredFieldValidator>

                    </td>
					
					
					<td>

                        <asp:Label ID="Label8" runat="server" Text="Remarks"></asp:Label>

                    </td>
                    <td colspan="2" class="auto-style2">

                        <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine"></asp:TextBox>
						
						
												<asp:RequiredFieldValidator id="RequiredFieldValidator9"
                 ControlToValidate="txtRemarks"
                 Text="Remarks is a required field"
                 ForeColor="red" 
                 runat=server>
				 </asp:RequiredFieldValidator>

                    </td>
					
					

                </tr>
				
			
                <tr>
				
                    
                    <td>

                        &nbsp;</td>
                    <td colspan="2" class="auto-style2">
						
						<asp:Button ID="btnAutofill" runat="server" Text="Autofill" OnClick="btnAutofill_Click" />
                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" causesvalidation = "False"/>
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

                <asp:BoundField DataField="Organisation" HeaderText="Organisation" />
                <asp:BoundField DataField="ContractAmount" HeaderText="ContractAmount" />
                <asp:BoundField DataField="AmountPaid" HeaderText="AmountPaid" />
				<asp:BoundField DataField="ProgressStatus" HeaderText="ProgressStatus" />
				<asp:BoundField DataField="StartDate" HeaderText="StartDate" />
				<asp:BoundField DataField="DateOfCompletion" HeaderText="DateOfCompletion" />
				<asp:BoundField DataField="ActualDateOfCompletion" HeaderText="ActualDateOfCompletion" />
				<asp:BoundField DataField="Remarks" HeaderText="Remarks" />

                <asp:TemplateField>
                    <ItemTemplate>


                <asp:LinkButton ID="lnkview" runat="server" CommandArgument='<%# Eval("ContactID") %>' OnClick="lnk_Onclick" causesvalidation="False">view </asp:LinkButton> 
				
				

                    
                    </ItemTemplate>
					

                </asp:TemplateField>
                  
            </Columns>
                </asp:GridView>


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
