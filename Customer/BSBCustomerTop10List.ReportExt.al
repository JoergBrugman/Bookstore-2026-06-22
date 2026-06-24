namespace GetUse.Academy.Bookstore.Customer;
using Microsoft.Sales.Reports;

reportextension 50100 "BSB Customer - Top 10 List" extends "Customer - Top 10 List"
{
    RDLCLayout = 'Customer/BSBCustomerTop10List.rdlc';
    dataset
    {
        add(Integer)
        {
            column(BSBCountryRegionCode_Customer; Customer."Country/Region Code") { IncludeCaption = true; }
        }

        modify(Customer)
        {
            RequestFilterFields = "Country/Region Code";
        }
    }
}