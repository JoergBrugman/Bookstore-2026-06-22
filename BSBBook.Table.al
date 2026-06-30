namespace GetUse.Academy.Bookstore;

/// <summary>
/// Table to store Books
/// </summary>
table 50100 "BSB Book"
{
    Caption = 'Book';
    DataClassification = ToBeClassified;
    DataCaptionFields = "No.", Description;
    LookupPageId = "BSB Book List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            ToolTip = 'Specifies the value of the No. field.', Comment = '%';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the value of the Description field.', Comment = '%';
            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                    "Search Description" := CopyStr(Description, 1, MaxStrLen("Search Description"));
            end;
        }
        field(3; "Search Description"; Code[100])
        {
            Caption = 'Search Description';
            ToolTip = 'Specifies the value of the Search Description field.', Comment = '%';
            //[x] Standard-Impl. Search Description machen
        }
        field(4; Blocked; Boolean)
        {
            Caption = 'Blocked';
            ToolTip = 'Specifies the value of the Blocked field.', Comment = '%';
        }
        field(5; Type; Enum "BSB Book Type")
        {
            Caption = 'Type';
            // OptionMembers = " ",Hardcover,Paperback;
            // OptionCaption = ' ,Hardcover,Paperback';
            ToolTip = 'Specifies the value of the Type field.', Comment = '%';
        }
        field(7; Created; Date)
        {
            Caption = 'Created';
            Editable = false;
            ToolTip = 'Specifies the value of the Created field.', Comment = '%';
        }
        field(8; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            ToolTip = 'Specifies the value of the Last Date Modified field.', Comment = '%';
        }
        field(10; Author; Text[50])
        {
            Caption = 'Author';
            ToolTip = 'Specifies the value of the Author field.', Comment = '%';
        }
        field(11; "Author Provision %"; Decimal)
        {
            Caption = 'Author Provision %';
            DecimalPlaces = 0 : 2;
            MinValue = 0;
            MaxValue = 100;
            ToolTip = 'Specifies the value of the Author Provision % field.', Comment = '%';
        }
        field(15; ISBN; Code[20])
        {
            Caption = 'ISBN';
            ToolTip = 'Specifies the value of the ISBN field.', Comment = '%';
        }
        field(16; "No. of Pages"; Integer)
        {
            Caption = 'No. of Pages';
            MinValue = 0;
            ToolTip = 'Specifies the value of the No. of Pages field.', Comment = '%';
        }
        field(17; "Edition No."; Integer)
        {
            Caption = 'Edition No.';
            MinValue = 0;
            ToolTip = 'Specifies the value of the Edition No. field.', Comment = '%';
        }
        field(18; "Date of Publishing"; Date)
        {
            Caption = 'Date of Publishing';
            ToolTip = 'Specifies the value of the Date of Publishing field.', Comment = '%';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, Author, "No. of Pages") { }
    }

    var
        BookBlockedErr: Label '%1 %2 should not be selected because it''s blocked.', Comment = 'de-DE=%1 %2 darf nicht ausgewählt werde, da es gesperrt ist.';
        OnDeleteBookErr: Label 'A %1 cannot be deleted', Comment = 'de-DE=Ein %1 kann nicht gelöscht werden';

    trigger OnDelete()
    var
        IsHandled: Boolean;
    begin
        OnBeforeOnDelete(Rec, IsHandled);
        if IsHandled then
            exit;

        Error(OnDeleteBookErr, TableCaption);
    end;

    trigger OnInsert()
    begin
        Created := Today();
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today();
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today();
    end;


    /// <summary>
    /// Test if a book is blocked on base of Rec.
    /// </summary>
    procedure TestBlocked()
    begin
        TestBlocked(Rec);
    end;

    /// <summary>
    /// Test if a book is blocked on base of the parameter given Book No.
    /// </summary>
    /// <param name="BookNo">Code[20].</param>
    procedure TestBlocked(BookNo: Code[20])
    var
        BSBBook: Record "BSB Book";
    begin
        if BSBBook.Get(BookNo) then
            TestBlocked(BSBBook);
    end;

    local procedure TestBlocked(BSBBook: Record "BSB Book")
    begin
        if not BSBBook.Blocked then
            exit;
        error(BookBlockedErr, BSBBook.TableCaption, BSBBook."No.");
    end;

    procedure ShowCard()
    begin
        if Rec."No." = '' then
            exit;
        ShowCard(Rec);
    end;

    procedure ShowCard(BookNo: Code[20])
    var
        BSBBook: Record "BSB Book";
    begin
        if not BSBBook.Get(BookNo) then
            exit;
        ShowCard(BSBBook);
    end;

    local procedure ShowCard(BSBBook: Record "BSB Book")
    begin
        Page.RunModal(Page::"BSB Book Card", BSBBook);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDelete(var Rec: Record "BSB Book"; var IsHandled: Boolean)
    begin
    end;

}
