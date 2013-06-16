using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace POS.ajax
{
    public partial class taxGroup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int taxGroupID = -1;
            String country = String.Empty;
            String state = String.Empty;
            String city = String.Empty;
            String reference = String.Empty;
            String description = String.Empty;
            String category = String.Empty;
            String comment = String.Empty;
            int serviceTypeID = -1;
            String inclusive = String.Empty;
            int line = -1;
            int taxTypeID = -1;
            String isPerAmount = String.Empty;
            float amount = 0;
            float percentage = 0;
            String isExempt = String.Empty;
            String afterDiscount = String.Empty;
            String afterLine = String.Empty;

            DateTime createDate = DateTime.Now;
            int createUser = -1;
            int modifyUser = -1;

            String StatementType = String.Empty;

            if (!String.IsNullOrEmpty(Request.Form["taxGroupID"])) { taxGroupID = Int32.Parse(Request.Form["taxGroupID"]); }
            if (!String.IsNullOrEmpty(Request.Form["country"])) { country = Request.Form["country"]; }
            if (!String.IsNullOrEmpty(Request.Form["state"])) { state = Request.Form["state"]; }
            if (!String.IsNullOrEmpty(Request.Form["city"])) { city = Request.Form["city"]; }
            if (!String.IsNullOrEmpty(Request.Form["reference"])) { reference = Request.Form["reference"]; }
            if (!String.IsNullOrEmpty(Request.Form["description"])) { description = Request.Form["description"]; }
            if (!String.IsNullOrEmpty(Request.Form["category"])) { category = Request.Form["category"]; }
            if (!String.IsNullOrEmpty(Request.Form["comment"])) { comment = Request.Form["comment"]; }
            if (!String.IsNullOrEmpty(Request.Form["serviceTypeID"])) { serviceTypeID = Int32.Parse(Request.Form["serviceTypeID"]); }
            if (!String.IsNullOrEmpty(Request.Form["inclusive"])) { inclusive = Request.Form["inclusive"]; }
            if (!String.IsNullOrEmpty(Request.Form["line"])) { line = Int32.Parse(Request.Form["line"]); }
            if (!String.IsNullOrEmpty(Request.Form["taxTypeID"])) { taxTypeID = Int32.Parse(Request.Form["taxTypeID"]); }
            if (!String.IsNullOrEmpty(Request.Form["isPerAmount"])) { isPerAmount = Request.Form["isPerAmount"]; }
            if (!String.IsNullOrEmpty(Request.Form["amount"])) { amount = float.Parse(Request.Form["amount"]); }
            if (!String.IsNullOrEmpty(Request.Form["percentage"])) { percentage = float.Parse(Request.Form["percentage"]); }
            if (!String.IsNullOrEmpty(Request.Form["isExempt"])) { isExempt = Request.Form["isExempt"]; }
            if (!String.IsNullOrEmpty(Request.Form["afterDiscount"])) { afterDiscount = Request.Form["afterDiscount"]; }
            if (!String.IsNullOrEmpty(Request.Form["afterLine"])) { afterLine = Request.Form["afterLine"]; }

            if (!String.IsNullOrEmpty(Request.Form["createUser"])) { createUser = Int32.Parse(Request.Form["createUser"]); }
            if (!String.IsNullOrEmpty(Request.Form["modifyUser"])) { modifyUser = Int32.Parse(Request.Form["modifyUser"]); }
            if (!String.IsNullOrEmpty(Request.Form["StatementType"])) { StatementType = Request.Form["StatementType"]; }


            //store in DB
            var DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ConnectionString;
            SqlConnection con = new SqlConnection(DBConnectionString);

            string sqlCmd = "taxGroupSelectInsertUpdateDelete";
            int newID;
            using (SqlCommand cmd = new SqlCommand(sqlCmd, con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                if (StatementType == "Insert")
                {
                    //cmd.Parameters.AddWithValue("@taxGroupID", taxGroupID);
                    cmd.Parameters.AddWithValue("@country", country);
                    cmd.Parameters.AddWithValue("@state", state);
                    cmd.Parameters.AddWithValue("@city", city);
                    cmd.Parameters.AddWithValue("@reference", reference);
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@category", category);
                    cmd.Parameters.AddWithValue("@comment", comment);
                    cmd.Parameters.AddWithValue("@serviceTypeID", serviceTypeID);
                    cmd.Parameters.AddWithValue("@inclusive", inclusive);
                    cmd.Parameters.AddWithValue("@line", line);
                    cmd.Parameters.AddWithValue("@taxTypeID", taxTypeID);
                    cmd.Parameters.AddWithValue("@isPerAmount", isPerAmount);
                    cmd.Parameters.AddWithValue("@amount", amount);
                    cmd.Parameters.AddWithValue("@percentage", percentage);
                    cmd.Parameters.AddWithValue("@isExempt", isExempt);
                    cmd.Parameters.AddWithValue("@afterDiscount", afterDiscount);
                    cmd.Parameters.AddWithValue("@afterLine", afterLine);
                    //cmd.Parameters.AddWithValue("@createDate", createDate);
                    cmd.Parameters.AddWithValue("@createUser", createUser);
                    cmd.Parameters.AddWithValue("@modifyUser", modifyUser);
                    cmd.Parameters.AddWithValue("@StatementType", "Insert");

                    cmd.Parameters.Add("@NewId", SqlDbType.Int).Direction = ParameterDirection.Output;

                    con.Open();
                    int result = cmd.ExecuteNonQuery();
                    con.Close();

                    newID = Convert.ToInt32(cmd.Parameters["@NewId"].Value);
                    Response.Write(newID);
                }
                else if (StatementType == "Update")
                {
                    cmd.Parameters.AddWithValue("@taxGroupID", taxGroupID);
                    cmd.Parameters.AddWithValue("@country", country);
                    cmd.Parameters.AddWithValue("@state", state);
                    cmd.Parameters.AddWithValue("@city", city);
                    cmd.Parameters.AddWithValue("@reference", reference);
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@category", category);
                    cmd.Parameters.AddWithValue("@comment", comment);
                    cmd.Parameters.AddWithValue("@serviceTypeID", serviceTypeID);
                    cmd.Parameters.AddWithValue("@inclusive", inclusive);
                    cmd.Parameters.AddWithValue("@line", line);
                    cmd.Parameters.AddWithValue("@taxTypeID", taxTypeID);
                    cmd.Parameters.AddWithValue("@isPerAmount", isPerAmount);
                    cmd.Parameters.AddWithValue("@amount", amount);
                    cmd.Parameters.AddWithValue("@percentage", percentage);
                    cmd.Parameters.AddWithValue("@isExempt", isExempt);
                    cmd.Parameters.AddWithValue("@afterDiscount", afterDiscount);
                    cmd.Parameters.AddWithValue("@afterLine", afterLine);
                    //cmd.Parameters.AddWithValue("@createDate", createDate);
                    //cmd.Parameters.AddWithValue("@createUser", createUser);
                    cmd.Parameters.AddWithValue("@modifyUser", modifyUser);
                    cmd.Parameters.AddWithValue("@StatementType", "Update");

                    cmd.Parameters.AddWithValue("@NewId", -1);

                    con.Open();
                    int result = cmd.ExecuteNonQuery();
                    con.Close();
                }
                else if (StatementType == "Delete")
                {
                    cmd.Parameters.AddWithValue("@taxGroupID", taxGroupID);
                    cmd.Parameters.AddWithValue("@StatementType", "Delete");

                    cmd.Parameters.AddWithValue("@NewId", -1);

                    con.Open();
                    int result = cmd.ExecuteNonQuery();
                    con.Close();
                }


            }

        }
    }
}