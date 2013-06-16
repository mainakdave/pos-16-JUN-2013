<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="itemResturant.aspx.cs" Inherits="POS.views.itemResturant" MasterPageFile="~/views/masterPage.Master" %>


<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <script type="text/javascript">

        var IU = 'I';
        var ID = -1;
        var isDelete = false;

        $(document).ready(function () {

            $(".navbar .navbar-inner .nav li").removeClass("active");
            $(".navbar .navbar-inner li#itemRestaurant").addClass("active");

            $("#itemPages .btn-group .dropdown-toggle").html("Item Restaurant<span class='caret'></span>");

            // positioning alertBox
            $("#alertBox").css("top", $(window).outerHeight() / 2);
            $("#alertBox").css("left", $(window).outerWidth() / 2);


            $("#btnCancel").click(function () {
                clearAllElements();
                return false;
            });



            $("#submit").click(function () {
                var bgColor = $("#colorSelector > div").css("background-color");
                var textColor = $("#colorSelector_text > div").css("background-color");

                if ($("#<%=byPortion.ClientID %>").prop("checked")) { byPortionVAL = '1'; } else { byPortionVAL = '0'; }
                if ($("#<%=visibleSales.ClientID %>").prop("checked")) { visibleSalesVAL = '1'; } else { visibleSalesVAL = '0'; }
                if ($("#<%=isMenu.ClientID %>").prop("checked")) { isMenuVAL = '1'; } else { isMenuVAL = '0'; }
                if ($("#<%=freePrice.ClientID %>").prop("checked")) { freePriceVAL = '1'; } else { freePriceVAL = '0'; }

                
                if (window.IU == 'I') {
                    $.post("../Ajax/itemRestaurant.aspx",
                        {
                            itemID: $("#<%=itemDrplst.ClientID %>").val(),
                            byPortion: byPortionVAL,
                            visibleSales: visibleSalesVAL,
                            orderNo: $("#orderNo").val(),
                            isMenu: isMenuVAL,
                            freePrice: freePriceVAL,
                            freeMin: $("#freeMin").val(),
                            freeMax: $("#freeMax").val(),
                            couponCode: $("#couponCode").val(),
                            shortcut: $("#shortcut").val(),
                            bgColor: bgColor,
                            textColor: textColor,
                            yield: $("#yield").val(),

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


                    $.post("../Ajax/itemRestaurant.aspx",
                        {
                            itemRestID: window.ID,

                            itemID: $("#<%=itemDrplst.ClientID %>").val(),
                            byPortion: byPortionVAL,
                            visibleSales: visibleSalesVAL,
                            orderNo: $("#orderNo").val(),
                            isMenu: isMenuVAL,
                            freePrice: freePriceVAL,
                            freeMin: $("#freeMin").val(),
                            freeMax: $("#freeMax").val(),
                            couponCode: $("#couponCode").val(),
                            shortcut: $("#shortcut").val(),
                            bgColor: bgColor,
                            textColor: textColor,
                            yield: $("#yield").val(),

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


        function updateRow(id, itemID, byPortion, visibleSales, orderNo, isMenu, freePrice, freeMin, freeMax, couponCode, shortcut, bgColor, textColor, yield) {
            if (!window.isDelete) {
                window.IU = 'U';
                window.ID = id;


                $("#<%=itemDrplst.ClientID %>").val(itemID);
                if (byPortion == 1 || byPortion == '1') { $("#<%=byPortion.ClientID %>").prop("checked", true); }
                if (visibleSales == 1 || visibleSales == '1') { $("#<%=visibleSales.ClientID %>").prop("checked", true); }
                $("#orderNo").val(orderNo);
                if (isMenu == 1 || isMenu == '1') { $("#<%=isMenu.ClientID %>").prop("checked", true); }
                if (freePrice == 1 || freePrice == '1') { $("#<%=freePrice.ClientID %>").prop("checked", true); }
                $("#freeMin").val(freeMin);
                $("#freeMax").val(freeMax);
                $("#couponCode").val(couponCode);
                $("#shortcut").val(shortcut);
                $("#colorSelector > div").css("background-color", bgColor);
                $("#colorSelector_text > div").css("background-color", textColor);
                $("#yield").val(yield);
            }
        }


        function deleteRow(id) {
            window.isDelete = true;

            if (confirm('Sure To Delete?')) {
                $.post("../Ajax/itemRestaurant.aspx",
                    {
                        itemRestID: id,
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
            $("#colorSelector > div").css("background-color", "transparent");
            $("#colorSelector_text > div").css("background-color", "transparent");

        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div id="alertBox" data-alerts="alerts"  data-fade="3000"></div>



        <div class="row-fluid">
            <div class="span6">
                <form class="navbar-form pull-left" id="itemRestaurantForm" action="itemResturant.aspx">

                    <asp:ScriptManager runat="server" ID="ScriptManager1" EnablePageMethods="true" EnablePartialRendering="true">
                            </asp:ScriptManager>  

                    <div id="itemRestaurant">
                <table>
                    <tr>
                        <td><label>Item Name</label></td>
                        <td><asp:DropDownList ID="itemDrplst" runat="server"></asp:DropDownList></td>
                    </tr>

                    <tr>
                        <td><label>By Portion</label></td>
                        <td><asp:CheckBox ID="byPortion" runat="server" /></td>
                    </tr>

                    <tr>
                        <td><label>Visible Sales</label></td>
                        <td><asp:CheckBox ID="visibleSales" runat="server" /></td>
                    </tr>

                    <tr>
                        <td><label>Order No</label></td>
                        <td><input id="orderNo" type="text" placeholder="Order No" class="span2" /></td>
                    </tr>

                    <tr>
                        <td><label>Is Menu</label></td>
                        <td><asp:CheckBox ID="isMenu" runat="server" /></td>
                    </tr>

                    <tr>
                        <td><label>Free Price</label></td>
                        <td><asp:CheckBox ID="freePrice" runat="server" /></td>
                    </tr>

                    <tr>
                        <td><label>Free Max</label></td>
                        <td><input id="freeMax" type="text" placeholder="Free Max" class="span2" /></td>
                    </tr>

                    <tr>
                        <td><label>Free Min</label></td>
                        <td><input id="freeMin" type="text" placeholder="Free Min" class="span2" /></td>
                    </tr>

                    <tr>
                        <td><label>Coupon Code</label></td>
                        <td><input id="couponCode" type="text" placeholder="Coupon Code" class="span2" /></td>
                    </tr>

                    <tr>
                        <td><label>Shortcut</label></td>
                        <td><input id="shortcut" type="text" placeholder="Shortcut" class="span2" /></td>
                    </tr>

                    <tr>
                        <td><label>Background Color</label></td>
                        <td><div id="colorSelector"><div></div></div></td>
                    </tr>

                    <tr>
                        <td><label>Text Color</label></td>
                        <td><div id="colorSelector_text"><div></div></div></td>
                    </tr>

                    <tr>
                        <td><label>Yield</label></td>
                        <td><input id="yield" type="text" placeholder="Yield" class="span2" /></td>
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
                        <asp:ListView ID="lstvItemRestaurant" runat="server" >
            <LayoutTemplate >
                <table class="table table-condensed">
                    <tr>
                        <td style="background:#00ffff; font-size:medium">Item Restaurant List</td>
                    </tr>
                    <tr>
                        <td><asp:PlaceHolder id="itemPlaceholder" runat="server" /></td>
                    </tr>
                </table>
            </LayoutTemplate>

            <ItemTemplate>
                <tr onmouseup="updateRow(<%#Eval("itemRestID") %>, <%#Eval("itemID") %>, '<%#Eval("byPortion") %>', '<%#Eval("visibleSales") %>', <%#Eval("orderNo") %>, '<%#Eval("isMenu") %>', '<%#Eval("freePrice") %>', <%#Eval("freeMin") %>, <%#Eval("freeMax") %>, <%#Eval("couponCode") %>, '<%#Eval("shortcut") %>', '<%#Eval("bgColor") %>', '<%#Eval("textColor") %>', <%#Eval("yield") %>)">
                    <td>
                        <asp:Label ID="lblItemRestID" runat="Server" Text='<%#Eval("itemRestID") %>' />
                    </td>

                    <td>
                        <asp:Label ID="lblItemID" runat="Server" Text='<%#Eval("itemID") %>' />
                    </td>

                    <td class="btn btn-danger btn-mini"  onmouseup="deleteRow(<%#Eval("itemRestID") %>)" style="cursor:pointer">Delete</td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
                    </asp:Panel>

                </ContentTemplate>
            </asp:UpdatePanel>

            </div>
        </div>
                    
        
                
                 
        
       
                


        
       
        

        
</asp:Content>
