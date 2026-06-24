namespace GetUse.Academy.Bookstore.Customer;
using Microsoft.Sales.Customer;

pagecustomization "BSB Customer List" customizes "Customer List"
{
    layout
    {
        modify("Location Code") { Visible = false; }
    }
}