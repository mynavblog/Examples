report 50124 "MNB Mail To Customer"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    WordLayout = 'MailToCustomer.docx';
    DefaultLayout = Word;
    Caption = 'Mail To Customer';
    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(Name; Name)
            {
            }
            column(HelloTxt; HelloTxt)
            {
            }
        }
    }
    var
        HelloTxt: Label 'Hello my Dear Customer';
}