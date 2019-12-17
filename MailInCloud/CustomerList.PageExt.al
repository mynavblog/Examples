// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50124 MNBCustomerList extends "Customer List"
{

    actions
    {
        addfirst(processing)
        {
            action(MNBSendMail)
            {
                ApplicationArea = All;
                Caption = 'Send Mail (No error)';
                trigger OnAction()
                var
                    EmailItem: Record "Email Item" temporary;
                    Customer: Record Customer;
                    RecRef: RecordRef;
                    OutStr: OutStream;
                begin
                    EmailItem."Send to" := 'kbialowas@mynavblog.com';
                    EmailItem.Subject := 'Hello Email Item';
                    EmailItem.Validate("Plaintext Formatted", false);

                    // get the customer record and save the report to outstream
                    Customer.SetRange("No.", "No.");
                    RecRef.GetTable(Customer);
                    EmailItem.Body.CreateOutStream(OutStr);
                    Report.SaveAs(Report::"MNB Mail To Customer", '', ReportFormat::Html, OutStr, RecRef);

                    EmailItem.Send(true);
                end;
            }

            action(MNBSendMailError)
            {
                ApplicationArea = All;
                Caption = 'Send Mail (show error)';
                trigger OnAction()
                var
                    EmailItem: Record "Email Item" temporary;

                begin
                    EmailItem."Send to" := 'xxx';
                    EmailItem.Subject := 'Hello Email Item Error';
                    EmailItem.Validate("Plaintext Formatted", false);
                    EmailItem.Send(true);
                end;
            }

            action(MNBSendMailSMTP)
            {
                ApplicationArea = All;
                Caption = 'Send Mail SMTP (no error)';
                trigger OnAction()
                var
                    Customer: Record Customer;
                    SMTPMail: Codeunit "SMTP Mail";
                    TempBlob: Codeunit "Temp Blob";
                    RecRef: RecordRef;
                    Recipients: List of [Text];
                    OutStr: OutStream;
                    InStr: InStream;
                    OutStr2: OutStream;
                    InStr2: InStream;
                    BodyTxt: Text;
                begin
                    Recipients.Add('kbialowas@mynavblog.com');

                    // get the customer record and save the report to outstream then do instream and wrtie it to text
                    Customer.SetRange("No.", "No.");
                    RecRef.GetTable(Customer);
                    TempBlob.CreateOutStream(OutStr);
                    Report.SaveAs(Report::"MNB Mail To Customer", '', ReportFormat::Html, OutStr, RecRef);
                    TempBlob.CreateInStream(InStr);
                    InStr.ReadText(BodyTxt);

                    SMTPMail.CreateMessage('me', 'kbialowas@bc4all.com', Recipients, 'Hello SMTP', BodyTxt);

                    // add attachment for with pdf
                    TempBlob.CreateOutStream(OutStr2);
                    Report.SaveAs(Report::"MNB Mail To Customer", '', ReportFormat::Pdf, OutStr, RecRef);
                    TempBlob.CreateInStream(InStr2);
                    SMTPMail.AddAttachmentStream(InStr2, 'attachment.pdf');

                    SMTPMail.Send();
                end;
            }

            action(MNBSendMailSMTPError)
            {
                ApplicationArea = All;
                Caption = 'Send Mail SMTP (error)';
                trigger OnAction()
                var
                    Customer: Record Customer;
                    SMTPMail: Codeunit "SMTP Mail";
                    TempBlob: Codeunit "Temp Blob";
                    RecRef: RecordRef;
                    Recipients: List of [Text];
                    OutStr: OutStream;
                    InStr: InStream;
                    BodyTxt: Text;
                begin
                    Recipients.Add('xxx');

                    // get the customer record and save the report to outstream then do instream and wrtie it to text
                    Customer.SetRange("No.", "No.");
                    RecRef.GetTable(Customer);
                    TempBlob.CreateOutStream(OutStr);
                    Report.SaveAs(Report::"MNB Mail To Customer", '', ReportFormat::Html, OutStr, RecRef);
                    TempBlob.CreateInStream(InStr);
                    InStr.ReadText(BodyTxt);

                    SMTPMail.CreateMessage('me', 'kbialowas@bc4all.com', Recipients, 'Hello SMTP Error', BodyTxt);

                end;
            }
        }

    }
}