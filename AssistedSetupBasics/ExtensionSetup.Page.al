page 50100 "MNB Extension Setup"
{

    PageType = Card;
    SourceTable = "MNB Extension Setup";
    Caption = 'MNB Extension Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("The Best Extension"; Rec."The Best Extension")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if this is the best extension.';
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                field("Document Nos."; Rec."Document Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series that will be used to assign numbers to documents.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        AssistedSetupMgt: Codeunit "MNB Assisted Setup Mgt.";
    begin
        AssistedSetupMgt.UpdateStatus();
    end;

}
