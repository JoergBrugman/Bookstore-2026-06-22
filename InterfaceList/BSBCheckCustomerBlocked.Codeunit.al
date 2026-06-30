namespace GetUse.Academy.Bookstore.InterfaceList;
using Microsoft.Sales.Customer;

codeunit 50106 "BSB Check Customer Blocked" implements "BSB Check Step"
{
    procedure Execute(RecRef: RecordRef): Text
    var
        Customer: Record Customer;
    begin
        if RecRef.Number <> Database::Customer then
            exit;
        RecRef.SetTable(Customer);
        // if Customer.IsBlocked() then
        if Customer.Blocked <> "Customer Blocked"::" " then
            exit(StrSubstNo('%1: Customer is blocked in level %2', this.GetSequence(), Customer.Blocked));
    end;

    procedure GetSequence(): Integer
    begin
        exit(100);
    end;

    procedure IsEnabled(RecRef: RecordRef): Boolean
    begin
        exit(RecRef.Number = Database::Customer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BSB Check Pipeline", OnRegisterCheckSteps, '', false, false)]
    local procedure "BSB Check Pipeline_OnRegisterCheckSteps"(var Steps: List of [Interface "BSB Check Step"]; RecRef: RecordRef)
    begin
        if RecRef.Number = Database::Customer then
            Steps.Add(this);
    end;
}