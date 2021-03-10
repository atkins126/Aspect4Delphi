unit Main.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Person, Person.Repository, App.Context,
  Vcl.StdCtrls;

type

  TMainView = class(TForm)
    GroupBox1: TGroupBox;
    EdtId: TEdit;
    Label1: TLabel;
    EdtName: TEdit;
    Label2: TLabel;
    EdtAge: TEdit;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    GroupBox2: TGroupBox;
    EdtCurrentSecurityRole: TComboBox;
    Button5: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    fPersonRepository: TPersonRepository;
  public
    { Public declarations }
  end;

var
  MainView: TMainView;

implementation

{$R *.dfm}

procedure TMainView.Button1Click(Sender: TObject);
var
  person: TPerson;
begin
  person := TPerson.Create(0, EdtName.Text, StrToIntDef(EdtAge.Text, 0));
  try
    fPersonRepository.Insert(person);
    EdtId.Text := person.Id.ToString;
    ShowMessage('Successfully included person.');
  finally
    person.Free;
  end;
end;

procedure TMainView.Button2Click(Sender: TObject);
var
  person: TPerson;
begin
  person := TPerson.Create(StrToIntDef(EdtId.Text, 0), EdtName.Text, StrToIntDef(EdtAge.Text, 0));
  try
    fPersonRepository.Update(person);
    ShowMessage('Successfully updated person.');
  finally
    person.Free;
  end;
end;

procedure TMainView.Button3Click(Sender: TObject);
var
  personId: Integer;
begin
  personId := StrToIntDef(InputBox('Person', 'Id', ''), 0);
  if fPersonRepository.Delete(personId) then
    ShowMessage('Successfully deleted person.');
end;

procedure TMainView.Button4Click(Sender: TObject);
var
  person: TPerson;
  personId: Integer;
begin
  personId := StrToIntDef(InputBox('Person', 'Id', ''), 0);

  person := fPersonRepository.FindById(personId);
  try
    EdtId.Text := person.Id.ToString;
    EdtName.Text := person.Name;
    EdtAge.Text := person.Age.ToString;
  finally
    person.Free;
  end;
end;

procedure TMainView.Button5Click(Sender: TObject);
begin
  CurrentSecurityRole := EdtCurrentSecurityRole.Text;
end;

procedure TMainView.FormCreate(Sender: TObject);
begin
  fPersonRepository := TPersonRepository.Create;
  CurrentSecurityRole := 'ROLE_ADMIN';
end;

procedure TMainView.FormDestroy(Sender: TObject);
begin
  fPersonRepository.Free;
end;

end.
