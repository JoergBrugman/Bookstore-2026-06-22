namespace GetUse.Academy.Bookstore.Http;

using Microsoft.Finance.Currency;

pageextension 50140 "BSB Currencies" extends Currencies
{
    actions
    {
        addafter("Exch. &Rates")
        {
            action("BSB Get Exchange Rate")
            {
                Caption = 'Get Exchange Rate';
                Image = Web;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Get Exchange Rate action';

                trigger OnAction()
                var
                    GetExchangeRate: Codeunit "BSB Get Exchange Rate";
                begin
                    GetExchangeRate.GetExchangeRate(Rec);
                end;
            }
        }
    }
}