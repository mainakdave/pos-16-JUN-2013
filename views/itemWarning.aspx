<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="itemWarning.aspx.cs" Inherits="POS.views.itemWarning" MasterPageFile="~/views/masterPage.Master" %>

<%@ Register src="~/piczardUserControls/simpleImageUploadUserControl/SimpleImageUpload.ascx" tagname="SimpleImageUpload" tagprefix="ccPiczardUC" %>



<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <script type="text/javascript">

        var IU = 'I';
        var ID = -1;
        var isDelete = false;

        $(document).ready(function () {

            $(".navbar .navbar-inner .nav li").removeClass("active");
            $(".navbar .navbar-inner li#itemWarning").addClass("active");

            $("#itemPages .btn-group .dropdown-toggle").html("Item Warning<span class='caret'></span>");

            // positioning alertBox
            $("#alertBox").css("top", $(window).outerHeight() / 2);
            $("#alertBox").css("left", $(window).outerWidth() / 2);


            

            $("#btnCancel").click(function () {
                clearAllElements();
                return false;
            });



            $("#submit").click(function () {

                var allUserValue = -1;
                if ($('#allUser').is(":checked")) { allUserValue = 1; }
                else { allUserValue = 0; }

                
                if (window.IU == 'I') {

                    $.post("../Ajax/itemWarning.aspx",
                        {
                            allUser: allUserValue,
                            users: $('#<%=usersDrpLst.ClientID %>').val(),
                            warningMessage: $("#warningMessage").val(),
                            createDate: '',
                            createUser: '-1',
                            modifyUser: '-1',
                            StatementType: 'Insert'
                        },

                        function (response) {
                            //alert(response);
                            //PageMethods.SendForm(response);
                            //PageMethods.saveImage(response);

                            //alert("Data inserted...");
                            $(document).trigger("add-alerts", [
                                {
                                    'message': "Data inserted...",
                                    'priority': 'success'
                                }
                              ]);

                                clearAllElements();

                                __doPostBack("<%= UpdatePanel2.ClientID %>");
                        }
                    );

                    return false;
                }
                else if (window.IU == 'U') {
                    $.post("../Ajax/itemWarning.aspx",
                        {
                            warningID: window.ID,
                            allUser: allUserValue,
                            users: $('#<%=usersDrpLst.ClientID %>').val(),
                            warningMessage: $("#warningMessage").val(),
                            modifyUser: '-1',
                            StatementType: 'Update'
                        },

                        function (response) {
                            //alert(response);
                            //PageMethods.SendForm(response);
                            //PageMethods.saveImage(window.ID);
                            window.IU = 'I';

                            //alert("Data updated...");
                            $(document).trigger("add-alerts", [
                                {
                                    'message': "Data updated...",
                                    'priority': 'success'
                                }
                              ]);

                                clearAllElements();

                                __doPostBack("<%= UpdatePanel2.ClientID %>");
                        }
                    );

                    return false;
                }
            });


        });


        function updateRow(id, allUser, users, warningMessage) {
            if (!window.isDelete) {
                //alert(id);
                //$("#deptName").val(id);
                window.IU = 'U';
                window.ID = id;

                //alert(users);
                if (allUser == "1") $("#allUser").prop("checked", true);
                else $("#allUser").prop("checked", false);
                $("#<%=usersDrpLst.ClientID %>").val(users);
                $("#warningMessage").val(warningMessage);
                //PageMethods.updateRow(id);

            }
        }


        function deleteRow(id) {
            window.isDelete = true;

            if (confirm('Sure To Delete?')) {
                $.post("../Ajax/itemWarning.aspx",
                    {
                        warningID: id,
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

                                __doPostBack("<%= UpdatePanel2.ClientID %>");
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

            $("#allUser").prop("checked", false);
            $('#<%=usersDrpLst.ClientID %>').val(-1);
            $("#warningMessage").val(null);

        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div id="alertBox" data-alerts="alerts"  data-fade="3000"></div>


        <div class="row-fluid">
            <div class="span6">
                <form class="navbar-form pull-left" id="itemWarningForm" action="itemWarning.aspx">

                    <asp:ScriptManager runat="server" ID="ScriptManager1" EnablePageMethods="true" EnablePartialRendering="true">
                            </asp:ScriptManager>  

                    <div id="itemWarning">
                        <table>
                            <tr>
                                <td><label>All Users</label></td>
                                <td><input id="allUser" type="checkbox" class="span2" /></td>
                            </tr>

                            <tr>
                                <td><label>Users</label></td>
                                <td><asp:DropDownList ID="usersDrpLst" runat="server"></asp:DropDownList></td>
                            </tr>

                    
                            <tr>
                                <td><label>Warning Message</label></td>
                                <td><input id="warningMessage" type="text" placeholder="Warning Message" class="span2" /></td>
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
                        <asp:ListView ID="lstvItemWarning" runat="server">
                            <LayoutTemplate >
                                <table class="table table-condensed">
                                    <tr>
                                        <td style="background:#00ffff; font-size:medium">Item Warning List</td>
                                    </tr>
                                    <tr>
                                        <td><asp:PlaceHolder id="itemPlaceholder" runat="server" /></td>
                                    </tr>
                                </table>
                            </LayoutTemplate>

                            <ItemTemplate>
                                <tr onmouseup="updateRow(<%#Eval("warningID") %>, '<%#Eval("allUser") %>', '<%#Eval("users") %>', '<%#Eval("warningMessage") %>') ;">
                                    <td>
                                        <asp:Label ID="lblWarningID" runat="Server" Text='<%#Eval("warningID") %>' />
                                    </td>

                                    <td>
                                        <asp:Label ID="lblWarningMessage" runat="Server" Text='<%#Eval("warningMessage") %>' />
                                    </td>

                                    <td class="btn btn-danger btn-mini"  onmouseup="deleteRow(<%#Eval("warningID") %>)" style="cursor:pointer">Delete</td>
                                </tr>
                            </ItemTemplate>
                       </asp:ListView>
                  </asp:Panel>

                </ContentTemplate>
            </asp:UpdatePanel>

            </div>
        </div>
                    
        
                
                 
        
       
                


        
       
        

        
</asp:Content>

