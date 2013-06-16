<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="department.aspx.cs" Inherits="POS.views.department" MasterPageFile="~/views/masterPage.Master" %>

<%@ Register src="~/piczardUserControls/simpleImageUploadUserControl/SimpleImageUpload.ascx" tagname="SimpleImageUpload" tagprefix="ccPiczardUC" %>




<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <script type="text/javascript">

        var IU = 'I';
        var ID = -1;
        var isDelete = false;

        $(document).ready(function () {

            

            $($(".pageContainer div:contains('Powered by ')")[$(".pageContainer div:contains('Powered by ')").length - 1]).css("display", "none");


            //$("#dataRows tr").first().remove();

            $("#menu .nav li").removeClass("active");
            $("#menu .nav li#department").addClass("active");

            

            // positioning alertBox
            $("#alertBox").css("top", $(window).outerHeight() / 2);
            $("#alertBox").css("left", $(window).outerWidth() / 2);


            /*
            var IU = 'I';
            var ID = -1;
            var isDelete = false;
            */



            $("#btnCancel").click(function () {
                //alert(document.forms[0].name);
                //var theForm = document.forms['#departmentForm'];

                //document.getElementById("departmentForm").submit()
                //document.forms[0].submit();

                clearAllElements();
                return false;
            });



            $("#submit").click(function () {



                //$("#<%=Button1.ClientID %>").click();

                if (window.IU == 'I') {
                    var bgColor = $("#colorSelector > div").css("background-color");
                    var textColor = $("#colorSelector_text > div").css("background-color");


                    $.post("../Ajax/department.aspx",
                        {
                            deptName: $("#deptName").val(),
                            description: $("#description").val(),
                            image: "",
                            bgColor: bgColor,
                            textColor: textColor,
                            costCenter: $("#costCenter").val(),
                            saleAcct: $("#saleAcct").val(),
                            purchaseAcct: $("#purchaseAcct").val(),
                            createDate: '',
                            createUser: '-1',
                            modifyUser: '-1',
                            StatementType: 'Insert'
                        },

                        function (response) {
                            //alert(response);
                            //PageMethods.SendForm(response);
                            PageMethods.saveImage(response);

                            //alert("Data inserted...");
                            $(document).trigger("add-alerts", [
                                {
                                    'message': "Data inserted...",
                                    'priority': 'success'
                                }
                              ]);

                            clearAllElements();

                            __doPostBack("<%= UpdatePanel1.ClientID %>");
                        }
                    );

                    return false;
                }
                else if (window.IU == 'U') {
                    var bgColor = $("#colorSelector > div").css("background-color");
                    var textColor = $("#colorSelector_text > div").css("background-color");


                    $.post("../Ajax/department.aspx",
                        {
                            deptID: window.ID,
                            deptName: $("#deptName").val(),
                            description: $("#description").val(),
                            image: window.ID,
                            bgColor: bgColor,
                            textColor: textColor,
                            costCenter: $("#costCenter").val(),
                            saleAcct: $("#saleAcct").val(),
                            purchaseAcct: $("#purchaseAcct").val(),
                            modifyUser: '-1',
                            StatementType: 'Update'
                        },

                        function (response) {
                            //alert(response);
                            //PageMethods.SendForm(response);
                            PageMethods.saveImage(window.ID);
                            window.IU = 'I';

                            //alert("Data updated...");
                            $(document).trigger("add-alerts", [
                                {
                                    'message': "Data updated...",
                                    'priority': 'success'
                                }
                              ]);

                            clearAllElements();

                            __doPostBack("<%= UpdatePanel1.ClientID %>");
                        }
                    );

                    return false;
                }
            });


        });


        function updateRow(id, deptName, description, bgColor, textColor, costCenter, saleAcct, purchaseAcct) {
            if (!window.isDelete) {
                //alert(id);
                //$("#deptName").val(id);
                window.IU = 'U';
                window.ID = id;

                

                $("#deptName").val(deptName);
                $("#description").val(description);
                $("#colorSelector > div").css("background-color", bgColor);
                $("#colorSelector_text > div").css("background-color", textColor);
                $("#costCenter").val(costCenter);
                $("#saleAcct").val(saleAcct);
                $("#purchaseAcct").val(purchaseAcct);
                PageMethods.updateRow(id);

                $("#ctl00_MainContent_ImageUploader_imgPreview").load();

                src = $("#ctl00_MainContent_ImageUploader_imgPreview").attr("src");
                src = "../uploadedImg/department/" + id + ".jpg";
                $("#ctl00_MainContent_ImageUploader_imgPreview").attr("src", src);
                $("#ctl00_MainContent_ImageUploader_imgPreview").css("height", "auto");
                $("#ctl00_MainContent_ImageUploader_imgPreview").css("width", "auto");

                //args = id + "," + deptName + "," + description
                //__doPostBack("id", id);
                //return false;
                

                //alert(CodeCarvings.Wcs.Piczard.Upload.SimpleImageUpload.get_hasImage("<% =CodeCarvings.Piczard.Web.Helpers.JSHelper.EncodeString(this.ImageUploader.ClientID) %>"));
            }
        }


        function deleteRow(id) {
            window.isDelete = true;

            if (confirm('Sure To Delete?')) {
                $.post("../Ajax/department.aspx",
                    {
                        deptID: id,
                        StatementType: 'Delete'
                    },

                    function (response) {
                        //alert(response);
                        //PageMethods.SendForm(response);
                        //PageMethods.saveImage(window.ID);

                        //alert("Data deleted...");
                        $(document).trigger("add-alerts", [
                                {
                                    'message': "Data deleted...",
                                    'priority': 'error'
                                }
                              ]);

                                __doPostBack("<%= UpdatePanel1.ClientID %>");
                    }
                );
            } else {
                // Do nothing!
            }

            //clearAllElements();
            return false;
        }

        function clearAllElements() {
            window.IU = 'I';
            window.ID = -1;
            window.isDelete = false;

            $("#deptName").val(null);
            $("#description").val(null);
            $("#colorSelector > div").css("background-color", "transparent");
            $("#colorSelector_text > div").css("background-color", "transparent");
            $("#costCenter").val(null);
            $("#saleAcct").val(null);
            $("#purchaseAcct").val(null);

            src = "../uploadedImg/" + "dummy" + ".jpg";
            $("#ctl00_MainContent_ImageUploader_imgPreview").attr("src", src);
            $("#ctl00_MainContent_ImageUploader_imgPreview").css("height", "auto");
            $("#ctl00_MainContent_ImageUploader_imgPreview").css("width", "auto");
        }

        function searchKeyword(searchText) {
            if ($("#<%= searchBy.ClientID %>").val() != -1) {
                __doPostBack("<%= UpdatePanel2.ClientID %>", $("#<%= searchBy.ClientID %>").val() + ":,:" + searchText);         
            }
            else
            {
                alert("Select search criteria!!!");
            }
        }

        function clearSearch() {
            $("#<%= searchBy.ClientID %>").val("-1");
            $("#<%= searchText.ClientID %>").val(null);
            
            __doPostBack("<%= UpdatePanel2.ClientID %>", "clearSearch");

        }
      </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div id="alertBox" data-alerts="alerts"  data-fade="3000"></div>


        <!-- <div class="row-fluid"> -->
        
        <!-- </div> -->
        <div class="tabbable"> 

            <ul class="nav nav-tabs">
                <li id="tab1Ref" class="active"><a href="#tab1" data-toggle="tab">List</a></li>
                <li id="tab2Ref"><a href="#tab2" data-toggle="tab">Create New</a></li>
            </ul>

            <div class="tab-content">
                <div class="tab-pane active" id="tab1">

                    <asp:ScriptManager runat="server" ID="ScriptManager1" EnablePageMethods="true" EnablePartialRendering="true">
                            </asp:ScriptManager> 

                    <asp:UpdatePanel runat="server" ID="UpdatePanel2" UpdateMode="Always">
                <ContentTemplate>

                    <div id="searchArea">
                        <asp:DropDownList id="searchBy" runat="server" AutoPostBack="false">
                            <asp:ListItem Value="-1" Text="Select Search By"></asp:ListItem>
                            <asp:ListItem Value="deptName" Text="Department Name"></asp:ListItem>
                            <asp:ListItem Value="deptID" Text="Department ID"></asp:ListItem>
                        </asp:DropDownList>
                        <!--
                        <select id="searchBy">
                            <option value="-1">Select Search By</option>
                            <option value="deptName">Department Name</option>
                            <option value="deptID">Department ID</option>
                        </select>
                        -->
                        <asp:TextBox id="searchText" class="searchText" runat="server" AutoPostBack="false" placeholder="search keyword..."  onkeyup="searchKeyword(this.value);" ></asp:TextBox>

                        <label id="clearSearch" title="Clear Search" onclick="clearSearch();">Clear Search</label>
                    </div>

                    <!-- <asp:Panel ID="Panel1" ScrollBars="Vertical" Height="300" runat="server"> -->
                        <asp:ListView ID="lstvDept" runat="server" 
            onselectedindexchanged="lstvDept_SelectedIndexChanged">
            <LayoutTemplate >
                <!-- <label style="background:#00ffff; font-size:medium; padding:10px 7px;">Department Name List</label> -->

                <table class="table table-condensed" id="dataRows">
                    <tr>
                        <th>Department ID</th>
                        <th>Department Name</th>
                    </tr>
                    <asp:PlaceHolder id="itemPlaceholder" runat="server" />
                </table>
            </LayoutTemplate>

            <ItemTemplate>
             

                <asp:PlaceHolder id="itemPlaceholder" runat="server" />
                <tr ondblclick="updateRow(<%#Eval("deptID") %>, '<%#Eval("deptName") %>', '<%#Eval("description ") %>', '<%#Eval("bgColor") %>', '<%#Eval("textColor") %>', '<%#Eval("costCenter") %>', '<%#Eval("saleAcct") %>', '<%#Eval("purchaseAcct") %>') ;
                                $('#tab2').addClass('active');
                                $('#tab2Ref').addClass('active');

                                $('#tab1').removeClass('active');
                                $('#tab1Ref').removeClass('active');
                                $('#tab2Ref a').html('Edit / Update');
                ">
                    <td>
                        <asp:Label ID="lblDeptID" runat="Server" Text='<%#Eval("deptID") %>' />
                    </td>

                    <td>
                        <asp:Label ID="lblDeptName" runat="Server" Text='<%#Eval("deptName") %>' />
                    </td>

                    <td class="btn btn-danger btn-mini"  onmouseup="deleteRow(<%#Eval("deptID") %>)" style="cursor:pointer"></td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
                        
                        <!--
                        <asp:DataPager ID="pager" runat="server" PageSize="10" PagedControlID="lstvDept">
                            <Fields>
                                <asp:NumericPagerField />
                            </Fields>
                        </asp:DataPager>
                        -->

                    <!-- </asp:Panel> -->


                    <div class="pagination">
                        <asp:DataPager ID="DataPager" runat="server" PagedControlID="lstvDept" PageSize="5" >
                            <Fields>
                                <asp:NextPreviousPagerField PreviousPageText="<" FirstPageText="<<" ShowFirstPageButton="true" ShowNextPageButton="False" />
                                <asp:NumericPagerField  />
                                <asp:NextPreviousPagerField NextPageText=">" LastPageText=">>" ShowLastPageButton="true" ShowPreviousPageButton="False" />
                                <asp:TemplatePagerField>
                                    <PagerTemplate>
                                        <b>
                                            Page
                                            <asp:Label runat="server" ID="CurrentPageLabel" 
                                              Text="<%# Container.TotalRowCount>0 ? (Container.StartRowIndex / Container.PageSize) + 1 : 0 %>" />
                                            of
                                            <asp:Label runat="server" ID="TotalPagesLabel" 
                                              Text="<%# Math.Ceiling ((double)Container.TotalRowCount / Container.PageSize) %>" />
                                            [ Total Records = 
                                            <asp:Label runat="server" ID="TotalItemsLabel" 
                                              Text="<%# Container.TotalRowCount%>" />
                                            ]
                                            <br />
                                         </b>
                                    </PagerTemplate>
                                </asp:TemplatePagerField>
                            </Fields>
                        </asp:DataPager>
                    </div>

                </ContentTemplate>

                
            </asp:UpdatePanel>


            
                </div>

                <div class="tab-pane" id="tab2">
                    <form class="navbar-form pull-left" id="departmentForm" action="department.aspx">

                     

                    <div id="department">
                <table>
                    <tr>
                        <td><label>Department Name</label></td>
                        <td><input id="deptName" type="text" placeholder="Department Name" class="span2" /></td>
                    </tr>

                    <tr>
                        <td><label>Description</label></td>
                        <td><input id="description" type="text" placeholder="Description" class="span2" /></td>
                    </tr>

                    <tr>
                        <td><label>Image</label></td>
                        <td>

                                      


                             <asp:UpdatePanel runat="server" ID="UpdatePanel1" UpdateMode="Always">
                                <ContentTemplate>
                             
                                <div class="pageContainer">  
                           
                                    <ccPiczardUC:SimpleImageUpload ID="ImageUploader" runat="server" 
                                        Width="500px"
                                        AutoOpenImageEditPopupAfterUpload="true"
                                        Culture="en" 
                                     EnableEdit="False" Text_BrowseButton=" Browse" Text_RemoveButton=" Remove" 
                                        Text_CancelUploadButton="Cancel" />
                
                
                                </div>
                            
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            
                        </td>
                    </tr>

                    <tr>
                        <td><label>Background Color</label></td>
                        <td><div id="colorSelector"><div></div></div>
                            <input class="colorSelectorTxt" id="backgroundColorCode" type="text" placeholder="Background Color Code" />
                        </td>
                    </tr>

                    <tr>
                        <td><label>Text Color</label></td>
                        <td><div id="colorSelector_text"><div></div></div>
                            <input class="colorSelectorTxt" id="textColorCode" type="text" placeholder="Text Color Code" />
                        </td>
                    </tr>

                    <tr>
                        <td><label>Cost Center</label></td>
                        <td><input id="costCenter" type="text" placeholder="Cost Center" class="span2" /></td>
                    </tr>

                    <tr>
                        <td><label>Sale Acct</label></td>
                        <td><input id="saleAcct" type="text" placeholder="Sale Acct" class="span2" /></td>
                    </tr>

                    <tr>
                        <td><label>Purchase Acct</label></td>
                        <td><input id="purchaseAcct" type="text" placeholder="Purchase Acct" class="span2" /></td>
                    </tr>

                    <tr>
                        <td></td>
                        <td>
                            

                            <div id="submit" class="btn" >Submit</div>
                            <asp:Button ID="Button1" runat="server" class="btn" Text="Button" onclick="Button1_Click" Visible="false"/>
                            <div id="btnCancel" class="btn" >Cancel</div>
                            
                        </td>
                    </tr>                  
                                   <!-- Item Name -->
                </table>
            
                 
            
                

                
            
                <!-- Item Image -->
           </div>

                </form>
                </div>
            </div>
        </div>
                
                 
        
       
                


        
       
        

        
</asp:Content>
