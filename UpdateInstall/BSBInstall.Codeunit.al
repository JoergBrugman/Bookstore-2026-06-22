namespace GetUse.Academy.Bookstore.UpdateInstall;

codeunit 50113 "BSB Install"
{
    Subtype = Install;

    var
        BSBInternalLog: Record "BSB Internal Log";

    trigger OnInstallAppPerCompany()
    begin
        BSBInternalLog.InsertNewLog('OnInstallAppPerCompany');
        //Code for company related operations

    end;

    trigger OnInstallAppPerDatabase()
    begin
        BSBInternalLog.InsertNewLog('OnInstallAppPerDatabase');
        // Code for database related operations
    end;
}