page 50120 "MNB Issue Register"
{
    PageType = API;
    Caption = 'issueRegister';
    APIPublisher = 'kbialowas';
    APIGroup = 'mnb';
    APIVersion = 'v2.0';
    EntityName = 'issueRegister';
    EntitySetName = 'issueRegister';
    SourceTable = "MNB Issue Register";
    DelayedInsert = true;
    InsertAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; SystemId)
                {
                }
                field(entryNo; "Entry No.")
                {
                }
                field(IssueId; "Issue Id")
                {
                }
                field(title; Title)
                {
                }
                field(customerNo; "Customer No.")
                {
                }
                field(closeDate; "Close Date")
                {
                }
            }
        }
    }
}
