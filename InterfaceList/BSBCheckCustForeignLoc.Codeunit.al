namespace GetUse.Academy.Bookstore.InterfaceList;
using Microsoft.Sales.Customer;

codeunit 50108 "BSB Check Cust. Foreign Loc." implements "BSB Check Step"
{
    procedure Execute(RecRef: RecordRef): Text
    var
        Customer: Record Customer;
    begin
        if RecRef.Number <> Database::Customer then
            exit;
        RecRef.SetTable(Customer);

        if Customer."Location Code" <> 'GELB' then
            exit(StrSubstNo('%1: Foreign Customer should have Location GELB and not %2',
                this.GetSequence(),
                Customer."Location Code"));
    end;

    procedure GetSequence(): Integer
    begin
        exit(50);
    end;

    procedure IsEnabled(RecRef: RecordRef): Boolean
    var
        Customer: Record Customer;
    begin
        if RecRef.Number <> Database::Customer then
            exit;
        RecRef.SetTable(Customer);
        exit(Customer."Country/Region Code" <> '')
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BSB Check Pipeline", OnRegisterCheckSteps, '', false, false)]
    local procedure "BSB Check Pipeline_OnRegisterCheckSteps"(var Steps: List of [Interface "BSB Check Step"]; RecRef: RecordRef)
    begin
        if RecRef.Number = Database::Customer then
            Steps.Add(this);
    end;
}