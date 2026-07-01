namespace GetUse.Academy.Bookstore.Permissions;

using GetUse.Academy.Bookstore;
using GetUse.Academy.Bookstore.Json;
using GetUse.Academy.Bookstore.UpdateInstall;

permissionset 50100 "BSB BOOKSTORE, EDIT"
{
    Caption = 'Edit and Create Books etc.', Comment = 'de-DE=Bearbeiten und Anlegen von Büchern usw.';
    Assignable = true;
    Permissions = tabledata "BSB Book" = RIMD,
        table "BSB Book" = X,
        tabledata "BSB AL Issue" = RIMD,
        table "BSB AL Issue" = X,
        tabledata "BSB Internal Log" = RIMD,
        table "BSB Internal Log" = X;
}