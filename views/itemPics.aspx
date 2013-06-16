<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="itemPics.aspx.cs" Inherits="POS.views.itemPics" MasterPageFile="~/views/masterPage.Master" %>

<%@ Register src="~/piczardUserControls/simpleImageUploadUserControl/SimpleImageUpload.ascx" tagname="SimpleImageUpload" tagprefix="ccPiczardUC" %>




<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <script type="text/javascript">

        var IU = 'I';
        var ID = -1;
        var isDelete = false;

        $(document).ready(function () {

            $($(".pageContainer div:contains('Powered by ')")[$(".pageContainer div:contains('Powered by ')").length - 1]).css("display", "none");

            $(".navbar .navbar-inner .nav li").removeClass("active");
            $(".navbar .navbar-inner li#itemPics").addClass("active");

            // positioning alertBox
            $("#alertBox").css("top", $(window).outerHeight() / 2);
            $("#alertBox").css("left", $(window).outerWidth() / 2);


            $("#btnCancel").click(function () {
                clearAllElements();
                return false;
            });



            $("#submit").click(function () {

                if (window.IU == 'I') {
                    
                    $.post("../Ajax/itemPics.aspx",
                        {
                            itemID: $("#<%=item.ClientID %>").val(),
                            image: "",
                            reference: $("#reference").val(),
                            description: $("#description").val(),
                            createDate: '',
                            createUser: '-1',
                            modifyUser: '-1',
                            StatementType: 'Insert'
                        },

                        function (response) {
                            PageMethods.saveImage($("#<%=item.ClientID %>").val(), response);

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
                    $.post("../Ajax/itemPics.aspx",
                        {
                            itemPicID: window.ID,
                            itemID: $("#<%=item.ClientID %>").val(),
                            image: "",
                            reference: $("#reference").val(),
                            description: $("#description").val(),
                            modifyUser: '-1',
                            StatementType: 'Update'
                        },

                        function (response) {
                            PageMethods.saveImage($("#<%=item.ClientID %>").val(), window.ID);
                            window.IU = 'I';

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


        function updateRow(id, item, reference, description) {
            if (!window.isDelete) {
                window.IU = 'U';
                window.ID = id;

                $("#<%=item.ClientID %>").val(item);
                $("#reference").val(reference);
                $("#description").val(description);
                
                $("#ctl00_MainContent_ImageUploader_imgPreview").load();

                src = $("#ctl00_MainContent_ImageUploader_imgPreview").attr("src");
                src = "../uploadedImg/itemPics/" + item + "/" + id + ".jpg";
                $("#ctl00_MainContent_ImageUploader_imgPreview").attr("src", src);
                $("#ctl00_MainContent_ImageUploader_imgPreview").css("height", "auto");
                $("#ctl00_MainContent_ImageUploader_imgPreview").css("width", "auto");

            }
        }


        function deleteRow(id) {
            window.isDelete = true;

            if (confirm('Sure To Delete?')) {
                $.post("../Ajax/itemPics.aspx",
                    {
                        itemPicID: id,
                        StatementType: 'Delete'
                    },

                    function (response) {
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

            $("input[type=text]").val(null);
            $("select").val(-1);

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
                <form class="navbar-form pull-left" id="itemPicsForm" action="itemPics.aspx">

                    <asp:ScriptManager runat="server" ID="ScriptManager1" EnablePageMethods="true" EnablePartialRendering="true">
                            </asp:ScriptManager>  

                    <div id="itemPics">
                <table>
                    <tr>
                        <td><label>Item</label></td>
                        <td><asp:DropDownList id="item" runat="server"></asp:DropDownList></td>
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
                        <td><label>Reference</label></td>
                        <td><input id="reference" type="text" placeholder="Reference" class="span2" /></td>
                    </tr>

                    <tr>
                        <td><label>Description</label></td>
                        <td><input id="description" type="text" placeholder="Description" class="span2" /></td>
                    </tr>
                    
                    <tr>
                        <td></td>
                        <td>
                            <div id="submit" class="btn" >Submit</div>
                            <asp:Button ID="Button1" runat="server" class="btn" Text="Button" Visible="false"/>
                            <div id="btnCancel" class="btn" >Cancel</div>
                        </td>
                    </tr>                  
                </table>
            
           </div>

                </form>
            </div>

            <div class="span6">

            <asp:UpdatePanel runat="server" ID="UpdatePanel2" UpdateMode="Always">
                <ContentTemplate>

                    <asp:Panel ScrollBars="Vertical" Height="300" runat="server">
                        <asp:ListView ID="lstvItemPics" runat="server">
            <LayoutTemplate >
                <table class="table table-condensed">
                    <tr>
                        <td style="background:#00ffff; font-size:medium">Item Pics List</td>
                    </tr>
                    <tr>
                        <td><asp:PlaceHolder id="itemPlaceholder" runat="server" /></td>
                    </tr>
                </table>
            </LayoutTemplate>

            <ItemTemplate>
                <tr onmouseup="updateRow(<%#Eval("itemPicID") %>, <%#Eval("itemID") %>, '<%#Eval("reference") %>', '<%#Eval("description ") %>') ;">
                    <td>
                        <asp:Label ID="lblID" runat="Server" Text='<%#Eval("itemPicID") %>' />
                    </td>

                    <td>
                        <asp:Label ID="lblItemImageID" runat="Server" Text='<%#Eval("itemPicID") %>' />
                    </td>

                    <td class="btn btn-danger btn-mini"  onmouseup="deleteRow(<%#Eval("itemPicID") %>)" style="cursor:pointer">Delete</td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
                    </asp:Panel>

                </ContentTemplate>
            </asp:UpdatePanel>

            </div>
        </div>
        
</asp:Content>
