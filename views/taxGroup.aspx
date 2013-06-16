<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="taxGroup.aspx.cs" Inherits="POS.views.taxGroup" MasterPageFile="~/views/masterPage.Master" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <script type="text/javascript">

        var IU = 'I';
        var ID = -1;
        var isDelete = false;

        $(document).ready(function () {

            $(".navbar .navbar-inner .nav li").removeClass("active");
            $(".navbar .navbar-inner li#taxGroup").addClass("active");

            // positioning alertBox
            $("#alertBox").css("top", $(window).outerHeight() / 2);
            $("#alertBox").css("left", $(window).outerWidth() / 2);




            $("#btnCancel").click(function () {
                clearAllElements();
                return false;
            });



            $("#submit").click(function () {

                var inclusiveVAL = '0';
                if ($("#<%=inclusive.ClientID %>").prop("checked")) inclusiveVAL = '1';

                var isPerAmountVAL = '0';
                if ($("#<%=isPerAmount.ClientID %>").prop("checked")) isPerAmountVAL = '1';

                var isExemptVAL = '0';
                if ($("#<%=isExempt.ClientID %>").prop("checked")) isExemptVAL = '1';

                var afterDiscountVAL = '0';
                if ($("#<%=afterDiscount.ClientID %>").prop("checked")) afterDiscountVAL = '1';

                var afterLineVAL = '0';
                if ($("#<%=afterLine.ClientID %>").prop("checked")) afterLineVAL = '1';


                if (window.IU == 'I') {


                    $.post("../Ajax/taxGroup.aspx",
                        {
                            country: $("#<%=country.ClientID %> option:selected").text(),
                            state: $("#<%=state.ClientID %> option:selected").text(),
                            city: $("#<%=city.ClientID %> option:selected").text(),
                            reference: $("#reference").val(),
                            description: $("#description").val(),
                            category: $("#category").val(),
                            comment: $("#comment1").val(),
                            serviceTypeID: $("#<%=serviceType.ClientID %>").val(),
                            inclusive: inclusiveVAL,
                            line: $("#line1").val(),
                            taxTypeID: $("#<%=taxType.ClientID %>").val(),
                            isPerAmount: isPerAmountVAL,
                            amount: $("#amount").val(),
                            percentage: $("#percentage").val(),
                            isExempt: isExemptVAL,
                            afterDiscount: afterDiscountVAL,
                            afterLine: afterLineVAL,

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


                    $.post("../Ajax/taxGroup.aspx",
                        {
                            taxGroupID: window.ID,
                            country: $("#<%=country.ClientID %> option:selected").text(),
                            state: $("#<%=state.ClientID %> option:selected").text(),
                            city: $("#<%=city.ClientID %> option:selected").text(),
                            reference: $("#reference").val(),
                            description: $("#description").val(),
                            category: $("#category").val(),
                            comment: $("#comment1").val(),
                            serviceTypeID: $("#<%=serviceType.ClientID %>").val(),
                            inclusive: inclusiveVAL,
                            line: $("#line1").val(),
                            taxTypeID: $("#<%=taxType.ClientID %>").val(),
                            isPerAmount: isPerAmountVAL,
                            amount: $("#amount").val(),
                            percentage: $("#percentage").val(),
                            isExempt: isExemptVAL,
                            afterDiscount: afterDiscountVAL,
                            afterLine: afterLineVAL,

                            modifyUser: '-1',
                            StatementType: 'Update'
                        },

                        function (response) {
                            window.IU = 'I';

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


        function updateRow(id, country, state, city, reference, description, category, comment, serviceTypeID, inclusive, line, taxTypeID, isPerAmount, amount, percentage, isExempt, afterDiscount, afterLine) {
            if (!window.isDelete) {
                window.IU = 'U';
                window.ID = id;


                $("#<%=country.ClientID %>").val(country);
                $("#<%=state.ClientID %>").val(state);
                $("#<%=city.ClientID %>").val(city);
                $("#reference").val(reference);
                $("#description").val(description);
                $("#category").val(category);
                $("#comment1").val(comment);
                $("#<%=serviceType.ClientID %>").val(serviceTypeID);
                if (inclusive == 1 || inclusive == '1') { $("#<%=inclusive.ClientID %>").prop("checked", true) } else { $("#<%=inclusive.ClientID %>").prop("checked", false) }
                $("#line1").val(line);
                $("#<%=taxType.ClientID %>").val(taxTypeID);
                if (isPerAmount == 1 || isPerAmount == '1') { $("#<%=isPerAmount.ClientID %>").prop("checked", true) } else { $("#<%=isPerAmount.ClientID %>").prop("checked", false) }
                $("#amount").val(amount);
                $("#percentage").val(percentage);
                if (isExempt == 1 || isExempt == '1') { $("#<%=isExempt.ClientID %>").prop("checked", true) } else { $("#<%=isExempt.ClientID %>").prop("checked", false) }
                if (afterDiscount == 1 || afterDiscount == '1') { $("#<%=afterDiscount.ClientID %>").prop("checked", true) } else { $("#<%=afterDiscount.ClientID %>").prop("checked", false) }
                if (afterLine == 1 || afterLine == '1') { $("#<%=afterLine.ClientID %>").prop("checked", true) } else { $("#<%=afterLine.ClientID %>").prop("checked", false) }
            }
        }


        function deleteRow(id) {
            window.isDelete = true;

            if (confirm('Sure To Delete?')) {
                $.post("../Ajax/taxGroup.aspx",
                    {
                        taxGroupID: id,
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

            $("input[type=text]").val(null);
            $("input[type=checkbox]").prop("checked", false);
            $("input[type=select]").val(-1);
            $("select").val(-1);
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div id="alertBox" data-alerts="alerts"  data-fade="3000"></div>



        <div class="row-fluid">
            <div class="span6">
                <form class="navbar-form pull-left" id="taxGroupForm" action="taxGroup.aspx">

                    <asp:ScriptManager runat="server" ID="ScriptManager1" EnablePageMethods="true" EnablePartialRendering="true">
                            </asp:ScriptManager>  

                    <div id="taxGroup">
                <table>
                    <tr>
                        <td><label>Country</label></td>
                        <td><asp:DropDownList ID="country" runat="server" 
                                onselectedindexchanged="country_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList></td>
                    </tr>

                    <tr>
                        <td><label>State</label></td>
                        <td><asp:DropDownList ID="state" runat="server"></asp:DropDownList></td>
                    </tr>

                    <tr style="display:none">
                        <td><label>City</label></td>
                        <td><asp:DropDownList ID="city" runat="server"></asp:DropDownList></td>
                    </tr>

                    <tr>
                        <td><label>Reference</label></td>
                        <td><asp:TextBox AutoPostBack="false" runat="server" id="reference"  placeholder="Reference" class="span2" ></asp:TextBox></td>
                    </tr>

                    <tr>
                        <td><label>Description</label></td>
                        <td><asp:TextBox AutoPostBack="false" runat="server" id="description" type="text" placeholder="Description" class="span2" ></asp:TextBox></td>
                    </tr>

                    <tr>
                        <td><label>Category</label></td>
                        <td><asp:TextBox AutoPostBack="false" runat="server" id="category" type="text" placeholder="Category" class="span2" ></asp:TextBox></td>
                    </tr>

                    <tr>
                        <td><label>Comment</label></td>
                        <td><asp:TextBox AutoPostBack="false" runat="server" id="comment1" type="text" placeholder="Comment" class="span2" ></asp:TextBox></td>
                    </tr>

                    <tr>
                        <td><label>Service Type</label></td>
                        <td><asp:DropDownList ID="serviceType" runat="server"></asp:DropDownList></td>
                    </tr>

                    <tr>
                        <td><label>Inclusive</label></td>
                        <td><asp:CheckBox ID="inclusive" runat="server" /></td>
                    </tr>

                    <tr>
                        <td><label>Line</label></td>
                        <td><asp:TextBox AutoPostBack="false" runat="server" id="line1" type="text" placeholder="Line" class="span2" ></asp:TextBox></td>
                    </tr>

                    <tr>
                        <td><label>Tax Type</label></td>
                        <td><asp:DropDownList ID="taxType" runat="server"></asp:DropDownList></td>
                    </tr>

                    <tr>
                        <td><label>Is Per Amount</label></td>
                        <td><asp:CheckBox ID="isPerAmount" runat="server" /></td>
                    </tr>

                    <tr>
                        <td><label>Amount</label></td>
                        <td><asp:TextBox AutoPostBack="false" runat="server" id="amount" type="text" placeholder="Amount" class="span2" ></asp:TextBox></td>
                    </tr>

                    <tr>
                        <td><label>Percentage</label></td>
                        <td><asp:TextBox AutoPostBack="false" runat="server" id="percentage" type="text" placeholder="Percentage" class="span2" ></asp:TextBox></td>
                    </tr>

                    <tr>
                        <td><label>Is Exempt</label></td>
                        <td><asp:CheckBox ID="isExempt" runat="server" /></td>
                    </tr>

                    <tr>
                        <td><label>After Discount</label></td>
                        <td><asp:CheckBox ID="afterDiscount" runat="server" /></td>
                    </tr>

                    <tr>
                        <td><label>After Line</label></td>
                        <td><asp:CheckBox ID="afterLine" runat="server" /></td>
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
                        <asp:ListView ID="lstvTaxGroup" runat="server" >
            <LayoutTemplate >
                <table class="table table-condensed">
                    <tr>
                        <td style="background:#00ffff; font-size:medium">Tax Group List</td>
                    </tr>
                    <tr>
                        <td><asp:PlaceHolder id="itemPlaceholder" runat="server" /></td>
                    </tr>
                </table>
            </LayoutTemplate>

            <ItemTemplate>
                <tr onmouseup="updateRow(<%#Eval("taxGroupID") %>, '<%#Eval("country") %>', '<%#Eval("state") %>', '<%#Eval("city") %>', '<%#Eval("reference") %>', '<%#Eval("description ") %>', '<%#Eval("category") %>', '<%#Eval("comment") %>', <%#Eval("serviceTypeID") %>, '<%#Eval("inclusive") %>', '<%#Eval("line") %>', <%#Eval("taxTypeID") %>, '<%#Eval("isPerAmount") %>', <%#Eval("amount") %>, <%#Eval("percentage") %>, '<%#Eval("isExempt") %>', '<%#Eval("afterDiscount") %>', '<%#Eval("afterLine") %>')">
                    <td>
                        <asp:Label ID="lblTaxGroupID" runat="Server" Text='<%#Eval("taxGroupID") %>' />
                    </td>

                    <td>
                        <asp:Label ID="lblReference" runat="Server" Text='<%#Eval("reference") %>' />
                    </td>

                    <td class="btn btn-danger btn-mini"  onmouseup="deleteRow(<%#Eval("taxGroupID") %>)" style="cursor:pointer">Delete</td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
                    </asp:Panel>

                </ContentTemplate>
            </asp:UpdatePanel>

            </div>
        </div>
        
</asp:Content>
