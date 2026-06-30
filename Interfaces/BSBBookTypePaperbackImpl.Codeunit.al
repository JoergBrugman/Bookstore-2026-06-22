namespace GetUse.Academy.Bookstore.Interfaces;

codeunit 50104 "BSB Book Type Paperback Impl." implements "BSB Book Type Process V2"
{
    procedure StartDeployBook()
    begin
        Message('Print on Demand');
    end;

    procedure StartDeliverBook()
    begin
        Message('Mit DBD STANDARD versendet');
    end;

    procedure DoQualityCheck()
    begin
        Message('Qualität ist OK');
    end;
}