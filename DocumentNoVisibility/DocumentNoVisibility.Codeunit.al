codeunit 50100 "MNB DocumentNoVisibility"
{
    //Note: You are using the code on your own risk
    //Change name of the fuctions to reflect your case
    //In function DetermineMyCustomRecordSeriesNo set proper variables and fields 
    //on your custom Document or Card page invoke MyCustomRecordNameNoIsVisible procedure 

    procedure MyCustomRecordNameNoIsVisible(): Boolean
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        IsVisible: Boolean;
        MyCustomRecordNoVisible: Boolean;
    begin
        IsHandled := false;
        IsVisible := false;
        OnBeforeMyCustomRecordNameNoIsVisible(IsVisible, IsHandled);
        if IsHandled then
            exit(IsVisible);

        NoSeriesCode := DetermineMyCustomRecordSeriesNo;
        MyCustomRecordNoVisible := DocumentNoVisibility.ForceShowNoSeriesForDocNo(NoSeriesCode);
        exit(MyCustomRecordNoVisible);
    end;

    local procedure DetermineMyCustomRecordSeriesNo(): Code[20]
    var
        MyCustomSetupTable: Record "My Custom Setup";
        MyCustomTable: Record "My Custom Table";
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        MyCustomSetupTable.Get();
        DocumentNoVisibility.CheckNumberSeries(MyCustomTable, MyCustomSetupTable."MyCustomerTable Nos.", MyCustomTable.FieldNo("No."));
        exit(MyCustomSetupTable."MyCustomerTable Nos.");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeMyCustomRecordNameNoIsVisible(var IsVisible: Boolean; var IsHandled: Boolean)
    begin
    end;
}