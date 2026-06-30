namespace GetUse.Academy.Bookstore.Interfaces;

codeunit 50103 "BSB Book Type Hardcover Impl." implements "BSB Book Type Process"
{
    procedure StartDeployBook()
    begin
        Message('Aus Lager entnommen');
    end;

    procedure StartDeliverBook()
    begin
        Message('Mit UPS PREMIUM versendet');
    end;
}