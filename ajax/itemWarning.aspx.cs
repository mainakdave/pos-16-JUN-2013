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
    public partial class itemWarning : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int warningID = -1;
            String allUser = String.Empty;
            int users = -1;
            String warningMessage = String.Empty;
            DateTime createDate = DateTime.Now;
            int createUser = -1;
            int modifyUser = -1;

            String StatementType = String.Empty;

            if (!String.IsNullOrEmpty(Request.Form["warningID"])) { warningID = Int32.Parse(Request.Form["warningID"]); }
            if (!String.IsNullOrEmpty(Request.Form["allUser"])) { allUser = Request.Form["allUser"]; }
            if (!String.IsNullOrEmpty(Request.Form["users"])) { users = Int32.Parse(Request.Form["users"]); }
            if (!String.IsNullOrEmpty(Request.Form["warningMessage"])) { warningMessage = Request.Form["warningMessage"]; }
            if (!String.IsNullOrEmpty(Request.Form["createUser"])) { createUser = Int32.Parse(Request.Form["createUser"]); }
            if (!String.IsNullOrEmpty(Request.Form["modifyUser"])) { modifyUser = Int32.Parse(Request.Form["modifyUser"]); }
            if (!String.IsNullOrEmpty(Request.Form["StatementType"])) { StatementType = Request.Form["StatementType"]; }


            //store in DB
            var DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ConnectionString;
            SqlConnection con = new SqlConnection(DBConnectionString);

            string sqlCmd = "itemWarningSelectInsertUpdateDelete";
            int newID;
            using (SqlCommand cmd = new SqlCommand(sqlCmd, con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                if (StatementType == "Insert")
                {
                    cmd.Parameters.AddWithValue("@allUser", allUser);
                    cmd.Parameters.AddWithValue("@users", users);
                    cmd.Parameters.AddWithValue("@warningMessage", warningMessage);
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
                    cmd.Parameters.AddWithValue("@warningID", warningID);
                    cmd.Parameters.AddWithValue("@allUser", allUser);
                    cmd.Parameters.AddWithValue("@users", users);
                    cmd.Parameters.AddWithValue("@warningMessage", warningMessage);
                    cmd.Parameters.AddWithValue("@modifyUser", modifyUser);
                    cmd.Parameters.AddWithValue("@StatementType", "Update");

                    cmd.Parameters.AddWithValue("@NewId", -1);

                    con.Open();
                    int result = cmd.ExecuteNonQuery();
                    con.Close();
                }
                else if (StatementType == "Delete")
                {
                    cmd.Parameters.AddWithValue("@warningID", warningID);
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