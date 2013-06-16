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
using System.Web.Hosting;


namespace POS.views
{
    public partial class itemPics : System.Web.UI.Page
    {
        public static char IU = 'I';

        public static System.Web.UI.Page myPageInstance = null;
        public static SimpleImageUpload imgUpload = null;
        public static ListView myList = null;
        public static UpdatePanel myUpdatePanel = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            myPageInstance = this;
            imgUpload = ImageUploader;
            myList = lstvItemPics;
            myUpdatePanel = UpdatePanel1;


            if (!this.IsPostBack)
            {
                string fileName = "dummy";
                string sourceImageFilePath = "~/uploadedImg/" + fileName + ".jpg";
                imgUpload.LoadImageFromFileSystem(sourceImageFilePath);

                //imgUpload.UnloadImage();

                
                DrpListLoad();
            }

            ListLoad();
        }

        private void DrpListLoad()
        {

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

                item.DataSource = ds.Tables[0];
                item.DataValueField = "itemID";
                item.DataTextField = "itemName";
                item.DataBind();
                item.Items.Insert(0, new ListItem("Select One", "-1"));
            }

        }

        public static void ListLoad()
        {
            myList.Items.Clear();

            string DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ConnectionString;
            SqlConnection con = new SqlConnection(DBConnectionString);

            string sqlCmd = "itemPicsSelectInsertUpdateDelete";
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

        [WebMethod]
        public static void saveImage(int itemID, int newID)
        {
            string fileName = newID.ToString();

            if (imgUpload.HasNewImage)
            {
                
                string subPath = "~/uploadedImg/itemPics/" + itemID; // your code goes here
                string refPath = HostingEnvironment.MapPath(subPath);

                bool IsExists = System.IO.Directory.Exists(refPath);

                if (!IsExists)
                    System.IO.Directory.CreateDirectory(refPath);
                

                imgUpload.SaveProcessedImageToFileSystem("~/uploadedImg/itemPics/" + itemID + "/" + fileName + ".jpg");
            }

            ListLoad();
        }
    }
}