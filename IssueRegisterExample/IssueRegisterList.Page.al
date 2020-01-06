page 50132 "MNB Issue Register List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "MNB Issue Register";
    Caption = 'Issue Register';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(entryNo; "Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies numer in regster.';
                }
                field("Issue Id"; "Issue Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies id in external system.';
                }
                field(Title; Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies title in external system.';
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies customer number.';
                }
                field("Close Date"; "Close Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when issue was closed in external system.';
                }
            }
        }
    }
}
