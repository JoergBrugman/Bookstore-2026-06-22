namespace GetUse.Academy.Bookstore.Customer;
using Microsoft.Sales.Customer;

pageextension 50101 "BSB Customer Card" extends "Customer Card"
{
    layout
    {
        addafter(General)
        {
            group("BSB Bookstore")
            {
                Caption = 'Bookstore', Comment = 'de-DE=Buch';

                field("BSB Favorite Book No."; Rec."BSB Favorite Book No.")
                {
                    ApplicationArea = All;
                }
                field("BSB Favorite Book Description"; Rec."BSB Favorite Book Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}