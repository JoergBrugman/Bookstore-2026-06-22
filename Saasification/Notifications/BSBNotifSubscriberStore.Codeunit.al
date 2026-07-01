namespace GetUse.Academy.Bookstore.Saasification.Notifications;
using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;
using System.Environment.Configuration;

codeunit 50110 "BSB Notif. Subscriber Store"
{
    var
        MyNotifications: Record "My Notifications";
        CredLimitNotif: Notification;
        CreditLimitNotifIDTxt: Label '76328ff8-fb16-4fe6-b4ba-1dcfeb048a59', Locked = true;
        CreditLimitNotifMsg: Label '%1 %2 of %3 %4 %5 is lager than %6', Comment = 'de-DE=%1 %2 von %3 %4 %5 übersteigt %6';
        CreditLimitNotifActionEditCustomerLbl: Label 'Edit Customer', Comment = 'de-DE=Debitor bearbeiten';
        CredLimitNotifTxt: Label 'Customer balance exceeds credit limit';
        CredLinitNotifDescTxt: Label 'Balance of customer is lager than the given cedit limit';

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", OnAfterGetCurrRecordEvent, '', true, true)]
    local procedure CheckCreditLimit(var Rec: Record "Sales Header")
    var
        Customer: Record Customer;
    begin
        if Rec."Bill-to Customer No." = '' then
            exit;

        Customer.SetAutoCalcFields("Balance (LCY)");
        Customer.Get(Rec."Bill-to Customer No.");
        if Customer."Credit Limit (LCY)" = 0 then
            exit;
        if (Customer."Balance (LCY)" > Customer."Credit Limit (LCY)") and
            MyNotifications.IsEnabledForRecord(CreditLimitNotifIDTxt, Customer)
        then begin
            CredLimitNotif.Id := CreditLimitNotifIDTxt;
            CredLimitNotif.Scope := CredLimitNotif.Scope::LocalScope;
            CredLimitNotif.Message(
                StrSubstNo(CreditLimitNotifMsg,
                Customer.FieldCaption("Balance (LCY)"),
                Customer."Balance (LCY)",
                Customer.TableCaption,
                Customer."No.",
                Customer.Name,
                Customer."Credit Limit (LCY)"));
            CredLimitNotif.SetData('CustNo', Customer."No.");
            CredLimitNotif.AddAction(CreditLimitNotifActionEditCustomerLbl, Codeunit::"BSB Notif. Subscriber Store", 'OpenCustomerCard');
            CredLimitNotif.Send();
        end;
    end;

    procedure OpenCustomerCard(Notification: Notification)
    var
        Customer: Record Customer;
    begin
        Customer.Get(Notification.GetData('CustNo'));
        Page.Run(Page::"Customer Card", Customer);
    end;

    [EventSubscriber(ObjectType::Page, Page::"My Notifications", OnInitializingNotificationWithDefaultState, '', false, false)]
    local procedure "My Notifications_OnInitializingNotificationWithDefaultState"()
    begin
        MyNotifications.InsertDefaultWithTableNum(CreditLimitNotifIDTxt, CredLimitNotifTxt, CredLinitNotifDescTxt, Database::Customer);
    end;

}