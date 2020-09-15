page 50101 "MNB Best Extension Wizard"
{
    Caption = 'Best Extension';
    PageType = NavigatePage;
    SourceTable = "MNB Extension Setup";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(StandardBanner)
            {
                Caption = '';
                Editable = false;
                Visible = TopBannerVisible and not FinishActionEnabled;
                field(MediaResourcesStandard; MediaResourcesStandard."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(FinishedBanner)
            {
                Caption = '';
                Editable = false;
                Visible = TopBannerVisible and FinishActionEnabled;
                field(MediaResourcesDone; MediaResourcesDone."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }

            group(Step1)
            {
                Visible = Step1Visible;
                group("Welcome to MNB Best Extension")
                {
                    Caption = 'Welcome to Best Extension Setup';
                    Visible = Step1Visible;
                    group(Group18)
                    {
                        Caption = '';
                        InstructionalText = 'To prepare Best Extension for first use, you must specify some basic information.';
                    }
                }
                group("Let's go!")
                {
                    Caption = 'Let''s go!';
                    group(Group22)
                    {
                        Caption = '';
                        InstructionalText = 'Choose Next so you can specify basic extension settings.';
                    }
                }
            }
            group(Step2Container)
            {
                Visible = Step2Visible;
                Caption = '';
                ShowCaption = false;

                group(Step2)
                {
                    Caption = 'Specify number of series for the extension.';
                    InstructionalText = 'Number of series are used to provide sequence number to extension objects';
                    Visible = Step2Visible;

                    field("Document Nos."; Rec."Document Nos.")
                    {
                        Visible = Step2Visible;
                        ApplicationArea = All;
                        Caption = 'What numbers should be used for documents?';
                        ShowMandatory = true;
                        ToolTip = 'Specifies the number series that will be used to assign numbers to documents.';
                    }
                }
            }
            group(Step3Container)
            {
                Visible = Step3Visible;
                Caption = '';
                ShowCaption = false;

                group(Step3)
                {
                    Caption = 'Specify additional parameters for the extension';
                    InstructionalText = 'This information is needed for using the extension.';
                    Visible = Step3Visible;
                    field("The Best Extension"; Rec."The Best Extension")
                    {
                        Visible = Step2Visible;
                        ApplicationArea = All;
                        Caption = 'Is it really the best extension?';
                        ShowMandatory = true;
                        ToolTip = 'Specifies if the extension is really the best extension.';
                    }

                }
            }

            group(Step4)
            {
                Visible = Step4Visible;
                group("That's it!")
                {
                    Caption = 'That''s it!';
                    group(Group25)
                    {
                        Caption = '';
                        InstructionalText = 'To save this setup, choose Finish.';
                    }
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(ActionBack)
            {
                ApplicationArea = All;
                Caption = 'Back';
                Enabled = BackActionEnabled;
                Image = PreviousRecord;
                InFooterBar = true;
                trigger OnAction();
                begin
                    NextStep(true);
                end;
            }
            action(ActionNext)
            {
                ApplicationArea = All;
                Caption = 'Next';
                Enabled = NextActionEnabled;
                Image = NextRecord;
                InFooterBar = true;
                trigger OnAction();
                begin
                    NextStep(false);
                end;
            }
            action(ActionFinish)
            {
                ApplicationArea = All;
                Caption = 'Finish';
                Enabled = FinishActionEnabled;
                Image = Approve;
                InFooterBar = true;
                trigger OnAction();
                begin
                    FinishAction();
                end;
            }
        }
    }
    trigger OnInit();
    begin
        LoadTopBanners();
    end;

    trigger OnOpenPage();
    var
        ExtensionSetup: Record "MNB Extension Setup";
    begin
        Rec.Init();
        if ExtensionSetup.Get() then
            Rec.TransferFields(ExtensionSetup);

        Rec.Insert();

        Step := Step::Start;
        EnableControls();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        AssistedSetup: Codeunit "Assisted Setup";
    begin
        if CloseAction = Action::OK then
            if AssistedSetup.ExistsAndIsNotComplete(Page::"MNB Best Extension Wizard") then
                if not Confirm(NotSetUpQst, false) then
                    Error('');
    end;

    var
        MediaRepositoryDone, MediaRepositoryStandard : Record "Media Repository";
        MediaResourcesDone, MediaResourcesStandard : Record "Media Resources";
        Step: Option Start,Step2,Step3,Finish;
        BackActionEnabled, FinishActionEnabled, NextActionEnabled, TopBannerVisible : Boolean;
        Step1Visible, Step2Visible, Step3Visible, Step4Visible : Boolean;
        NotSetUpQst: Label 'The extension is not set up.\\Are you sure that you want to close this guide?';



    local procedure EnableControls();
    begin
        ResetControls();

        case Step of
            Step::Start:
                ShowStep1();
            Step::Step2:
                ShowStep2();
            Step::Step3:
                ShowStep3();
            Step::Finish:
                ShowStep4();
        end;
    end;

    local procedure StoreExtensionSetup();
    var
        ExtensionSetup: Record "MNB Extension Setup";
    begin
        if not ExtensionSetup.Get() then begin
            ExtensionSetup.Init();
            ExtensionSetup.Insert();
        end;

        ExtensionSetup.TransferFields(Rec, false);
        ExtensionSetup.Modify(true);
    end;


    local procedure FinishAction();
    begin
        StoreExtensionSetup();
        CurrPage.Close();
    end;

    local procedure NextStep(Backwards: Boolean);
    begin
        if Backwards then
            Step := Step - 1
        else
            Step := Step + 1;

        EnableControls();
    end;

    local procedure ShowStep1();
    begin
        Step1Visible := true;

        FinishActionEnabled := false;
        BackActionEnabled := false;
    end;

    local procedure ShowStep2();
    begin
        Step2Visible := true;
    end;

    local procedure ShowStep3();
    begin
        Step3Visible := true;
    end;

    local procedure ShowStep4();
    begin
        Step4Visible := true;

        NextActionEnabled := false;
        FinishActionEnabled := true;
    end;

    local procedure ResetControls();
    begin
        FinishActionEnabled := false;
        BackActionEnabled := true;
        NextActionEnabled := true;

        Step1Visible := false;
        Step2Visible := false;
        Step3Visible := false;
        Step4Visible := false;
    end;

    local procedure LoadTopBanners();
    begin
        if MediaRepositoryStandard.Get('AssistedSetup-NoText-400px.png', Format(CurrentClientType())) and
           MediaRepositoryDone.Get('AssistedSetupDone-NoText-400px.png', Format(CurrentClientType()))
        then
            if MediaResourcesStandard.Get(MediaRepositoryStandard."Media Resources Ref") and
               MediaResourcesDone.Get(MediaRepositoryDone."Media Resources Ref")
            then
                TopBannerVisible := MediaResourcesDone."Media Reference".HasValue();
    end;
}