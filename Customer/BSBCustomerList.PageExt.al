namespace GetUse.Academy.Bookstore.Customer;
using Microsoft.Sales.Customer;
using GetUse.Academy.Bookstore.InterfaceList;

pageextension 50103 "BSB Customer List" extends "Customer List"
{
    actions
    {
        addlast(processing)
        {
            action("BSB CustomerCheckPipeline")
            {
                Caption = 'Customer Check Pipeline';
                ApplicationArea = All;
                Image = Process;
                ToolTip = 'Executes the Customer Check Pipeline action.';

                trigger OnAction()
                var
                    BSBCheckPipeline: Codeunit "BSB Check Pipeline";
                begin
                    BSBCheckPipeline.ProcessPipeline(Rec);
                end;
            }
        }
    }
}