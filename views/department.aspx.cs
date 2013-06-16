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
    public partial class department : System.Web.UI.Page
    {
        public static DataSet myDS = null;

        public static char IU = 'I';

        public static System.Web.UI.Page myPageInstance = null;
        public static SimpleImageUpload imgUpload = null;
        public static ListView myList = null;
        public static UpdatePanel myUpdatePanel = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            myPageInstance = this;
            imgUpload = ImageUploader;
            myList = lstvDept;
            myUpdatePanel = UpdatePanel1;

            
            if (!this.IsPostBack)
            {
                string fileName = "dummy";
                string sourceImageFilePath = "~/uploadedImg/" + fileName + ".jpg";
                imgUpload.LoadImageFromFileSystem(sourceImageFilePath);
                
                //imgUpload.UnloadImage();

            }

            ListLoad();
            
            string parameter = Request["__EVENTARGUMENT"];
            if (parameter != null && parameter != "")
            {
                int spliterInt = parameter.IndexOf(":,:");
                if (spliterInt > 0)
                {
                    string searchBy = parameter.Substring(0, spliterInt);
                    string searchKeyword = parameter.Substring(spliterInt + 3);

                    
                    switch (searchBy)
                    {
                        case "deptName":
                            myDS.Tables[0].DefaultView.RowFilter = searchBy.Trim() + " like '" + searchKeyword.Trim() + "*'";
                            break;

                        case "deptID":
                            myDS.Tables[0].DefaultView.RowFilter = searchBy.Trim() + " = " + int.Parse(searchKeyword.Trim());
                            break;
                    }

                    myList.DataSource = myDS.Tables[0].DefaultView;
                    myList.DataBind();
                }
                else
                {
                    myList.DataSource = myDS;
                    myList.DataBind();
                }
            }
        }

        public static void ListLoad()
        {
            myList.Items.Clear();

            string DBConnectionString = ConfigurationManager.ConnectionStrings["POSDB"].ConnectionString;
            SqlConnection con = new SqlConnection(DBConnectionString);

            string sqlCmd = "departmentSelectInsertUpdateDelete";
            using (SqlCommand cmd = new SqlCommand(sqlCmd, con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StatementType", "Select");
                cmd.Parameters.Add("@NewId", SqlDbType.Int).Direction = ParameterDirection.Output;

                SqlDataAdapter adpt = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                myDS = ds;

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
                imgUpload.SaveProcessedImageToFileSystem("~/uploadedImg/department/" + fileName + ".jpg");
            }

            ListLoad();
        }

        [WebMethod]
        public static void updateRow(int id)
        {
            imgUpload.UnloadImage();

            
            imgUpload.LoadControl("~/piczardUserControls/simpleImageUploadUserControl/SimpleImageUpload.ascx");

            string fileName = id.ToString();
            string sourceImageFilePath = "~/uploadedImg/department/" + fileName + ".jpg";
            imgUpload.LoadImageFromFileSystem(sourceImageFilePath);
            
            
            imgUpload.LoadControl("~/piczardUserControls/simpleImageUploadUserControl/SimpleImageUpload.ascx");
            
            ListLoad();
        }

        [WebMethod]
        public static void SendForm(int newID)
        {
            string fileName = newID.ToString();

            //saveImage(newID);
            if (imgUpload.HasNewImage)
            {
                imgUpload.SaveProcessedImageToFileSystem("~/uploadedImg/department/" + fileName + ".jpg");
            }
        }

        

        protected void Button1_Click(object sender, EventArgs e)
        {
            string fileName = sender.ToString();
            fileName = "dept1";

            if (ImageUploader.HasNewImage)
            {
                ImageUploader.SaveProcessedImageToFileSystem("~/uploadedImg/department/" + fileName + ".jpg");
            }

            ListLoad();
        }

        protected void onImageUpload(object sender, EventArgs e)
        {
            if (ImageUploader.HasNewImage)
            {
                //ImageUpload1.SaveProcessedImageToFileSystem("~/uploadedImg/MyImage.jpg");
            }
        }

        protected void onDataBinding(object sender, EventArgs e)
        {
            if (ImageUploader.HasNewImage)
            {
                //ImageUpload1.SaveProcessedImageToFileSystem("~/uploadedImg/MyImage.jpg");
            }
        }

        protected void lstvDept_SelectedIndexChanged(object sender, EventArgs e)
        {
            //ListView.SelectedListViewItemCollection breakfast = lstvDept.selectedI.SelectedItems;
        }

        protected void searchText_TextChanged(object sender, EventArgs e)
        {
            
        }
    }
}