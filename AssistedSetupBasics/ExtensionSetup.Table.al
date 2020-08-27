table 50100 "MNB Extension Setup"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key';
        }
        field(2; "Document Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Nos.';
            TableRelation = "No. Series";
        }
        field(7; "The Best Extension"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'This Extension is the Best';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}