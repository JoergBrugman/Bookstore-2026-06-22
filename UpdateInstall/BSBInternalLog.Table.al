namespace GetUse.Academy.Bookstore.UpdateInstall;

table 50102 "BSB Internal Log"
{
    Caption = 'Internal Log';
    DataClassification = ToBeClassified;
    DataPerCompany = false;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; Company; Text[50])
        {
            Caption = 'Company';
            DataClassification = ToBeClassified;
        }
        field(4; Created; DateTime)
        {
            Caption = 'Created';
            DataClassification = ToBeClassified;
        }
        field(5; Comment; Text[500])
        {
            Caption = 'Comment';
            DataClassification = ToBeClassified;
        }
        field(6; Dummy; Text[50])
        {
            Caption = 'Dummy';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    procedure InsertNewLog(TriggerTxt: Text)
    var
        BSBInternalLog: Record "BSB Internal Log";
        ExecContext: ExecutionContext;
        ModuleInfo: ModuleInfo;
    begin
        BSBInternalLog.Init();
        BSBInternalLog.Description := TriggerTxt;
        BSBInternalLog.Created := CurrentDateTime();
        BSBInternalLog.Company := CompanyName();
        ExecContext := Session.GetCurrentModuleExecutionContext();
        BSBInternalLog.Comment := StrSubstNo('%1', ExecContext);
        NavApp.GetCurrentModuleInfo(ModuleInfo);
        BSBInternalLog.Comment += StrSubstNo(' - AppName: %1 - AppVersion:%2 - DataVersion:%3', ModuleInfo.Name, ModuleInfo.AppVersion, ModuleInfo.DataVersion);
        BSBInternalLog.Insert();
    end;


}
