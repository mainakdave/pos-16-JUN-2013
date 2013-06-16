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

using System.Xml.Linq;
using System.Reflection;

namespace POS.views
{
    public partial class taxGroup : System.Web.UI.Page
    {
            public static ListView myList = null;

            protected void Page_Load(object sender, EventArgs e)
            {
                

                myList = lstvTaxGroup;

                if (!this.IsPostBack)
                {
                    DrpListLoad();
                }

                ListLoad();
            }


            public void DrpListLoad()
            {
                // country Dropdownlist
                string relPath = "~/country_state.xml";
                string absPath = Server.MapPath(relPath);
                XDocument xDoc = XDocument.Load(absPath);

                var countries = from xEle 
                                in xDoc.Descendants("country")
                                select xEle.Attribute("name").Value;

                foreach (var countryName in countries)
                {
                    country.Items.Add(countryName.ToString());
                }
                country.Items.Insert(0, new ListItem("Select One", "-1"));

                // state Dropdownlist
                var states = from xEle 
                             in xDoc.Descendants("state")
                             select xEle.Value;

                foreach (var stateName in states)
                {
                    state.Items.Add(stateName.ToString());
                }
                state.Items.Insert(0, new ListItem("Select One", "-1"));


                string DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ConnectionString;
                SqlConnection con = new SqlConnection(DBConnectionString);

                // modifier DropdownList
                string sqlCmd = "select * from serviceType";
                using (SqlCommand cmd = new SqlCommand(sqlCmd, con))
                {
                    SqlDataAdapter adpt = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();

                    con.Open();
                    adpt.Fill(ds);
                    con.Close();

                    serviceType.DataSource = ds.Tables[0];
                    serviceType.DataValueField = "serviceTypeID";
                    serviceType.DataTextField = "serviceType";
                    serviceType.DataBind();
                    serviceType.Items.Insert(0, new ListItem("Select One", "-1"));
                }

                // item DropdownList
                sqlCmd = "taxTypeSelectInsertUpdateDelete";
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

                    taxType.DataSource = ds.Tables[0];
                    taxType.DataValueField = "taxTypeID";
                    taxType.DataTextField = "description";
                    taxType.DataBind();
                    taxType.Items.Insert(0, new ListItem("Select One", "-1"));
                }
            }

            public static void ListLoad()
            {
                myList.Items.Clear();

                string DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ConnectionString;
                SqlConnection con = new SqlConnection(DBConnectionString);

                string sqlCmd = "taxGroupSelectInsertUpdateDelete";
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

            protected void country_SelectedIndexChanged(object sender, EventArgs e)
            {
                string countryName = country.SelectedValue;

                // state Dropdownlist
                string relPath = "~/country_state.xml";
                string absPath = Server.MapPath(relPath);
                XDocument xDoc = XDocument.Load(absPath);

                var states = from xEle
                             in xDoc.Descendants("state")
                             where xEle.Parent.FirstAttribute.Value == countryName
                             select xEle.Value;
                
                state.Items.Clear();

                foreach (var stateName in states)
                {
                    state.Items.Add(stateName.ToString());
                }
                state.Items.Insert(0, new ListItem("Select One", "-1"));
            }

        
    }
}