codeunit 50100 "MNB Assisted Setup Mgt."
{

    var
        ExtensionSetupLbl: Label 'Set up the best extension', Locked = true;
        ExtensionSetupTxt: Label 'Set the best extension which does not a lot at this moment.';
        ExtensionSetupHelpUrlTxt: Label 'https://dynamics.microsoft.com/pl-pl/business-central/overview/';
        YouTubeVideoLinkTxt: Label 'https://www.youtube.com/embed/%1', Locked = true, Comment = '%1 - Video Id';




    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assisted Setup", 'OnRegister', '', false, false)]
    local procedure RunOnRegisterAssistedSetup();
    var
        AssistedSetup: Codeunit "Assisted Setup";
        AssistedSetupGroup: Enum "Assisted Setup Group";
        VideoCategory: Enum "Video Category";
        CurrentGlobalLanguage: Integer;
    begin
        CurrentGlobalLanguage := GlobalLanguage();

        //Group: MNB My Extension Group
        AssistedSetup.Add(GetAppId(), Page::"MNB Best Extension Wizard", ExtensionSetupLbl, AssistedSetupGroup::"MNB My Extension Group",
            StrSubstNo(YouTubeVideoLinkTxt, '2jqzveL_Nu4'), VideoCategory::"MNB My Extension Videos",
            ExtensionSetupHelpUrlTxt, ExtensionSetupTxt);

        GlobalLanguage(1033);
        AssistedSetup.AddTranslation(Page::"MNB Best Extension Wizard", 1033, ExtensionSetupLbl);
        GlobalLanguage(CurrentGlobalLanguage);

        UpdateStatus();
    end;

    procedure UpdateStatus()
    var
        ExtensionSetup: Record "MNB Extension Setup";
        AssistedSetup: Codeunit "Assisted Setup";
    begin
        if ExtensionSetup.Get() and (ExtensionSetup."Document Nos." <> '') then
            AssistedSetup.Complete(Page::"MNB Extension Setup");
        if ExtensionSetup.Get() and (ExtensionSetup."Document Nos." <> '') then
            AssistedSetup.Complete(Page::"MNB Best Extension Wizard");
    end;

    local procedure GetAppId(): Guid
    var
        EmptyGuid: Guid;
        Info: ModuleInfo;
    begin
        if Info.Id() = EmptyGuid then
            NavApp.GetCurrentModuleInfo(Info);
        exit(Info.Id());
    end;


}
