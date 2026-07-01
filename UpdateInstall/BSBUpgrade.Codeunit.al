namespace GetUse.Academy.Bookstore.UpdateInstall;

codeunit 50114 "BSB Upgrade"
{
    Subtype = Upgrade;

    var
        BSBInternalLog: Record "BSB Internal Log";

    trigger OnCheckPreconditionsPerCompany()
    begin
        BSBInternalLog.InsertNewLog('OnCheckPreconditionsPerCompany');
    end;

    trigger OnUpgradePerCompany()
    begin
        BSBInternalLog.InsertNewLog('OnUpgradePerCompany');
    end;

    trigger OnValidateUpgradePerCompany()
    begin
        BSBInternalLog.InsertNewLog('OnValidateUpgradePerCompany');
    end;

    trigger OnCheckPreconditionsPerDatabase()
    begin
        BSBInternalLog.InsertNewLog('OnCheckPreconditionsPerDatabase');
    end;

    trigger OnUpgradePerDatabase()
    begin
        BSBInternalLog.InsertNewLog('OnUpgradePerDatabase');
    end;

    trigger OnValidateUpgradePerDatabase()
    begin
        BSBInternalLog.InsertNewLog('OnValidateUpgradePerDatabase');
    end;


}