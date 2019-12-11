page 50123 "MNB My Dictionary"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "MNB My Dictionary";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies code for dictiorary';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies decription for dictiorary';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ChangeSystemId)
            {
                ApplicationArea = All;
                Caption = 'Change SystemId';

                trigger OnAction();
                begin
                    SystemId := CreateGuid();
                    Modify(true);
                end;
            }
            action(MessageSystemId)
            {
                ApplicationArea = All;
                Caption = 'Message SystemId';

                trigger OnAction();
                begin
                    Message('This is SystemId %1', SystemId);
                end;
            }
            action(GetBySystemId)
            {
                ApplicationArea = All;
                Caption = 'Get by SystemId';

                trigger OnAction();
                var
                    MNBMyDictionary: Record "MNB My Dictionary";
                begin
                    MNBMyDictionary.GetBySystemId(SystemId);
                    Message('Record get by SystemId is %1', MNBMyDictionary.Code);
                end;
            }
            action(TemporaryRecord)
            {
                ApplicationArea = All;
                Caption = 'TemporaryRecord SystemId';

                trigger OnAction();
                var
                    MNBMyDictionaryTemp: Record "MNB My Dictionary" temporary;
                begin
                    //No value in SystemId.
                    MNBMyDictionaryTemp.Init();
                    MNBMyDictionaryTemp.TransferFields(Rec);
                    MNBMyDictionaryTemp.Insert(true, true);
                    Message('Record SystemId %1, Temporary Record SystemId  %2', SystemId, MNBMyDictionaryTemp.SystemId);

                    //Value is copied to SystemId
                    MNBMyDictionaryTemp.DeleteAll();
                    MNBMyDictionaryTemp.Init();
                    MNBMyDictionaryTemp := Rec;
                    MNBMyDictionaryTemp.Insert(true, true);
                    Message('Record SystemId %1, Temporary Record SystemId  %2', SystemId, MNBMyDictionaryTemp.SystemId);
                end;
            }
            action(RecordRefSystemId)
            {
                ApplicationArea = All;
                Caption = 'RecRef SystemId';

                trigger OnAction();
                var
                    RecRef: RecordRef;
                    FieRef: FieldRef;
                    FieRef2: FieldRef;
                begin
                    RecRef.Open(Database::"MNB My Dictionary");
                    RecRef.SetTable(Rec);
                    RecRef.FindFirst();
                    FieRef := RecRef.Field(RecRef.SystemIdNo());
                    FieRef2 := RecRef.Field(1);
                    Message('SystemId from FieldRef is %1, where code is %2. SystemId field No. is %3', FieRef.Value(), FieRef2.Value(), RecRef.SystemIdNo());
                end;
            }
            action(InsertRecord)
            {
                ApplicationArea = All;
                Caption = 'Insert record the same SystemId';

                trigger OnAction();
                var
                    MNBMyDictionary: Record "MNB My Dictionary";
                    Customer: Record Customer;
                begin
                    Customer.FindFirst();
                    MNBMyDictionary.Init();
                    MNBMyDictionary.Code := 'YYY';
                    MNBMyDictionary.Description := 'xxx';
                    MNBMyDictionary.SystemId := Customer.SystemId;
                    MNBMyDictionary.Insert(true, true);
                end;
            }
            action(RenameRecord)
            {
                ApplicationArea = All;
                Caption = 'Rename Record';

                trigger OnAction();
                begin
                    Message('Record %1 SystemId is %2', Code, SystemId);
                    Rename(Format(Random(20000)));
                    Message('Record %1 SystemId after rename is %2', Code, SystemId);
                end;
            }
        }
    }
}