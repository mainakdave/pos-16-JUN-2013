using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace POS.Ajax
{
    public partial class Save : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String itemName = String.Empty;
            String itemDesc = String.Empty;
            String bgColor = String.Empty;
            String textColor = String.Empty;

            if (!String.IsNullOrEmpty(Request.Form["itemName"]))
            {
                itemName = Request.Form["itemName"];
            }
            if (!String.IsNullOrEmpty(Request.Form["itemDesc"]))
            {
                itemDesc = Request.Form["itemDesc"];
            }
            if (!String.IsNullOrEmpty(Request.Form["bgColor"]))
            {
                bgColor = Request.Form["bgColor"];
            }
            if (!String.IsNullOrEmpty(Request.Form["textColor"]))
            {
                textColor = Request.Form["textColor"];
            }


            //store in DB
            var DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ConnectionString;
            SqlConnection con = new SqlConnection(DBConnectionString);

            string sqlCmd = "TestSelectInsertUpdateDelete";
            using (SqlCommand cmd = new SqlCommand(sqlCmd, con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@deptInternalCode", itemName);
                cmd.Parameters.AddWithValue("@deptDescription", itemDesc);
                cmd.Parameters.AddWithValue("@deptBGColor", bgColor);
                cmd.Parameters.AddWithValue("@deptTextColor", textColor);
                cmd.Parameters.AddWithValue("@StatementType", "Insert");
                cmd.Parameters.AddWithValue("@deptId", 0);

                con.Open();
                int result = cmd.ExecuteNonQuery();
                con.Close();

                Response.Write(result);
            }
            Response.Write("<div>" + 
                "<p>" + itemName + "</p>" +
                "<p>" + itemDesc + "</p>" +
                "<p>" + bgColor + "</p>" +
                "<p>" + textColor + "</p>");

        }
    }
}