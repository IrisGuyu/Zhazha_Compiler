using namespace std;
const int ST_SIZE = 1000;
struct ST_Entry
{
	char * name;
	double value;
	ST_Entry();
};
struct ST {
	int ptr;
	ST_Entry S[ST_SIZE];
	ST();
	ST_Entry * insertEntry(char * Name, double Value);
	ST_Entry * searchEntry(char * Name);
};
ST_Entry::ST_Entry() {
	name = 0;
	value = 0;
};
ST::ST() {
	ptr = -1;
};
ST_Entry * ST::insertEntry(char * Name, double Value) {
	//cout << "insert Entry" << endl;
	if (strlen(Name) == 0 || ptr >= ST_SIZE)
		return 0;
	//cout << "Valid" << endl;
	ST_Entry * A = 0;
	if ((A = searchEntry(Name)) != 0){
		//cout << "Existing Entry" << endl;
		A->value = Value;
		return A;
	}
	//cout << "new Entry" << endl;
	ptr++;
	S[ptr].name = new char[128];
	strcpy(S[ptr].name, Name);
	S[ptr].value = Value;
	//cout << "All Set" << endl;
	return &S[ptr];
};
ST_Entry * ST::searchEntry(char * Name){
	//cout << "searchEntry" << endl;
	for (int i = ptr; i >= 0 ; i--)
	{
		if(strcmp(S[i].name, Name)==0)
			return &S[i];
	}
	return 0;

};
ST SymbolTable;
