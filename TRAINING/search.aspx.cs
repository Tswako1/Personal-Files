using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//required for event handler
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;

public partial class search : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Search_Click(object sender, EventArgs e)
    {
        //string connectiontStr = ConfigurationManager.ConnectionStrings["connectionStr"].ConnectionString;
        //using (SqlConnection con = new SqlConnection(connectiontStr))

        //{
            //SqlCommand cmd = new SqlCommand();
           // cmd.Connection = con;

          //  StringBuilder sbcommand = new StringBuilder("select * form contact where 1=1");

        //}
	Response.Redirect("FinalSearch.aspx");

    }
}