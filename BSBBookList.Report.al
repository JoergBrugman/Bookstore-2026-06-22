namespace GetUse.Academy.Bookstore;
using System.Utilities;

report 50100 "BSB Book List"
{
    Caption = 'Book - List';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'BSBBookList.rdlc';

    dataset
    {
        dataitem(SingleRowData; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));
            column(COMPANYNAME; CompanyProperty.DisplayName()) { }
            column(ShowNoOfPages; ShowNoOfPages) { }
        }
        dataitem("BSB Book"; "BSB Book")
        {
            RequestFilterFields = "No.", Author;

            column(No_BSBBook; "No.") { IncludeCaption = true; }
            column(Description_BSBBook; Description) { IncludeCaption = true; }
            column(Author_BSBBook; Author) { IncludeCaption = true; }
            column(NoofPages_BSBBook; "No. of Pages") { IncludeCaption = true; }
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options', Comment = 'de-DE=Optionen';
                    field(ShowNoOfPages; ShowNoOfPages)
                    {
                        Caption = 'Show No. of Pages';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Shoe No. of Pages field.';
                    }
                }
            }
        }
    }

    var
        ShowNoOfPages: Boolean;
}