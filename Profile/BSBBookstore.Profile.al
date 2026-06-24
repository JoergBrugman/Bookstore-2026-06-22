namespace GetUse.Academy.Bookstore.Profiles;

using GetUse.Academy.Bookstore.Customer;
using Microsoft.Sales.RoleCenters;

profile "BSB Bookstore"
{
    Caption = 'Profile for Bookstore usage';
    RoleCenter = "Order Processor Role Center";
    Customizations = "BSB Customer Card", "BSB Customer List";
}