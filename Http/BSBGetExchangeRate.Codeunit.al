namespace GetUse.Academy.Bookstore.Http;

using Microsoft.Finance.Currency;
using Microsoft.Finance.GeneralLedger.Setup;

codeunit 50111 "BSB Get Exchange Rate"
{
    procedure GetExchangeRate(Currency: Record Currency)
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        ResponseText: Text;
        Url: Text;
    begin
        GeneralLedgerSetup.Get();

        Url := StrSubstNo(
            'http://data.fixer.io/api/latest?access_key=f9b23a52bde207ec2e65de875534b094&base=%1&symbols=%2',
            GeneralLedgerSetup.GetCurrencyCode(''),
            Currency.Code);

        if HttpClient.Get(Url, HttpResponseMessage) then begin
            HttpResponseMessage.Content().ReadAs(ResponseText);
            Message(ResponseText);
        end;
    end;
}