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
    public partial class format : System.Web.UI.Page
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
            myList = lstvFormat;
            myUpdatePanel = UpdatePanel1;


            if (!this.IsPostBack)
            {
                string fileName = "dummy";
                string sourceImageFilePath = "~/uploadedImg/" + fileName + ".jpg";
                imgUpload.LoadImageFromFileSystem(sourceImageFilePath);

                //imgUpload.UnloadImage();

                
            }

            ListLoad();
        }

        public static void ListLoad()
        {
            myList.Items.Clear();

            string DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ConnectionString;
            SqlConnection con = new SqlConnection(DBConnectionString);

            string sqlCmd = "formatSelectInsertUpdateDelete";
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
        public static void saveImage(int newID)
        {
            string fileName = newID.ToString();

            if (imgUpload.HasNewImage)
            {
                imgUpload.SaveProcessedImageToFileSystem("~/uploadedImg/format/" + fileName + ".jpg");
            }

            ListLoad();
        }

        [WebMethod]
        public static void updateRow(int id)
        {
            imgUpload.UnloadImage();


            imgUpload.LoadControl("~/piczardUserControls/simpleImageUploadUserControl/SimpleImageUpload.ascx");

            string fileName = id.ToString();
            string sourceImageFilePath = "~/uploadedImg/format/" + fileName + ".jpg";
            imgUpload.LoadImageFromFileSystem(sourceImageFilePath);


            imgUpload.LoadControl("~/piczardUserControls/simpleImageUploadUserControl/SimpleImageUpload.ascx");

            ListLoad();
        }
    }
}