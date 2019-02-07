using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Contact : System.Web.UI.Page
{
    SqlConnection sqlcon = new SqlConnection(@"Data Source=DESKTOP-I2KFFFU\SQLEXPRESS;Initial Catalog=ASPCRUD;Integrated Security=true");

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            btnDelete.Enabled = false;
            FIllGridView();
        }
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        Clear();
    }

    public void Clear()
    {
        hfContactID.Value = "";
        txtOrganisation.Text = txtContractAmount.Text = txtAmountPaid.Text = txtProgressStatus.Text = txtStartDate.Text 
		= txtDateOfCompletion.Text = txtActualDateOfCompletion.Text = txtRemarks.Text ="";
        lblSuccessMessage.Text = lblErrorMessage.Text = "";
        btnSave.Text = "Save";
        btnDelete.Enabled = false;

    }



    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (sqlcon.State == ConnectionState.Closed)
            sqlcon.Open();

        SqlCommand sqlCmd = new SqlCommand("ContactCreateOrUpdate", sqlcon);
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Parameters.AddWithValue("@ContactID", (hfContactID.Value == "" ? 0 : Convert.ToInt32(hfContactID.Value)));
        sqlCmd.Parameters.AddWithValue("@Organisation", txtOrganisation.Text.Trim());
        sqlCmd.Parameters.AddWithValue("@ContractAmount", txtContractAmount.Text.Trim());
        sqlCmd.Parameters.AddWithValue("@AmountPaid", txtAmountPaid.Text.Trim());
		sqlCmd.Parameters.AddWithValue("@ProgressStatus", txtProgressStatus.Text.Trim());
		sqlCmd.Parameters.AddWithValue("@StartDate", txtStartDate.Text.Trim());
		sqlCmd.Parameters.AddWithValue("@DateOfCompletion", txtDateOfCompletion.Text.Trim());
		sqlCmd.Parameters.AddWithValue("@ActualDateOfCompletion", txtActualDateOfCompletion.Text.Trim());
		sqlCmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text.Trim());
		
        sqlCmd.ExecuteNonQuery();
        sqlcon.Close();

        // update
        String ContactID = hfContactID.Value;
        Clear();

        if (hfContactID.Value == " ")
            lblSuccessMessage.Text = "Saved Successfully";
        else
            lblSuccessMessage.Text = "Updated Successfully";

        FIllGridView();

    }
    // Inserted newly information in to gridview. 
    void FIllGridView()
    {
        if (sqlcon.State == ConnectionState.Closed)
            sqlcon.Open();

        SqlDataAdapter sqlDa = new SqlDataAdapter("ContactViewAll",sqlcon);
        sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dtbl = new DataTable();
        sqlDa.Fill(dtbl);
        sqlcon.Close();
        gvContact.DataSource = dtbl;
        gvContact.DataBind();


        

    }
    // Method to work with view hahahahaha

        protected void lnk_Onclick(object sender, EventArgs e)
    
    {
        int ContactID = Convert.ToInt32((sender as LinkButton).CommandArgument);

        if (sqlcon.State == ConnectionState.Closed)
            sqlcon.Open();

        SqlDataAdapter sqlDa = new SqlDataAdapter("ContactViewByID", sqlcon);
        sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
        sqlDa.SelectCommand.Parameters.AddWithValue("@ContactID", ContactID);
        DataTable dtbl = new DataTable();
        sqlDa.Fill(dtbl);
        sqlcon.Close();

        // hidden field

        hfContactID.Value = ContactID.ToString();
        txtOrganisation.Text = dtbl.Rows[0]["Organisation"].ToString();
        txtContractAmount.Text = dtbl.Rows[0]["ContractAmount"].ToString();
        txtAmountPaid.Text = dtbl.Rows[0]["AmountPaid"].ToString();
        txtProgressStatus.Text = dtbl.Rows[0]["ProgressStatus"].ToString();
		txtStartDate.Text = dtbl.Rows[0]["StartDate"].ToString();
		txtDateOfCompletion.Text = dtbl.Rows[0]["DateOfCompletion"].ToString();
		txtActualDateOfCompletion.Text = dtbl.Rows[0]["ActualDateOfCompletion"].ToString();
		txtRemarks.Text = dtbl.Rows[0]["Remarks"].ToString();
		btnSave.Text = "Update";
        btnDelete.Enabled = true;

    }




    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (sqlcon.State == ConnectionState.Closed)
            //if (sqlcon.State == new ConnectionState.closed)
            sqlcon.Open();
        SqlCommand sqlCmd = new SqlCommand("ContactDeleteByID", sqlcon);
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Parameters.AddWithValue("@ContactID", Convert.ToInt32(hfContactID.Value));
        sqlCmd.ExecuteNonQuery();
        sqlcon.Close();
        Clear();
        FIllGridView();
        lblSuccessMessage.Text = "Deleted Successfully";
    
    }

    protected void hfContactID_ValueChanged(object sender, EventArgs e)
    {

    }
}