namespace GetUse.Academy.Bookstore.Customer;
using Microsoft.Sales.Customer;

pagecustomization "BSB Customer Card" customizes "Customer Card"
{
    layout
    {
        modify("Location Code") { Visible = false; }
    }
}