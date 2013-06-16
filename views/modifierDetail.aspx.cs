using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;

using System.Web.Services;

namespace POS.views
{
    public partial class modifierDetail : System.Web.UI.Page
    {
        public static ListView myList = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            myList = lstvModifierDetail;

            if (!this.IsPostBack)
            {
                
                DrpListLoad();
            }

            ListLoad();
        }

        private void DrpListLoad()
        {
            string DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ConnectionString;
            SqlConnection con = new SqlConnection(DBConnectionString);

            // modifier DropdownList
            string sqlCmd = "modifierMasterSelectInsertUpdateDelete";
            using (SqlCommand cmd = new SqlCommand(sqlCmd, con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StatementType", "Select");
                cmd.Parameters.Add("@NewID", SqlDbType.Int).Direction = ParameterDirection.Output;

                SqlDataAdapter adpt = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                con.Open();
                adpt.Fill(ds);
                con.Close();

                modifierDrplst.DataSource = ds.Tables[0];
                modifierDrplst.DataValueField = "modifierID";
                modifierDrplst.DataTextField = "reference";
                modifierDrplst.DataBind();
                modifierDrplst.Items.Insert(0, new ListItem("Select One", "-1"));
            }

            // item DropdownList
            sqlCmd = "itemSelectInsertUpdateDelete";
            using (SqlCommand cmd = new SqlCommand(sqlCmd, con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StatementType", "Select");
                cmd.Parameters.Add("@NewId", SqlDbType.Int).Direction = ParameterDirection.Output;

                SqlDataAdapter adpt = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                con.Open();
                adpt.Fill(ds);
                con.Close();

                itemDrplst.DataSource = ds.Tables[0];
                itemDrplst.DataValueField = "itemID";
                itemDrplst.DataTextField = "itemName";
                itemDrplst.DataBind();
                itemDrplst.Items.Insert(0, new ListItem("Select One", "-1"));
            }
            
            
        }


        public static void ListLoad()
        {
            myList.Items.Clear();

            string DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ConnectionString;
            SqlConnection con = new SqlConnection(DBConnectionString);

            string sqlCmd = "modifierDetailSelectInsertUpdateDelete";
            using (SqlCommand cmd = new SqlCommand(sqlCmd, con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StatementType", "Select");
                cmd.Parameters.Add("@NewId", SqlDbType.Int).Direction = ParameterDirection.Output;

                SqlDataAdapter adpt = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                con.Open();
                adpt.Fill(ds);
                con.Close();

                myList.DataSource = ds;
                myList.DataBind();
            }
        }
    }
}