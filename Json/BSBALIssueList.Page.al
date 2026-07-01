namespace GetUse.Academy.Bookstore.Json;

page 50105 "BSB AL Issue List"
{
    PageType = List;
    SourceTable = "BSB AL Issue";
    Caption = 'AL Issues';
    Editable = false;
    SourceTableView = order(descending);
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Number; Rec.Number) { }
                field(Title; Rec.Title) { }
                field(CreatedAt; Rec."Created at") { }
                field(User; Rec.User) { }
                field(State; Rec.State) { }
                field(Website; Rec.Website) { }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(RefreshALIssueList)
            {
                Caption = 'Refresh Issues';
                Promoted = true;
                PromotedCategory = Process;
                Image = RefreshLines;
                ApplicationArea = All;
                ToolTip = 'Executes the Refresh Issues action';

                trigger OnAction();
                begin
                    Rec.RefreshIssues();
                    CurrPage.Update();
                    if Rec.FindFirst() then;
                end;
            }
        }
    }

}