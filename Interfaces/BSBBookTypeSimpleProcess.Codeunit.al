namespace GetUse.Academy.Bookstore.Interfaces;

codeunit 50101 "BSB Book Type Simple Process"
{
    procedure StartDeployBook()
    begin
        message('Aus Lager entnehmen');
    end;

    procedure StartDeliverBook()
    begin
        Message('Mit UPS Standard ausliefern');
    end;
}