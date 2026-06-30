namespace GetUse.Academy.Bookstore.InterfaceList;
using System.Reflection;
using System.Utilities;

codeunit 50105 "BSB Check Pipeline"
{
    procedure ProcessPipeline(Variant: Variant)
    var
        DataTypeManagement: Codeunit "Data Type Management";
        RecRef: RecordRef;
    begin
        if not DataTypeManagement.GetRecordRef(Variant, RecRef) then
            exit;
        ProcessPipeline(RecRef);

    end;

    procedure ProcessPipeline(RecRef: RecordRef)
    var
        Steps: List of [Interface "BSB Check Step"];
        Step: Interface "BSB Check Step";
        ResultTxt: Text;
        TxtBuilder: TextBuilder;
    begin
        CollectSteps(Steps, RecRef);
        // SortSteps(Steps);
        SortStepsBubbleSort(Steps);

        foreach Step in Steps do
            if Step.IsEnabled(RecRef) then begin
                ResultTxt := Step.Execute(RecRef);
                if ResultTxt <> '' then
                    TxtBuilder.AppendLine(ResultTxt);
            end;

        if TxtBuilder.Length() > 0 then
            Message(TxtBuilder.ToText());

    end;

    local procedure CollectSteps(var Steps: List of [Interface "BSB Check Step"]; RecRef: RecordRef)
    begin
        OnRegisterCheckSteps(Steps, RecRef);
    end;

    local procedure SortSteps(var Steps: List of [Interface "BSB Check Step"])
    var
        Integer: Record Integer;
        Sorted: List of [Interface "BSB Check Step"];
        Step: Interface "BSB Check Step";
    begin
        // Vorkommende Prios in Interger-Tabelle merken
        foreach Step in Steps do begin
            Integer.Get(Step.GetSequence());
            Integer.Mark(true);
        end;
        // Auf die markierten Datensätze filtern
        Integer.MarkedOnly(true);

        // Die Prioritäten nacheinander durchgehen
        if Integer.FindSet() then
            repeat
                // Jetzt Interfaces, die zu einer Prio gehören, nacheinander in die sortierte Liste übertragen
                foreach Step in Steps do
                    if Integer.Number = Step.GetSequence() then
                        Sorted.Add(Step);
            until Integer.Next() = 0;

        Steps := Sorted;
    end;

    local procedure SortStepsBubbleSort(var Steps: List of [Interface "BSB Check Step"])
    var
        Temp: Interface "BSB Check Step";
        I, J : Integer;
        Swapped: Boolean;
    begin
        if Steps.Count() <= 1 then
            exit;

        for I := 1 to Steps.Count() - 1 do begin
            Swapped := false;
            for J := 1 to Steps.Count() - I do
                if Steps.Get(J).GetSequence() > Steps.Get(J + 1).GetSequence() then begin
                    Temp := Steps.Get(J);
                    Steps.Set(J, Steps.Get(J + 1));
                    Steps.Set(J + 1, Temp);
                    Swapped := true;
                end;

            if not Swapped then
                break;
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRegisterCheckSteps(var Steps: List of [Interface "BSB Check Step"]; RecRef: RecordRef)
    begin
    end;
}