<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="taxType.aspx.cs" Inherits="POS.views.taxType" MasterPageFile="~/views/masterPage.Master" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <script type="text/javascript">

        var IU = 'I';
        var ID = -1;
        var isDelete = false;

        $(document).ready(function () {

            $(".navbar .navbar-inner .nav li").removeClass("active");
            $(".navbar .navbar-inner li#taxType").addClass("active");

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


                    $.post("../Ajax/taxType.aspx",
                        {
                            description: $("#description").val(),
                            inputTaxAccount: $("#inputTaxAccount").val(),
                            outputTaxAccount: $("#outputTaxAccount").val(),
                            refundTaxAccount: $("#refundTaxAccount").val(),
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


                    $.post("../Ajax/taxType.aspx",
                        {
                            taxTypeID: window.ID,
                            description: $("#description").val(),
                            inputTaxAccount: $("#inputTaxAccount").val(),
                            outputTaxAccount: $("#outputTaxAccount").val(),
                            refundTaxAccount: $("#refundTaxAccount").val(),
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


        function updateRow(id, description, inputTaxAccount, outputTaxAccount, refundTaxAccount) {
            if (!window.isDelete) {
                window.IU = 'U';
                window.ID = id;

                $("#description").val(description);
                $("#inputTaxAccount").val(inputTaxAccount);
                $("#outputTaxAccount").val(outputTaxAccount);
                $("#refundTaxAccount").val(refundTaxAccount);
                
            }
        }


        function deleteRow(id) {
            window.isDelete = true;

            if (confirm('Sure To Delete?')) {
                $.post("../Ajax/taxType.aspx",
                    {
                        taxTypeID: id,
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

            $("input[type=text]").val(null);
            
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div id="alertBox" data-alerts="alerts"  data-fade="3000"></div>



        <div class="row-fluid">
            <div class="span6">
                <form class="navbar-form pull-left" id="brandForm" action="taxType.aspx">

                    <asp:ScriptManager runat="server" ID="ScriptManager1" EnablePageMethods="true" EnablePartialRendering="true">
                            </asp:ScriptManager>  

                    <div id="taxType">
                <table>
                    

                    <tr>
                        <td><label>Description</label></td>
                        <td><input id="description" type="text" placeholder="Description" class="span2" /></td>
                    </tr>

                    <tr>
                        <td><label>Input Tax Account</label></td>
                        <td><input id="inputTaxAccount" type="text" placeholder="Input Tax Account" class="span2" /></td>
                    </tr>

                    <tr>
                        <td><label>Output Tax Account</label></td>
                        <td><input id="outputTaxAccount" type="text" placeholder="Output Tax Account" class="span2" /></td>
                    </tr>

                    <tr>
                        <td><label>Refund Tax Account</label></td>
                        <td><input id="refundTaxAccount" type="text" placeholder="Refund Tax Account" class="span2" /></td>
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
                        <asp:ListView ID="lstvTaxType" runat="server" >
            <LayoutTemplate >
                <table class="table table-condensed">
                    <tr>
                        <td style="background:#00ffff; font-size:medium">Tax Type List</td>
                    </tr>
                    <tr>
                        <td><asp:PlaceHolder id="itemPlaceholder" runat="server" /></td>
                    </tr>
                </table>
            </LayoutTemplate>

            <ItemTemplate>
                <tr onmouseup="updateRow(<%#Eval("taxTypeID") %>, '<%#Eval("description ") %>', '<%#Eval("inputTaxAccount") %>', '<%#Eval("outputTaxAccount") %>',  '<%#Eval("refundTaxAccount") %>')">
                    <td>
                        <asp:Label ID="lblTaxTypeID" runat="Server" Text='<%#Eval("taxTypeID") %>' />
                    </td>

                    <td>
                        <asp:Label ID="lblDescription" runat="Server" Text='<%#Eval("description") %>' />
                    </td>

                    <td class="btn btn-danger btn-mini"  onmouseup="deleteRow(<%#Eval("taxTypeID") %>)" style="cursor:pointer">Delete</td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
                    </asp:Panel>

                </ContentTemplate>
            </asp:UpdatePanel>

            </div>
        </div>
                    
        
</asp:Content>

