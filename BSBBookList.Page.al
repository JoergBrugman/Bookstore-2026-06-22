namespace GetUse.Academy.Bookstore;
using GetUse.Academy.Bookstore.Interfaces;

page 50101 "BSB Book List"
{
    Caption = 'Books';
    PageType = List;
    SourceTable = "BSB Book";
    Editable = false;
    CardPageId = "BSB Book Card";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Books)
            {

                field("No."; Rec."No.") { }
                field(Description; Rec.Description) { }
                field(ISBN; Rec.ISBN) { }
                field(Author; Rec.Author) { }
                field("No. of Pages"; Rec."No. of Pages") { Visible = false; }
            }

        }
        area(FactBoxes)
        {
            systempart(Links; Links) { ApplicationArea = RecordLinks; }
            systempart(Notes; Notes) { ApplicationArea = Notes; }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SimpleSalesProcess)
            {
                Caption = 'Simple Sales Process';
                Image = Process;
                ToolTip = 'Executes the Simple Sales Process action.';

                trigger OnAction()
                var
                    BSBBookTypeSimpleProcess: Codeunit "BSB Book Type Simple Process";
                    IsHandled: Boolean;
                begin
                    OnBeforeBookTypeSimpleProcess(Rec, IsHandled);
                    if IsHandled then
                        exit;
                    BSBBookTypeSimpleProcess.StartDeployBook();
                    BSBBookTypeSimpleProcess.StartDeliverBook();
                end;
            }
            action(SalesProcessWithInterface)
            {
                Caption = 'Sales with Interface';
                Image = Process;
                ToolTip = 'Executes the Sales with Interface action.';

                trigger OnAction()
                var
                    BookTypeProcess: Interface "BSB Book Type Process";
                    BSBBookTypeDefaultImpl: Codeunit "BSB Book Type Default Impl.";
                    BSBBookTypeHardcoverImpl: Codeunit "BSB Book Type Hardcover Impl.";
                    BSBBookTypePaperbackImpl: Codeunit "BSB Book Type Paperback Impl.";
                begin
                    case Rec.Type of
                        "BSB Book Type"::Hardcover:
                            BookTypeProcess := BSBBookTypeHardcoverImpl;
                        "BSB Book Type"::Paperback:
                            BookTypeProcess := BSBBookTypePaperbackImpl;
                        else
                            BookTypeProcess := BSBBookTypeDefaultImpl;
                    end;
                    BookTypeProcess.StartDeployBook();
                    BookTypeProcess.StartDeliverBook();
                end;
            }
            action(SalesProcessWithInterfaceAndEnum)
            {
                Caption = 'Sales with Interface+Enum';
                Image = Process;
                ToolTip = 'Executes the Sales with Interface+Enum action.';

                trigger OnAction()
                var
                    BookTypeProcess: Interface "BSB Book Type Process";
                begin
                    BookTypeProcess := Rec.Type;
                    BookTypeProcess.StartDeployBook();
                    BookTypeProcess.StartDeliverBook();
                end;
            }
            action(SalesProcessWithInterfaceAndEnumExt)
            {
                Caption = 'Sales with Interface+EnumExt';
                Image = Process;
                ToolTip = 'Executes the Sales with Interface+EnumExt action.';

                trigger OnAction()
                var
                    BookTypeProcess: Interface "BSB Book Type Process";
                begin
                    BookTypeProcess := Rec.Type;
                    BookTypeProcess.StartDeployBook();
                    if BookTypeProcess is "BSB Book Type Process V2" then
                        (BookTypeProcess as "BSB Book Type Process V2").DoQualityCheck();
                    BookTypeProcess.StartDeliverBook();
                end;
            }
        }
    }


    [IntegrationEvent(false, false)]
    local procedure OnBeforeBookTypeSimpleProcess(var Rec: Record "BSB Book"; var IsHandled: Boolean)
    begin
    end;
}