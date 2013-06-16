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
    public partial class itemRestaurant : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int itemRestID = -1;
            int itemID = -1;
            String byPortion = String.Empty;
            String visibleSales = String.Empty;
            int orderNo = -1;
            String isMenu = String.Empty;
            String freePrice = String.Empty;
            float freeMin = 0;
            float freeMax = 0;
            int couponCode = -1;
            String shortcut = String.Empty;
            String bgColor = String.Empty;
            String textColor = String.Empty;
            String yield = String.Empty;

            DateTime createDate = DateTime.Now;
            int createUser = -1;
            int modifyUser = -1;

            String StatementType = String.Empty;

            if (!String.IsNullOrEmpty(Request.Form["itemRestID"])) { itemRestID = Int32.Parse(Request.Form["itemRestID"]); }
            if (!String.IsNullOrEmpty(Request.Form["itemID"])) { itemID = Int32.Parse(Request.Form["itemID"]); }
            if (!String.IsNullOrEmpty(Request.Form["byPortion"])) { byPortion = Request.Form["byPortion"]; }
            if (!String.IsNullOrEmpty(Request.Form["visibleSales"])) { visibleSales = Request.Form["visibleSales"]; }
            if (!String.IsNullOrEmpty(Request.Form["orderNo"])) { orderNo = Int32.Parse(Request.Form["orderNo"]); }
            if (!String.IsNullOrEmpty(Request.Form["isMenu"])) { isMenu = Request.Form["isMenu"]; }
            if (!String.IsNullOrEmpty(Request.Form["freePrice"])) { freePrice = Request.Form["freePrice"]; }
            if (!String.IsNullOrEmpty(Request.Form["freeMin"])) { freeMin = float.Parse(Request.Form["freeMin"]); }
            if (!String.IsNullOrEmpty(Request.Form["freeMax"])) { freeMax = float.Parse(Request.Form["freeMax"]); }
            if (!String.IsNullOrEmpty(Request.Form["couponCode"])) { couponCode = Int32.Parse(Request.Form["couponCode"]); }
            if (!String.IsNullOrEmpty(Request.Form["shortcut"])) { shortcut = Request.Form["shortcut"]; }
            if (!String.IsNullOrEmpty(Request.Form["bgColor"])) { bgColor = Request.Form["bgColor"]; }
            if (!String.IsNullOrEmpty(Request.Form["textColor"])) { textColor = Request.Form["textColor"]; }
            if (!String.IsNullOrEmpty(Request.Form["yield"])) { yield = Request.Form["yield"]; }

            if (!String.IsNullOrEmpty(Request.Form["createUser"])) { createUser = Int32.Parse(Request.Form["createUser"]); }
            if (!String.IsNullOrEmpty(Request.Form["modifyUser"])) { modifyUser = Int32.Parse(Request.Form["modifyUser"]); }
            if (!String.IsNullOrEmpty(Request.Form["StatementType"])) { StatementType = Request.Form["StatementType"]; }


            //store in DB
            var DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ConnectionString;
            SqlConnection con = new SqlConnection(DBConnectionString);

            string sqlCmd = "itemRestaurantSelectInsertUpdateDelete";
            int newID;
            using (SqlCommand cmd = new SqlCommand(sqlCmd, con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                if (StatementType == "Insert")
                {
                    //cmd.Parameters.AddWithValue("@itemRestID", itemRestID);
                    cmd.Parameters.AddWithValue("@itemID", itemID);
                    cmd.Parameters.AddWithValue("@byPortion", byPortion);
                    cmd.Parameters.AddWithValue("@visibleSales", visibleSales);
                    cmd.Parameters.AddWithValue("@orderNo", orderNo);
                    cmd.Parameters.AddWithValue("@isMenu", isMenu);
                    cmd.Parameters.AddWithValue("@freePrice", freePrice);
                    cmd.Parameters.AddWithValue("@freeMin", freeMin);
                    cmd.Parameters.AddWithValue("@freeMax", freeMax);
                    cmd.Parameters.AddWithValue("@couponCode", couponCode);
                    cmd.Parameters.AddWithValue("@shortcut", shortcut);
                    cmd.Parameters.AddWithValue("@bgColor", bgColor);
                    cmd.Parameters.AddWithValue("@textColor", textColor);
                    cmd.Parameters.AddWithValue("@yield", yield);
                    
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
                    cmd.Parameters.AddWithValue("@itemRestID", itemRestID);
                    cmd.Parameters.AddWithValue("@itemID", itemID);
                    cmd.Parameters.AddWithValue("@byPortion", byPortion);
                    cmd.Parameters.AddWithValue("@visibleSales", visibleSales);
                    cmd.Parameters.AddWithValue("@orderNo", orderNo);
                    cmd.Parameters.AddWithValue("@isMenu", isMenu);
                    cmd.Parameters.AddWithValue("@freePrice", freePrice);
                    cmd.Parameters.AddWithValue("@freeMin", freeMin);
                    cmd.Parameters.AddWithValue("@freeMax", freeMax);
                    cmd.Parameters.AddWithValue("@couponCode", couponCode);
                    cmd.Parameters.AddWithValue("@shortcut", shortcut);
                    cmd.Parameters.AddWithValue("@bgColor", bgColor);
                    cmd.Parameters.AddWithValue("@textColor", textColor);
                    cmd.Parameters.AddWithValue("@yield", yield);

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
                    cmd.Parameters.AddWithValue("@itemRestID", itemRestID);
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