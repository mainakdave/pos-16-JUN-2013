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
using CodeCarvings;

namespace POS.views
{
    public partial class item : System.Web.UI.Page
    {
        public static ListView myList = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            myList = lstvItem;

            if (!this.IsPostBack)
            {
                DrpListLoad();
                
            }

            ListLoad();
        }

        private void DrpListLoad()
        {
            string DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ToString();
            SqlConnection con = new SqlConnection(DBConnectionString);

            // Department DropdownList
            string sqlcmd = "departmentSelectInsertUpdateDelete";
            using (SqlCommand cmd = new SqlCommand(sqlcmd, con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StatementType", "Select");
                cmd.Parameters.Add("@NewID", SqlDbType.Int).Direction = ParameterDirection.Output;

                SqlDataAdapter adpt = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                con.Open();
                adpt.Fill(ds);
                con.Close();

                deptDrplst.DataSource = ds.Tables[0];
                deptDrplst.DataValueField = "deptID";
                deptDrplst.DataTextField = "deptName";
                deptDrplst.DataBind();
                deptDrplst.Items.Insert(0, new ListItem("Select One", "-1"));
            }

            // brand DropdownList
            sqlcmd = "brandSelectInsertUpdateDelete";
            using (SqlCommand cmd = new SqlCommand(sqlcmd, con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StatementType", "Select");
                cmd.Parameters.Add("@NewID", SqlDbType.Int).Direction = ParameterDirection.Output;

                SqlDataAdapter adpt = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                con.Open();
                adpt.Fill(ds);
                con.Close();

                brandDrplst.DataSource = ds.Tables[0];
                brandDrplst.DataValueField = "brandID";
                brandDrplst.DataTextField = "brandName";
                brandDrplst.DataBind();
                brandDrplst.Items.Insert(0, new ListItem("Select One", "-1"));
            }

            //  itemWarning DropdownList
            sqlcmd = "itemWarningSelectInsertUpdateDelete";
            using (SqlCommand cmd = new SqlCommand(sqlcmd, con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StatementType", "Select");
                cmd.Parameters.Add("@NewID", SqlDbType.Int).Direction = ParameterDirection.Output;

                SqlDataAdapter adpt = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                con.Open();
                adpt.Fill(ds);
                con.Close();

                itemWarning.DataSource = ds.Tables[0];
                itemWarning.DataValueField = "warningID";
                itemWarning.DataTextField = "warningMessage";
                itemWarning.DataBind();

                itemWarning.Items.Insert(0, new ListItem("Select One", "-1"));
            }
        }

        public static void ListLoad()
        {
            myList.Items.Clear();

            string DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ConnectionString;
            SqlConnection con = new SqlConnection(DBConnectionString);

            string sqlCmd = "itemSelectInsertUpdateDelete";
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


        protected void deptDrplst_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (deptDrplst.SelectedIndex != -1)
            {
                string DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ToString();
                SqlConnection con = new SqlConnection(DBConnectionString);

                // Section DropdownList
                string sqlcmd = "sectionSelectInsertUpdateDelete";
                using (SqlCommand cmd = new SqlCommand(sqlcmd, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@deptID", deptDrplst.SelectedIndex);
                    cmd.Parameters.AddWithValue("@StatementType", "Select");
                    cmd.Parameters.Add("@NewID", SqlDbType.Int).Direction = ParameterDirection.Output;

                    SqlDataAdapter adpt = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();

                    con.Open();
                    adpt.Fill(ds);
                    con.Close();

                    sectionDrplst.DataSource = ds.Tables[0];
                    sectionDrplst.DataValueField = "sectionID";
                    sectionDrplst.DataTextField = "sectionName";
                    sectionDrplst.DataBind();
                    sectionDrplst.Items.Insert(0, new ListItem("Select One", "-1"));
                }
            }
        }

        protected void sectionDrplst_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (deptDrplst.SelectedIndex != -1 && sectionDrplst.SelectedIndex != -1)
            {
                string DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ToString();
                SqlConnection con = new SqlConnection(DBConnectionString);

                // Section DropdownList
                string sqlcmd = "familySelectInsertUpdateDelete";
                using (SqlCommand cmd = new SqlCommand(sqlcmd, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@deptID", deptDrplst.SelectedIndex);
                    cmd.Parameters.AddWithValue("@sectionID", sectionDrplst.SelectedIndex);
                    cmd.Parameters.AddWithValue("@StatementType", "Select");
                    cmd.Parameters.Add("@NewID", SqlDbType.Int).Direction = ParameterDirection.Output;

                    SqlDataAdapter adpt = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();

                    con.Open();
                    adpt.Fill(ds);
                    con.Close();

                    familyDrplst.DataSource = ds.Tables[0];
                    familyDrplst.DataValueField = "familyID";
                    familyDrplst.DataTextField = "familyName";
                    familyDrplst.DataBind();
                    familyDrplst.Items.Insert(0, new ListItem("Select One", "-1"));
                }
            }
        }

        protected void brandDrplst_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (brandDrplst.SelectedIndex != -1)
            {
                string DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ToString();
                SqlConnection con = new SqlConnection(DBConnectionString);

                // Section DropdownList
                string sqlcmd = "lineSelectInsertUpdateDelete";
                using (SqlCommand cmd = new SqlCommand(sqlcmd, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@brandID", brandDrplst.SelectedIndex);
                    cmd.Parameters.AddWithValue("@StatementType", "Select");
                    cmd.Parameters.Add("@NewID", SqlDbType.Int).Direction = ParameterDirection.Output;

                    SqlDataAdapter adpt = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();

                    con.Open();
                    adpt.Fill(ds);
                    con.Close();

                    lineDrplst.DataSource = ds.Tables[0];
                    lineDrplst.DataValueField = "lineID";
                    lineDrplst.DataTextField = "description";
                    lineDrplst.DataBind();
                    lineDrplst.Items.Insert(0, new ListItem("Select One", "-1"));
                }
            }
        }


    }


}