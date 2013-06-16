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
    public partial class modifierDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int id = -1;
            int modifierID = -1;
            int itemID = -1;
            String isItem = String.Empty;
            float portion = 0;
            float priceChange = 0;
            int position = -1;
            int formatID = -1;
            DateTime createDate = DateTime.Now;
            int createUser = -1;
            int modifyUser = -1;

            String StatementType = String.Empty;

            if (!String.IsNullOrEmpty(Request.Form["id"])) { id = Int32.Parse(Request.Form["id"]); }
            if (!String.IsNullOrEmpty(Request.Form["modifierID"])) { modifierID = Int32.Parse(Request.Form["modifierID"]); }
            if (!String.IsNullOrEmpty(Request.Form["itemID"])) { itemID = Int32.Parse(Request.Form["itemID"]); }
            if (!String.IsNullOrEmpty(Request.Form["isItem"])) { isItem = Request.Form["isItem"]; }
            if (!String.IsNullOrEmpty(Request.Form["portion"])) { portion = float.Parse(Request.Form["portion"]); }
            if (!String.IsNullOrEmpty(Request.Form["priceChange"])) { priceChange = float.Parse(Request.Form["priceChange"]); }
            if (!String.IsNullOrEmpty(Request.Form["position"])) { position = Int32.Parse(Request.Form["position"]); }
            if (!String.IsNullOrEmpty(Request.Form["formatID"])) { formatID = Int32.Parse(Request.Form["formatID"]); }
            if (!String.IsNullOrEmpty(Request.Form["createUser"])) { createUser = Int32.Parse(Request.Form["createUser"]); }
            if (!String.IsNullOrEmpty(Request.Form["modifyUser"])) { modifyUser = Int32.Parse(Request.Form["modifyUser"]); }
            if (!String.IsNullOrEmpty(Request.Form["StatementType"])) { StatementType = Request.Form["StatementType"]; }


            //store in DB
            var DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ConnectionString;
            SqlConnection con = new SqlConnection(DBConnectionString);

            string sqlCmd = "modifierDetailSelectInsertUpdateDelete";
            int newID;
            using (SqlCommand cmd = new SqlCommand(sqlCmd, con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                if (StatementType == "Insert")
                {
                    //cmd.Parameters.AddWithValue("@id", id);
                    cmd.Parameters.AddWithValue("@modifierID", modifierID);
                    cmd.Parameters.AddWithValue("@itemID", itemID);
                    cmd.Parameters.AddWithValue("@isItem", isItem);
                    cmd.Parameters.AddWithValue("@portion", portion);
                    cmd.Parameters.AddWithValue("@priceChange", priceChange);
                    cmd.Parameters.AddWithValue("@position", position);
                    cmd.Parameters.AddWithValue("@formatID", formatID);
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
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.Parameters.AddWithValue("@modifierID", modifierID);
                    cmd.Parameters.AddWithValue("@itemID", itemID);
                    cmd.Parameters.AddWithValue("@isItem", isItem);
                    cmd.Parameters.AddWithValue("@portion", portion);
                    cmd.Parameters.AddWithValue("@priceChange", priceChange);
                    cmd.Parameters.AddWithValue("@position", position);
                    cmd.Parameters.AddWithValue("@formatID", formatID);
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
                    cmd.Parameters.AddWithValue("@id", id);
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