namespace GetUse.Academy.Bookstore.InterfaceList;

/// <summary>
/// To register your Codeunit implemting this Interface, you have to use following Event-Subscriber:
/// [EventSubscriber(ObjectType::Codeunit, Codeunit::"Check Pipeline", OnRegisterCheckSteps, '', false, false)]
/// local procedure "Check Pipeline_OnRegisterCheckSteps"(var Steps: List of [Interface "BSB Check Step"]; RecRef: RecordRef)
/// begin
///     if RecRef.Number = Database::"Your Table to check" then
///         Steps.Add(this);
/// end;
/// </summary>
interface "BSB Check Step"
{
    /// <summary>
    /// Perform the Check.
    /// </summary>
    /// <param name="RecRef">RecordRef.</param>
    /// <returns>Return value of type Text.</returns>
    procedure Execute(RecRef: RecordRef): Text;
    /// <summary>
    /// Returns the Priority of the check as an integer.
    /// Here, a low number has a high priority and lager numbers have lower priority.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure GetSequence(): Integer;
    /// <summary>
    /// Determines whether the check should be be performed. 
    /// </summary>
    /// <param name="RecRef">RecordRef.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsEnabled(RecRef: RecordRef): Boolean;
}