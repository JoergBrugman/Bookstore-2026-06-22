namespace GetUse.Academy.Bookstore.ExternalFileStorage;
using System.ExternalFileStorage;
using System.IO;

page 50106 "BSB WN26 External File Storage"
{
    Caption = 'WN26 External File Storage';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    actions
    {
        area(Processing)
        {
            action(ExportToFileStorage)
            {
                Caption = 'Export to File Storage';
                Image = Export;
                ToolTip = 'Executes the Export to File Storage action.';

                trigger OnAction()
                var
                    ExternalFileStorage: Codeunit "External File Storage";
                    FileManagement: Codeunit "File Management";
                    FileName, NameOnly, Extension, FilePath : Text;
                    InStr: InStream;
                begin
                    if not UploadIntoStream('Select File', '', 'All Files (*.*)|*.*', FileName, InStr) then
                        exit;

                    NameOnly := FileManagement.GetFileNameWithoutExtension(FileName);
                    Extension := FileManagement.GetExtension(FileName);
                    ExternalFileStorage.Initialize("File Scenario"::WhatsNewBC26);
                    FilePath := ExternalFileStorage.SaveFile('.', NameOnly, Extension, 'Save as');
                    // Message(FilePath);
                    ExternalFileStorage.CreateFile(FilePath, InStr);
                end;
            }
        }
        area(Navigation)
        {
            action(AccountBrowser)
            {
                Caption = 'Account Browser';
                Image = Process;
                ToolTip = 'Executes the Account Browser action.';
                trigger OnAction()
                var
                    ExternalFileStorage: Codeunit "External File Storage";
                begin
                    ExternalFileStorage.Initialize("File Scenario"::WhatsNewBC26);
                    ExternalFileStorage.BrowseAccount();
                end;
            }
        }
        area(Promoted)
        {
            actionref(ExportToFileStorage_Promoted; ExportToFileStorage) { }
            actionref(AccountBrowser_Promoted; AccountBrowser) { }
        }

    }
}