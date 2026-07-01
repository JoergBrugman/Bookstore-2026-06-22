namespace GetUse.Academy.Bookstore.Json;

table 50101 "BSB AL Issue"
{
    Caption = 'AL Issue';

    fields
    {
        field(1; Id; Integer) { Caption = 'ID'; }
        field(2; Number; Integer)
        {
            Caption = 'Number';
            ToolTip = 'Specifies the value of the Number field';
        }
        field(3; Title; text[250])
        {
            Caption = 'Title';
            ToolTip = 'Specifies the value of the Title field';
        }
        field(5; "Created at"; DateTime)
        {
            Caption = 'Created at';
            ToolTip = 'Specifies the value of the Created at field';
        }
        field(6; User; text[50])
        {
            Caption = 'User';
            ToolTip = 'Specifies the value of the User field';
        }
        field(7; State; text[30])
        {
            Caption = 'State';
            ToolTip = 'Specifies the value of the State field';
        }
        field(8; Website; text[250])
        {
            Caption = 'Website';
            ExtendedDatatype = URL;
            ToolTip = 'Specifies the value of the Website field';
        }
    }

    keys
    {
        key(PK; id)
        {
            Clustered = true;
        }
    }

    procedure RefreshIssues()
    var
        RefreshALIssues: Codeunit "BSB AL Issue Mgt.";
    begin
        RefreshALIssues.Refresh();
    end;

}