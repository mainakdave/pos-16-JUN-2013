using System;
using System.Collections.Generic;

using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace POS.ajax
{
    public partial class modifierMaster : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int modifierID = -1;
            String reference = String.Empty;
            String description = String.Empty;
            String divisible = String.Empty;
            String comment = String.Empty;
            DateTime createDate = DateTime.Now;
            int createUser = -1;
            int modifyUser = -1;

            String StatementType = String.Empty;

            if (!String.IsNullOrEmpty(Request.Form["modifierID"])) { modifierID = Int32.Parse(Request.Form["modifierID"]); }
            if (!String.IsNullOrEmpty(Request.Form["reference"])) { reference = Request.Form["reference"]; }
            if (!String.IsNullOrEmpty(Request.Form["description"])) { description = Request.Form["description"]; }
            if (!String.IsNullOrEmpty(Request.Form["divisible"])) { divisible = Request.Form["divisible"]; }
            if (!String.IsNullOrEmpty(Request.Form["comment"])) { comment = Request.Form["comment"]; }
            if (!String.IsNullOrEmpty(Request.Form["createUser"])) { createUser = Int32.Parse(Request.Form["createUser"]); }
            if (!String.IsNullOrEmpty(Request.Form["modifyUser"])) { modifyUser = Int32.Parse(Request.Form["modifyUser"]); }
            if (!String.IsNullOrEmpty(Request.Form["StatementType"])) { StatementType = Request.Form["StatementType"]; }


            //store in DB
            var DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ConnectionString;
            SqlConnection con = new SqlConnection(DBConnectionString);

            string sqlCmd = "modifierMasterSelectInsertUpdateDelete";
            int newID;
            using (SqlCommand cmd = new SqlCommand(sqlCmd, con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                if (StatementType == "Insert")
                {
                    //cmd.Parameters.AddWithValue("@modifierID", modifierID);
                    cmd.Parameters.AddWithValue("@reference", reference);
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@divisible", divisible);
                    cmd.Parameters.AddWithValue("@comment", comment);
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
                    cmd.Parameters.AddWithValue("@modifierID", modifierID);
                    cmd.Parameters.AddWithValue("@reference", reference);
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@divisible", divisible);
                    cmd.Parameters.AddWithValue("@comment", comment);
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
                    cmd.Parameters.AddWithValue("@modifierID", modifierID);
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