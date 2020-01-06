table 50120 "MNB Issue Register"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Issue Id"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Issue Id';
        }
        field(3; Title; Text[1024])
        {
            DataClassification = CustomerContent;
            Caption = 'Title';
        }
        field(4; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(5; "Close Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Close Date';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
