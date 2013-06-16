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
    public partial class section : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int sectionID = -1;
            int deptID = -1;
            String sectionName = String.Empty;
            String reference = String.Empty;
            String description = String.Empty;
            String image = String.Empty;
            String bgColor = String.Empty;
            String textColor = String.Empty;
            String costCenter = String.Empty;
            String saleAcct = String.Empty;
            String purchaseAcct = String.Empty;
            DateTime createDate = DateTime.Now;
            int createUser = -1;
            int modifyUser = -1;

            String StatementType = String.Empty;

            if (!String.IsNullOrEmpty(Request.Form["sectionID"])) { sectionID = Int32.Parse(Request.Form["sectionID"]); }
            if (!String.IsNullOrEmpty(Request.Form["deptID"])) { deptID = Int32.Parse(Request.Form["deptID"]); }
            if (!String.IsNullOrEmpty(Request.Form["sectionName"])) { sectionName = Request.Form["sectionName"]; }
            if (!String.IsNullOrEmpty(Request.Form["reference"])) { reference = Request.Form["reference"]; }
            if (!String.IsNullOrEmpty(Request.Form["description"])) { description = Request.Form["description"]; }
            if (!String.IsNullOrEmpty(Request.Form["image"])) { image = Request.Form["image"]; }
            if (!String.IsNullOrEmpty(Request.Form["bgColor"])) { bgColor = Request.Form["bgColor"]; }
            if (!String.IsNullOrEmpty(Request.Form["textColor"])) { textColor = Request.Form["textColor"]; }
            if (!String.IsNullOrEmpty(Request.Form["costCenter"])) { costCenter = Request.Form["costCenter"]; }
            if (!String.IsNullOrEmpty(Request.Form["saleAcct"])) { saleAcct = Request.Form["saleAcct"]; }
            if (!String.IsNullOrEmpty(Request.Form["purchaseAcct"])) { purchaseAcct = Request.Form["purchaseAcct"]; }
            if (!String.IsNullOrEmpty(Request.Form["createUser"])) { createUser = Int32.Parse(Request.Form["createUser"]); }
            if (!String.IsNullOrEmpty(Request.Form["modifyUser"])) { modifyUser = Int32.Parse(Request.Form["modifyUser"]); }
            if (!String.IsNullOrEmpty(Request.Form["StatementType"])) { StatementType = Request.Form["StatementType"]; }


            //store in DB
            var DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ConnectionString;
            SqlConnection con = new SqlConnection(DBConnectionString);

            string sqlCmd = "sectionSelectInsertUpdateDelete";
            int newID;
            using (SqlCommand cmd = new SqlCommand(sqlCmd, con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                if (StatementType == "Insert")
                {
                    cmd.Parameters.AddWithValue("@sectionID", sectionID);
                    cmd.Parameters.AddWithValue("@deptID", deptID);
                    cmd.Parameters.AddWithValue("@sectionName", sectionName);
                    cmd.Parameters.AddWithValue("@reference", reference);
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@image", image);
                    cmd.Parameters.AddWithValue("@bgColor", bgColor);
                    cmd.Parameters.AddWithValue("@textColor", textColor);
                    cmd.Parameters.AddWithValue("@costCenter", costCenter);
                    cmd.Parameters.AddWithValue("@saleAcct", saleAcct);
                    cmd.Parameters.AddWithValue("@purchaseAcct", purchaseAcct);
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
                    cmd.Parameters.AddWithValue("@sectionID", sectionID);
                    cmd.Parameters.AddWithValue("@deptID", deptID);
                    cmd.Parameters.AddWithValue("@sectionName", sectionName);
                    cmd.Parameters.AddWithValue("@reference", reference);
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@image", image);
                    cmd.Parameters.AddWithValue("@bgColor", bgColor);
                    cmd.Parameters.AddWithValue("@textColor", textColor);
                    cmd.Parameters.AddWithValue("@costCenter", costCenter);
                    cmd.Parameters.AddWithValue("@saleAcct", saleAcct);
                    cmd.Parameters.AddWithValue("@purchaseAcct", purchaseAcct);
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
                    cmd.Parameters.AddWithValue("@sectionID", sectionID);
                    cmd.Parameters.AddWithValue("@deptID", deptID);
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