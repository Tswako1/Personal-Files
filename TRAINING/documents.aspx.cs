using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
//using System.Windows.Forms;
//using System.Windows.Forms.MessageBox;
using System.Diagnostics;


public partial class documents : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    String path = "C:\\Hosting\\Intra";

    public object MessageBox { get; private set; }

    //Microsoft.Web.UI.control.treenodecollection mynodecollection = new Microsoft.Web.UI.controls.treenodecollection();
    //System.Web.UI.WebControls.TreeNodeCollection collection = null;

    protected void Button1_Click(object sender, EventArgs e)

    {

        ListDirectory(TreeView1, path);

        


    }


    private void ListDirectory(TreeView treeView, string path)
    {
        treeView.Nodes.Clear();
        var rootDirectoryInfo = new DirectoryInfo(path);
        
        treeView.Nodes.Add(CreateDirectoryNode(rootDirectoryInfo));
    }
    private static TreeNode CreateDirectoryNode(DirectoryInfo directoryInfo)
    {

        var directoryNode = new TreeNode(directoryInfo.Name);
        foreach(var directory in directoryInfo.GetDirectories())
            directoryNode.ChildNodes.Add(CreateDirectoryNode(directory));

        foreach (var file in directoryInfo.GetFiles())
            directoryNode.ChildNodes.Add(new TreeNode(file.Name));
       // directoryNode.ChildNodes.Add(new System.Windows.Forms TreeNode(File.Name));



        return directoryNode;

    }

    
    protected void Button2_Click(object sender, EventArgs e)
    {

        //string fileName = "C:\\Hosting\\Data" + ListBox1.SelectedItem + ".txt";
        //Process.Start("C:\\Hosting\\Data");

        //String path = "C:\\Hosting\\Data";
        //ListDirectory(TreeView1, "C:\\Hosting\\Data");
        //string name = TreeView1.SelectedNode.ToString().Replace("TreeNode: ", string.Empty); //trying to open files
        //MessageBox.Show(Path + "\\" + TreeNodeName));
        //System.Diagnostics.Process.Start("C:\\Hosting\\Data");

        //String TreeNodeName = TreeView1.SelectedNode.ToString().Replace("TreeNode: ", String.Empty);
        // MessageBox.Show(path + "\\" + TreeNodeName);
        // MessageBox.Show(path + "\\" + TreeNodeName);
        //(path + "\\" + TreeNodeName);
        // Response.Write("< Script language='javascript'>window.alert(' ');</script>");
        // System.Diagnostics.Process.Start(path + "\\" + TreeNodeName);


        //string myPath = @"C:\\Hosting\\Data";
        //System.Diagnostics.Process prc = new System.Diagnostics.Process();
        //prc.StartInfo.FileName = myPath;
        //prc.Start();

	/*
        if (Page.IsPostBack)
        {
            FileStream MyFileStream = new FileStream(@"C:\Users\Makgalaborwa\source\repos\MyFirstCshrpdotNetProject\MyFirstCshrpdotNetProject\Data\ID Copy.pdf", FileMode.Open);
            long FileSize;
            FileSize = MyFileStream.Length;
            byte[] Buffer = new byte[(int)FileSize];
            MyFileStream.Read(Buffer, 0, (int)MyFileStream.Length);
            MyFileStream.Close();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment; filename=ID Copy.pdf");
            Response.BinaryWrite(Buffer);
        }

*/
        
       
        


    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        ListDirectory(TreeView1, " C:\\Hosting\\Intra");
       /* if (Page.IsPostBack)
        {
            FileStream MyFileStream = new FileStream(@"C:\Users\Makgalaborwa\source\repos\MyFirstCshrpdotNetProject\MyFirstCshrpdotNetProject\Data\ID Copy.pdf", FileMode.Open);
            long FileSize;
            FileSize = MyFileStream.Length;
            byte[] Buffer = new byte[(int)FileSize];
            MyFileStream.Read(Buffer, 0, (int)MyFileStream.Length);
            MyFileStream.Close();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment; filename=ID Copy.pdf");
            Response.AddHeader("content-disposition", "attachment; filename=ID Copy.pdf");
            Response.BinaryWrite(Buffer);
        }
*/
    }


    protected void Button4_Click(object sender, EventArgs e)
    {
       // String TreeNodeName = TreeView1.SelectedNode.ToString().Replace("TreeNode: ",String.Empty);
       
        //System.Diagnostics.Process.Start("C:\\Hosting\\Data" + "\\" + TreeNodeName);
       
    }

    protected void Button5_Click(object sender, EventArgs e)
    {
        
            if (Page.IsPostBack)
            {
                FileStream MyFileStream = new FileStream(@"C:\Hosting\Intra\2 IT SECURTY POLICY.PDF", FileMode.Open);
                long FileSize;
                FileSize = MyFileStream.Length;
                byte[] Buffer = new byte[(int)FileSize];
                MyFileStream.Read(Buffer, 0, (int)MyFileStream.Length);
                MyFileStream.Close();
                Response.ContentType = "application/pdf";
                Response.AddHeader("content-disposition", "attachment; filename=2 IT SECURTY POLICY.PDF");
                Response.BinaryWrite(Buffer);
            }
        }

    protected void Button6_Click(object sender, EventArgs e)
    {

        if (Page.IsPostBack)
        {
            FileStream MyFileStream = new FileStream(@"C:\Hosting\Intra\1 TELEPHONE AND MOBILE POLICY.PDF", FileMode.Open);
            long FileSize;
            FileSize = MyFileStream.Length;
            byte[] Buffer = new byte[(int)FileSize];
            MyFileStream.Read(Buffer, 0, (int)MyFileStream.Length);
            MyFileStream.Close();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment; filename=1 TELEPHONE AND MOBILE POLICY.PDF");
            Response.BinaryWrite(Buffer);
        }
    }

    protected void Button7_Click(object sender, EventArgs e)
    {

        if (Page.IsPostBack)
        {
            FileStream MyFileStream = new FileStream(@"C:\Hosting\Intra\3 USE AND STANDARDIATION OF IT.PDF", FileMode.Open);
            long FileSize;
            FileSize = MyFileStream.Length;
            byte[] Buffer = new byte[(int)FileSize];
            MyFileStream.Read(Buffer, 0, (int)MyFileStream.Length);
            MyFileStream.Close();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment; filename=3 USE AND STANDARDIATION OF IT.PDF");
            Response.BinaryWrite(Buffer);
        }

    }

    protected void Button8_Click(object sender, EventArgs e)
    {

        if (Page.IsPostBack)
        {
            FileStream MyFileStream = new FileStream(@"C:\Hosting\Intra\4 IT EMAIL AND INTERNET ACCEPTABLE USE.PDF", FileMode.Open);
            long FileSize;
            FileSize = MyFileStream.Length;
            byte[] Buffer = new byte[(int)FileSize];
            MyFileStream.Read(Buffer, 0, (int)MyFileStream.Length);
            MyFileStream.Close();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment; filename=4 IT EMAIL AND INTERNET ACCEPTABLE USE.PDF");
            Response.BinaryWrite(Buffer);
        }
    }

    protected void Button9_Click(object sender, EventArgs e)
    {
        if (Page.IsPostBack)
        {
            FileStream MyFileStream = new FileStream(@"C:\Hosting\Intra\5 CORPEERATE GOVERNANCE OF ICT Policy.pdf", FileMode.Open);
            long FileSize;
            FileSize = MyFileStream.Length;
            byte[] Buffer = new byte[(int)FileSize];
            MyFileStream.Read(Buffer, 0, (int)MyFileStream.Length);
            MyFileStream.Close();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment; filename=5 CORPEERATE GOVERNANCE OF ICT Policy.pdf");
            Response.BinaryWrite(Buffer);
        }
    }
}