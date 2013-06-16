<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="modifierMaster.aspx.cs" Inherits="POS.views.modifierMaster" MasterPageFile="~/views/masterPage.Master" %>


<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <script type="text/javascript">

        var IU = 'I';
        var ID = -1;
        var isDelete = false;

        $(document).ready(function () {

            $(".navbar .navbar-inner .nav li").removeClass("active");
            $(".navbar .navbar-inner li#modifierMaster").addClass("active");

            // positioning alertBox
            $("#alertBox").css("top", $(window).outerHeight() / 2);
            $("#alertBox").css("left", $(window).outerWidth() / 2);


            $("#btnCancel").click(function () {
                clearAllElements();
                return false;
            });



            $("#submit").click(function () {

                

                if ($("#<%=divisible.ClientID %>").prop("checked")) { divisibleVAL = '1'; } else { divisibleVAL = '0'; }


                if (window.IU == 'I') {
                    $.post("../Ajax/modifierMaster.aspx",
                        {
                            reference: $("#reference").val(),
                            description: $("#description").val(),
                            divisible: divisibleVAL,
                            comment: $("#comment1").val(),

                            createDate: '',
                            createUser: '-1',
                            modifyUser: '-1',
                            StatementType: 'Insert'
                        },

                        function (response) {
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


                    $.post("../Ajax/modifierMaster.aspx",
                        {
                            modifierID: window.ID,

                            reference: $("#reference").val(),
                            description: $("#description").val(),
                            divisible: divisibleVAL,
                            comment: $("#comment1").val(),

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


        function updateRow(id, reference, description, divisible, comment) {
            if (!window.isDelete) {
                window.IU = 'U';
                window.ID = id;

                $("#reference").val(reference);
                $("#description").val(description);
                if (divisible == 1 || divisible == '1') { $("#<%=divisible.ClientID %>").prop("checked", true); }
                $("#comment1").val(comment);
            }
        }


        function deleteRow(id) {
            window.isDelete = true;

            if (confirm('Sure To Delete?')) {
                $.post("../Ajax/modifierMaster.aspx",
                    {
                        modifierID: id,
                        StatementType: 'Delete'
                    },

                    function (response) {
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

            $("input[type='text']").val(null);
            $("input[type='checkbox']").prop('checked', false);
            $("input[type='select']").val(-1);
            $("select").val(-1);
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div id="alertBox" data-alerts="alerts"  data-fade="3000"></div>



        <div class="row-fluid">
            <div class="span6">
                <form class="navbar-form pull-left" id="modifierMasterForm" action="modifierMaster.aspx">

                    <asp:ScriptManager runat="server" ID="ScriptManager1" EnablePageMethods="true" EnablePartialRendering="true">
                            </asp:ScriptManager>  

                    <div id="modifierMaster">
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
                        <td><label>Divisible</label></td>
                        <td><asp:CheckBox ID="divisible" runat="server" /></td>
                    </tr>

                    <tr>
                        <td><label>Comment</label></td>
                        <td><input id="comment1" type="text" placeholder="Comment" class="span2" /></td>
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
                        <asp:ListView ID="lstvModifierMaster" runat="server" >
            <LayoutTemplate >
                <table class="table table-condensed">
                    <tr>
                        <td style="background:#00ffff; font-size:medium">Modifier Master List</td>
                    </tr>
                    <tr>
                        <td><asp:PlaceHolder id="itemPlaceholder" runat="server" /></td>
                    </tr>
                </table>
            </LayoutTemplate>

            <ItemTemplate>
                <tr onmouseup="updateRow(<%#Eval("modifierID") %>, '<%#Eval("reference") %>', '<%#Eval("description") %>', '<%#Eval("divisible") %>', '<%#Eval("comment") %>')">
                    <td>
                        <asp:Label ID="lblModifierID" runat="Server" Text='<%#Eval("modifierID") %>' />
                    </td>

                    <td>
                        <asp:Label ID="lblReference" runat="Server" Text='<%#Eval("reference") %>' />
                    </td>

                    <td class="btn btn-danger btn-mini"  onmouseup="deleteRow(<%#Eval("modifierID") %>)" style="cursor:pointer">Delete</td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
                    </asp:Panel>

                </ContentTemplate>
            </asp:UpdatePanel>

            </div>
        </div>
                    
        
                
                 
        
       
                


        
       
        

        
</asp:Content>
