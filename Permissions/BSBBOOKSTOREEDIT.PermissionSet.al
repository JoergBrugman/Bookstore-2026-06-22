namespace GetUse.Academy.Bookstore.Permissions;

using GetUse.Academy.Bookstore;

permissionset 50100 "BSB BOOKSTORE, EDIT"
{
    Caption = 'Edit and Create Books etc.', Comment = 'de-DE=Bearbeiten und Anlegen von Büchern usw.';
    Assignable = true;
    Permissions = tabledata "BSB Book" = RIMD,
        table "BSB Book" = X;
}