namespace GetUse.Academy.Bookstore;

page 50100 "BSB Book Card"
{
    Caption = 'Book Card';
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "BSB Book";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    Importance = Promoted;
                }
                field(Description; Rec.Description)
                {
                }
                field("Search Description"; Rec."Search Description")
                {
                    Importance = Additional;
                }
                field(Blocked; Rec.Blocked)
                {
                }
                field(Author; Rec.Author)
                {
                    Importance = Promoted;
                }
                field(Type; Rec."Type")
                {
                }
                field(ISBN; Rec.ISBN)
                {
                    Importance = Additional;
                }
                field(Created; Rec.Created)
                {
                    Importance = Additional;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Importance = Additional;
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';

                field("Author Provision %"; Rec."Author Provision %")
                {
                }
            }
            group(Publishing)
            {
                Caption = 'Publishing';

                field("Edition No."; Rec."Edition No.")
                {
                }
                field("No. of Pages"; Rec."No. of Pages")
                {
                }
                field("Date of Publishing"; Rec."Date of Publishing")
                {
                }
            }

        }
        area(FactBoxes)
        {
            systempart(Links; Links) { ApplicationArea = RecordLinks; }
            systempart(Notes; Notes) { ApplicationArea = Notes; }
        }
    }
}