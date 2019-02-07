using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Windows.Forms;
using System.ComponentModel;
using System.Data;
using System.Text;
using System.Diagnostics;

public partial class DisplayDocs : System.Web.UI.Page
{
    public DisplayDocs()
    {
        //InitializeComponent();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }
    

    protected void Button1_Click(object sender, EventArgs e)
    {

        FolderBrowserDialog FBD = new FolderBrowserDialog();
        //if(FBD.ShowDialog()==DialogResult.OK)
        //if (FBD.ShowDialog() == DialogResult.OK) //DialogResult.)
        //if (FBD.ShowDialog() == DialogResult.OK)
        //{
            ListBox1.Items.Clear();
           // string[] files = Directory.GetFiles(FBD.Selectedpath);
        string[] files = Directory.GetFiles("C:\\Hosting\\Data");

        // string[] dirs = Directory.GetDirectories(FBD.Selectedpath);
        string[] dirs = Directory.GetDirectories("C:\\Hosting\\Data");

        foreach (string file in files)
            {
            //ListBox1.Items.Add(Path.GetFileName(file));
            string fileName = "C:\\Hosting\\Data" + ListBox1.SelectedItem + ".txt";
            Process.Start("C:\\Hosting\\Data");


            }

            foreach (string dir in dirs)
            {
                ListBox1.Items.Add(dir);
            }
        //}

        }
}