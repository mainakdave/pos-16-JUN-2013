<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="format.aspx.cs" Inherits="POS.views.format"  MasterPageFile="~/views/masterPage.Master"%>


<%@ Register src="~/piczardUserControls/simpleImageUploadUserControl/SimpleImageUpload.ascx" tagname="SimpleImageUpload" tagprefix="ccPiczardUC" %>




<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <script type="text/javascript">

        var IU = 'I';
        var ID = -1;
        var isDelete = false;

        $(document).ready(function () {

            $($(".pageContainer div:contains('Powered by ')")[$(".pageContainer div:contains('Powered by ')").length - 1]).css("display", "none");

            $(".navbar .navbar-inner .nav li").removeClass("active");
            $(".navbar .navbar-inner li#format").addClass("active");

            // positioning alertBox
            $("#alertBox").css("top", $(window).outerHeight() / 2);
            $("#alertBox").css("left", $(window).outerWidth() / 2);

            //$(".ui-keyboard").css("top", "0");

            

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


                    $.post("../Ajax/format.aspx",
                        {
                            reference: $("#reference").val(),
                            description: $("#description").val(),
                            image: "",
                            bgColor: bgColor,
                            textColor: textColor,
                            combination: $("#combination").val(),
                            portion1: $("#portion1").val(),
                            portion2: $("#portion2").val(),
                            costSecond: $("#costSecond").val(),
                            favoriteCode: $("#favoriteCode").val(),
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


                    $.post("../Ajax/format.aspx",
                        {
                            formatID: window.ID,
                            reference: $("#reference").val(),
                            description: $("#description").val(),
                            image: window.ID,
                            bgColor: bgColor,
                            textColor: textColor,
                            combination: $("#combination").val(),
                            portion1: $("#portion1").val(),
                            portion2: $("#portion2").val(),
                            costSecond: $("#costSecond").val(),
                            favoriteCode: $("#favoriteCode").val(),
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


        function updateRow(id, reference, description, bgColor, textColor, combination, portion1, portion2, costSecond, favoriteCode) {
            if (!window.isDelete) {
                //alert(id);
                //$("#deptName").val(id);
                window.IU = 'U';
                window.ID = id;



                $("#reference").val(reference);
                $("#description").val(description);
                $("#colorSelector > div").css("background-color", bgColor);
                $("#colorSelector_text > div").css("background-color", textColor);
                $("#combination").val(combination);
                $("#portion1").val(portion1);
                $("#portion2").val(portion2);
                $("#costSecond").val(costSecond);
                $("#favoriteCode").val(favoriteCode);
                PageMethods.updateRow(id);

                $("#ctl00_MainContent_ImageUploader_imgPreview").load();

                src = $("#ctl00_MainContent_ImageUploader_imgPreview").attr("src");
                src = "../uploadedImg/format/" + id + ".jpg";
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
                $.post("../Ajax/format.aspx",
                    {
                        formatID: id,
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

            $("#reference").val(null);
            $("#description").val(null);
            $("#colorSelector > div").css("background-color", "transparent");
            $("#colorSelector_text > div").css("background-color", "transparent");
            $("#combination").val(null);
            $("#portion1").val(null);
            $("#portion2").val(null);
            $("#costSecond").val(null);
            $("#favoriteCode").val(null);

            src = "../uploadedImg/" + "dummy" + ".jpg";
            $("#ctl00_MainContent_ImageUploader_imgPreview").attr("src", src);
            $("#ctl00_MainContent_ImageUploader_imgPreview").css("height", "auto");
            $("#ctl00_MainContent_ImageUploader_imgPreview").css("width", "auto");
        }
    </script>

    

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div id="alertBox" data-alerts="alerts"  data-fade="3000"></div>


        <div class="row-fluid">
            <div class="span6">
                <form class="navbar-form pull-left" id="formatForm" action="format.aspx">

                    <asp:ScriptManager runat="server" ID="ScriptManager1" EnablePageMethods="true" EnablePartialRendering="true">
                            </asp:ScriptManager>  

                    <div id="format">
                <table>
                    <tr>
                        <td><label>Reference</label></td>
                        <td><input id="reference" type="text" placeholder="Reference" class="span2" /></td>
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
                                     EnableEdit="False" />
                
                
                                </div>
                            
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            
                        </td>
                    </tr>

                    <tr>
                        <td><label>Background Coloror</label></td>
                        <td><div id="colorSelector"><div></div></div></td>
                    </tr>

                    <tr>
                        <td><label>Text Color</label></td>
                        <td><div id="colorSelector_text"><div></div></div></td>
                    </tr>

                    <tr>
                        <td><label>Combition</label></td>
                        <td><input id="combination" type="text" placeholder="Combination" class="span2" /></td>
                    </tr>

                    <tr>
                        <td><label>Portion1</label></td>
                        <td><input id="portion1" type="text" placeholder="Portion1" class="span2" /></td>
                    </tr>

                    <tr>
                        <td><label>Portion2</label></td>
                        <td><input id="portion2" type="text" placeholder="Portion2" class="span2" /></td>
                    </tr>

                    <tr>
                        <td><label>Approx cost of Portion2</label></td>
                        <td><input id="costSecond" type="text" placeholder="Approx cost of Portion2" class="span2" /></td>
                    </tr>

                    <tr>
                        <td><label>Favorite Code</label></td>
                        <td><input id="favoriteCode" type="text" placeholder="Favorite Code" class="span2" /></td>
                    </tr>

                    <tr>
                        <td></td>
                        <td>
                            

                            <div id="submit" class="btn" >Submit</div>
                            <asp:Button ID="Button1" runat="server" class="btn" Text="Button" Visible="false"/>
                            <div id="btnCancel" class="btn" >Cancel</div>
                            
                        </td>
                    </tr>                  
                                   <!-- Item Name -->
                </table>
            
                 
            
                

                
            
                <!-- Item Image -->
           </div>

                </form>
            </div>

            <div class="span6">

            <asp:UpdatePanel runat="server" ID="UpdatePanel2" UpdateMode="Always">
                <ContentTemplate>

                    <asp:Panel ID="Panel1" ScrollBars="Vertical" Height="300" runat="server">
                        <asp:ListView ID="lstvFormat" runat="server">
            <LayoutTemplate >
                <table class="table table-condensed">
                    <tr>
                        <td style="background:#00ffff; font-size:medium">Format Name List</td>
                    </tr>
                    <tr>
                        <td><asp:PlaceHolder id="itemPlaceholder" runat="server" /></td>
                    </tr>
                </table>
            </LayoutTemplate>

            <ItemTemplate>
                <tr onmouseup="updateRow(<%#Eval("formatID") %>, '<%#Eval("reference") %>', '<%#Eval("description ") %>', '<%#Eval("bgColor") %>', '<%#Eval("textColor") %>', '<%#Eval("combination") %>', '<%#Eval("portion1") %>', '<%#Eval("portion2") %>', '<%#Eval("costSecond") %>', '<%#Eval("favoriteCode") %>') ;">
                    <td>
                        <asp:Label ID="lblFormatID" runat="Server" Text='<%#Eval("formatID") %>' />
                    </td>

                    <td>
                        <asp:Label ID="lblDescription" runat="Server" Text='<%#Eval("description") %>' />
                    </td>

                    <td class="btn btn-danger btn-mini"  onmouseup="deleteRow(<%#Eval("formatID") %>)" style="cursor:pointer">Delete</td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
                    </asp:Panel>

                </ContentTemplate>
            </asp:UpdatePanel>

            </div>
        </div>
                    
        
                
                 
        
       
                

                
        
       
        

        
</asp:Content>



