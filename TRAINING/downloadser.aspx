﻿<%@ Page Language="C#" %>
<%@ Import Namespace="System.IO" %>
<HTML>
<HEAD>
<script runat="server" ID=Script1>
void Page_Load(object sender, System.EventArgs e) {
if (Page.IsPostBack){
FileStream MyFileStream = new FileStream(@"C:\Hosting\Data\Blank Leave form (002).pdf", FileMode.Open);
long FileSize;
FileSize = MyFileStream.Length;
byte[] Buffer = new byte[(int)FileSize];
MyFileStream.Read(Buffer, 0, (int)MyFileStream.Length);
MyFileStream.Close();
Response.ContentType="application/pdf";
Response.AddHeader( "content-disposition","attachment; filename=Blank Leave form (002).pdf");
Response.BinaryWrite(Buffer);
}
}
</script>
</HEAD>
<body>
<form runat="server">
<asp:button id="link1" Text = "get PDF" runat="server" />
</form>
</body>
</HTML>