namespace GetUse.Academy.Bookstore.InterfaceList;
using Microsoft.Sales.Customer;

codeunit 50107 "BSB Check Cust. Foreign Bill" implements "BSB Check Step"
{
    procedure Execute(RecRef: RecordRef): Text
    var
        Customer: Record Customer;
    begin
        if RecRef.Number <> Database::Customer then
            exit;
        RecRef.SetTable(Customer);

        if Customer."Bill-to Customer No." <> '' then
            exit(StrSubstNo('%1: Foreign Customer must not have %2',
                this.GetSequence(),
                Customer.FieldCaption("Bill-to Customer No.")));
    end;

    procedure GetSequence(): Integer
    begin
        exit(200);
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