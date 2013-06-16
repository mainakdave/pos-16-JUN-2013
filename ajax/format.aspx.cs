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
    public partial class format : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int formatID = -1;
            String reference = String.Empty;
            String description = String.Empty;
            String image = String.Empty;
            String bgColor = String.Empty;
            String textColor = String.Empty;
            String combination = String.Empty;
            float portion1 = -1;
            float portion2 = -1;
            float costSecond = -1;
            int favoriteCode = -1;
            DateTime createDate = DateTime.Now;
            int createUser = -1;
            int modifyUser = -1;

            String StatementType = String.Empty;

            if (!String.IsNullOrEmpty(Request.Form["formatID"])) { formatID = Int32.Parse(Request.Form["formatID"]); }
            if (!String.IsNullOrEmpty(Request.Form["reference"])) { reference = Request.Form["reference"]; }
            if (!String.IsNullOrEmpty(Request.Form["description"])) { description = Request.Form["description"]; }
            if (!String.IsNullOrEmpty(Request.Form["image"])) { image = Request.Form["image"]; }
            if (!String.IsNullOrEmpty(Request.Form["bgColor"])) { bgColor = Request.Form["bgColor"]; }
            if (!String.IsNullOrEmpty(Request.Form["textColor"])) { textColor = Request.Form["textColor"]; }
            if (!String.IsNullOrEmpty(Request.Form["combination"])) { combination = Request.Form["combination"]; }
            if (!String.IsNullOrEmpty(Request.Form["portion1"])) { portion1 = float.Parse(Request.Form["portion1"]); }
            if (!String.IsNullOrEmpty(Request.Form["portion2"])) { portion2 = float.Parse(Request.Form["portion2"]); }
            if (!String.IsNullOrEmpty(Request.Form["costSecond"])) { costSecond = float.Parse(Request.Form["costSecond"]); }
            if (!String.IsNullOrEmpty(Request.Form["favoriteCode"])) { favoriteCode = Int32.Parse(Request.Form["favoriteCode"]); }
            if (!String.IsNullOrEmpty(Request.Form["createUser"])) { createUser = Int32.Parse(Request.Form["createUser"]); }
            if (!String.IsNullOrEmpty(Request.Form["modifyUser"])) { modifyUser = Int32.Parse(Request.Form["modifyUser"]); }
            if (!String.IsNullOrEmpty(Request.Form["StatementType"])) { StatementType = Request.Form["StatementType"]; }


            //store in DB
            var DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ConnectionString;
            SqlConnection con = new SqlConnection(DBConnectionString);

            string sqlCmd = "formatSelectInsertUpdateDelete";
            int newID;
            using (SqlCommand cmd = new SqlCommand(sqlCmd, con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                if (StatementType == "Insert")
                {
                    //cmd.Parameters.AddWithValue("@deptID", deptID);
                    cmd.Parameters.AddWithValue("@reference", reference);
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@image", image);
                    cmd.Parameters.AddWithValue("@bgColor", bgColor);
                    cmd.Parameters.AddWithValue("@textColor", textColor);
                    cmd.Parameters.AddWithValue("@combination", combination);
                    cmd.Parameters.AddWithValue("@portion1", portion1);
                    cmd.Parameters.AddWithValue("@portion2", portion2);
                    cmd.Parameters.AddWithValue("@costSecond", costSecond);
                    cmd.Parameters.AddWithValue("@favoriteCode", favoriteCode);
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
                    cmd.Parameters.AddWithValue("@formatID", formatID);
                    cmd.Parameters.AddWithValue("@reference", reference);
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@image", image);
                    cmd.Parameters.AddWithValue("@bgColor", bgColor);
                    cmd.Parameters.AddWithValue("@textColor", textColor);
                    cmd.Parameters.AddWithValue("@combination", combination);
                    cmd.Parameters.AddWithValue("@portion1", portion1);
                    cmd.Parameters.AddWithValue("@portion2", portion2);
                    cmd.Parameters.AddWithValue("@costSecond", costSecond);
                    cmd.Parameters.AddWithValue("@favoriteCode", favoriteCode);
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
                    cmd.Parameters.AddWithValue("@formatID", formatID);
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