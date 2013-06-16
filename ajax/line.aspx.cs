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
    public partial class line : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int brandID = -1;
            int lineID = -1;
            String lineName = String.Empty;
            String description = String.Empty;
            DateTime createDate = DateTime.Now;
            int createUser = -1;
            int modifyUser = -1;

            String StatementType = String.Empty;

            if (!String.IsNullOrEmpty(Request.Form["brandID"])) { brandID = Int32.Parse(Request.Form["brandID"]); }
            if (!String.IsNullOrEmpty(Request.Form["lineID"])) { lineID = Int32.Parse(Request.Form["lineID"]); }
            if (!String.IsNullOrEmpty(Request.Form["lineName"])) { lineName = Request.Form["lineName"]; }
            if (!String.IsNullOrEmpty(Request.Form["description"])) { description = Request.Form["description"]; }
            if (!String.IsNullOrEmpty(Request.Form["createUser"])) { createUser = Int32.Parse(Request.Form["createUser"]); }
            if (!String.IsNullOrEmpty(Request.Form["modifyUser"])) { modifyUser = Int32.Parse(Request.Form["modifyUser"]); }
            if (!String.IsNullOrEmpty(Request.Form["StatementType"])) { StatementType = Request.Form["StatementType"]; }


            //store in DB
            var DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ConnectionString;
            SqlConnection con = new SqlConnection(DBConnectionString);

            string sqlCmd = "lineSelectInsertUpdateDelete";
            int newID;
            using (SqlCommand cmd = new SqlCommand(sqlCmd, con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                if (StatementType == "Insert")
                {
                    cmd.Parameters.AddWithValue("@brandID", brandID);
                    cmd.Parameters.AddWithValue("@lineName", lineName);
                    cmd.Parameters.AddWithValue("@description", description);
                    //cmd.Parameters.AddWithValue("@image", image);
                    //cmd.Parameters.AddWithValue("@bgColor", bgColor);
                    //cmd.Parameters.AddWithValue("@textColor", textColor);
                    //cmd.Parameters.AddWithValue("@costCenter", costCenter);
                    //cmd.Parameters.AddWithValue("@saleAcct", saleAcct);
                    //cmd.Parameters.AddWithValue("@purchaseAcct", purchaseAcct);
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
                    cmd.Parameters.AddWithValue("@brandID", brandID);
                    cmd.Parameters.AddWithValue("@lineID", lineID);
                    cmd.Parameters.AddWithValue("@lineName", lineName);
                    cmd.Parameters.AddWithValue("@description", description);
                    //cmd.Parameters.AddWithValue("@image", image);
                    //cmd.Parameters.AddWithValue("@bgColor", bgColor);
                    //cmd.Parameters.AddWithValue("@textColor", textColor);
                    //cmd.Parameters.AddWithValue("@costCenter", costCenter);
                    //cmd.Parameters.AddWithValue("@saleAcct", saleAcct);
                    //cmd.Parameters.AddWithValue("@purchaseAcct", purchaseAcct);
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
                    cmd.Parameters.AddWithValue("@brandID", brandID);
                    cmd.Parameters.AddWithValue("@lineID", lineID);
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