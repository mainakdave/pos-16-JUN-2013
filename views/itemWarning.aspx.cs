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
    public partial class itemWarning : System.Web.UI.Page
    {
        public static ListView myList = null;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            myList = lstvItemWarning;

            if (!this.IsPostBack)
            {
                
                DrpListLoad();
            }

            ListLoad();
        }

        public void DrpListLoad()
        {
            ListItem item0 = new ListItem("Select One", "-1");
            ListItem item1 = new ListItem("User1", "1");
            ListItem item2 = new ListItem("User2", "2");
            usersDrpLst.Items.Add(item0);
            usersDrpLst.Items.Add(item1);
            usersDrpLst.Items.Add(item2);
        }

        public static void ListLoad()
        {
            myList.Items.Clear();

            string DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ConnectionString;
            SqlConnection con = new SqlConnection(DBConnectionString);

            string sqlCmd = "itemWarningSelectInsertUpdateDelete";
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