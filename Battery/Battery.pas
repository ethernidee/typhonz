LIBRARY Battery;
{!INFO
MODULENAME = 'Battery'
VERSION = '1'
AUTHOR = 'Master Of Puppets'
DESCRIPTION = 'DLL, ����������� ������������� � ��������� ���������� �� 4-� ����������'
}

USES WIN;

CONST
(* HookCode constants *)
C_HOOKTYPE_JUMP = FALSE;
C_HOOKTYPE_CALL = TRUE;
C_OPCODE_JUMP = $E9;
C_OPCODE_CALL = $E8;
C_UNIHOOK_SIZE = 5;
C_MOP_DLLNAME = 'Battery.dll';

TYPE
THookRec = RECORD
 Opcode: BYTE;
 Ofs: INTEGER;
END; // .record THookRec

VAR
hBattery: Win.THandle; // ���������� ����������
Temp: INTEGER; //������������� ��������� ����������
PointerOfSlotsTable: INTEGER; //������ ����� ������ � ����������� ������
Error1: STRING = '"!!CA:D"-wrong syntax'; //������ � ���-�� ���������� �������
Error2: STRING = '"!!CA:D"-A level of dwelling out of range (0...6)'; //������ � ������ ���������
Error3: STRING = '"!!CA:D"-wrong slot number (0...3)'; //������ � ������ �����

PROCEDURE WriteAtCode(P: POINTER; Buf: POINTER; Count: INTEGER);
BEGIN
Win.VirtualProtect(P, Count, PAGE_READWRITE, @Temp);
Win.CopyMemory(P, Buf, Count);
Win.VirtualProtect(P, Count, Temp, NIL);
END; // .procedure WriteAtCode

PROCEDURE HookCode(P: POINTER; NewAddr: POINTER; UseCall: BOOLEAN);
VAR
HookRec: THookRec;
BEGIN
IF UseCall THEN BEGIN
 HookRec.Opcode:=C_OPCODE_CALL;
END // .if
ELSE BEGIN
 HookRec.Opcode:=C_OPCODE_JUMP;
END; // .else
HookRec.Ofs:=INTEGER(NewAddr)-INTEGER(P)-C_UNIHOOK_SIZE;
WriteAtCode(P, @HookRec, 5);
END; // .procedure HookCode

PROCEDURE MOP_TOWN_RECRUIT_WINDOW; ASSEMBLER; //�������������� ��������� - ����������-����������� � ������� ������ Sub_5D3640
ASM
	MOV EDX, ECX
	ADD EDX, 30
	MOV ECX, [6919500]
	PUSH EBP
	MOV EBP,ESP
	PUSH -1
	PUSH $411CB6
	PUSH EAX
	SUB ESP,$22C
	PUSH EBX
	MOV EBX,ECX
	PUSH ESI
	PUSH EDI
	MOV EDI,EDX
	PUSH $5D42C4
END;

PROCEDURE Fort_hall; ASSEMBLER;
ASM
	PUSH EBP
	MOV EBP,ESP
	PUSH EBX
	PUSH ESI
	PUSH EDI
	PUSHAD
	MOV EDI, ESI //������� ���������
	MOV EAX, [$69954C] //TownManager
	MOV [$836A18],EDX
	MOV [$83A86C],EAX
	PUSH $70DD45
END;

PROCEDURE Horde; ASSEMBLER;
ASM
	PUSH EBP
	MOV EBP,ESP
	PUSH EBX
	PUSH ESI
	PUSH EDI
	PUSHAD
	MOV ECX, [EBP+8]
	MOV [$836A18],ECX
	mov edi, [$6747B0]
	mov eCx, [ecx+$5C]
	IMUL ECX, 116
	MOV EDI, [EDI+ECX+4] //������� ��������� (����������� �� ������ ��������)
	MOV EAX, [$69954C] //TownManager
	MOV [$83A86C],EAX
	PUSH $70DD45
END;

PROCEDURE allslots_realize; ASSEMBLER;
ASM
		mov eax,[$69954C]
		mov eax,[eax+$38]
	movsx eax, byte [eax] //�������� ����� �������� ������
	imul eax, 224 //�������� �� ������ ���������
	Cmp EDI, 7
	JL @nonupgrade
	sub edi, 7
@nonupgrade:
	imul edi, 32
	lea eax, [eax+edi]
	add eax, [PointerOfSlotsTable]
	mov edx,[$836A18]
	mov ecx, [eax]
	cmp ecx, -2
	JLE @@not_change0
	mov [edx+$5C],ecx //������ �������
	mov [edx+$50],ecx //� ��� - ��� ����������� ����� ����� �� ������� �����. ����� ����� �������� ������, � ������� ������
	lea ecx, [eax+4]
	mov [edx+$6C],ecx
@@not_change0:
	mov ecx, [eax+8]
	cmp ecx, -2
	JLE @@not_change1
		mov [edx+$60],ecx
	lea ecx, [eax+12]
	mov [edx+$70],ecx
@@not_change1:
	mov ecx, [eax+16]
	cmp ecx, -2
	JLE @@not_change2
		mov [edx+$64],ecx
	lea ecx, [eax+20]
	mov [edx+$74],ecx
@@not_change2:
	mov ecx, [eax+24]
	cmp ecx, -2
	JLE @@not_change3
		mov [edx+$68],ecx
	lea ecx, [eax+28]
	mov [edx+$78],ecx
@@not_change3:
		pop edi
		pop esi
		pop ebx
		mov esp, ebp
		pop ebp
END;

PROCEDURE Reset_Table; ASSEMBLER; //���������� ������� ������ ���������� ���������� ����� ����������� ���������� �����
ASM
	MOV ECX, 2688 //������ ������/4
	MOV EAX, -2 //��������� ��������� -2
	MOV EDI, [PointerOfSlotsTable] //����� ������
	REP STOSD //��������� ������ ������ ���������� ����������
	MOV EAX, $749955
	CALL EAX
END;

PROCEDURE Save_Table; ASSEMBLER; //���������� �������
ASM
	PUSH 10752
	PUSH [PointerOfSlotsTable]
	MOV EAX, $704062
	CALL EAX
	ADD ESP, 8
	TEST EAX,EAX
	JE @@Norm
	MOV EAX, $7712B0 //����������
	CALL EAX
	MOV EAX, 1
	PUSH $7515F8
	RET
@@Norm:
	PUSH $7D000
	PUSH $75102B
END;

PROCEDURE Load_Table; ASSEMBLER; //�������� �������
ASM
	PUSH 10752
	PUSH [PointerOfSlotsTable]
	MOV EAX, $7040A7
	CALL EAX
	ADD ESP, 8
	TEST EAX,EAX
	JE @@Norm
	MOV EAX, $7712B0 //��������
	CALL EAX
	MOV EAX, 1
		PUSH $752591
	RET
@@Norm:
	PUSH $7D000
	PUSH $7517F4
END;

PROCEDURE CA_D_realize; ASSEMBLER; //����� �������� - CA:D
ASM
	mov eax,[ebp-$38]
	CMP EAX, "D" //�������� �� ����� ������ ���������
	JNZ @@not_CA_D
		cmp dword [ebp+$0C],4
	JE @@norm_number_of_param
	PUSH Error1
	PUSH $70DFB8
	RET
@@norm_number_of_param:
	PUSH 0 //����� ��������� � �������
	PUSH DWORD [EBP+$14]
	PUSH 4 //������ ������
	LEA EAX,[EBP-4] //����� ��� ������/������ ����������
	PUSH EAX
	MOV EAX, $74195D //�������� 1-�� �������� ������� - ������� ���������
	CALL EAX
	ADD ESP,$10
	CMP ECX, 6
	JG @@ERROR_1
	TEST ECX, ECX
	JL @@ERROR_1
	JMP @@norm_dwelling_level
@@ERROR_1:
	PUSH Error2
	PUSH $70DFB8
	RET
@@norm_dwelling_level:
	MOV EDX,[EBP-$10] //�������� ����� ��������� ������, ��������� � ���-����
	MOVSX EDX, BYTE [EDX] //�������� ����� ������
	IMUL EDX, 224 //�������� �� ������ ������ ��� ������
	ADD edx, [PointerOfSlotsTable]
	IMUL ECX, 32 //�������� ������� ���������
	ADD EDX, ECX
	MOV [EBP-4], EDX
	PUSH 1
	PUSH DWORD [EBP+$14]
	PUSH 4
	LEA EAX,[EBP-$18]
	PUSH EAX
	MOV EAX, $74195D //�������� 2-�� �������� ������� - ����� �����
	CALL EAX
	ADD ESP,$10
	CMP ECX, 3
	JG @@ERROR_2
	TEST ECX, ECX
	JL @@ERROR_2
	JMP @@norm_slot_number
@@ERROR_2:
	PUSH Error3
	PUSH $70DFB8
	RET
@@norm_slot_number:
	IMUL ECX, 8
	ADD [EBP-4], ECX
	PUSH 2
	PUSH DWORD [EBP+$14]
	PUSH 4
	PUSH DWORD [EBP-4] //����� �����, ���� ����� �������� ��� �� �������� ����� ������ ��� ��������
	MOV EAX, $74195D //�������� 3-�� �������� ������� - ��� ��������
	CALL EAX
	ADD ESP,$10
	PUSH 3
	PUSH DWORD [EBP+$14]
	PUSH 4
	MOV eax, [EBP-4]
	ADD EAX, 4 //�������� +4 ��� ���-�� ������� � �����
	PUSH EAX
	MOV EAX, $74195D //�������� 4-�� �������� ������� - ���-�� �������
	CALL EAX
	ADD ESP,$10
	PUSH $70E984
	RET
@@not_CA_D:
	sub eax, $42
	PUSH $70DF8F
END;

PROCEDURE Fort_Trigger; ASSEMBLER; //������� �� ����� � ����-�����
ASM
	mov edx,$0E
	PUSHAD
	SETE BYTE [$A4AAFC] //�� ��������� ��������� ����������� �������
	MOV edi, $8912A8
	mov esi, ebx
	push esi //��������� ������ ��� ������������ ��������
	push edi
	mov ecx, 6
	REP MOVSD //�������� ��� ��������� ����� � ���-������
	PUSH 88888 //����� ERM-������� ��� ��������
	MOV EAX, $74CE30
	CALL EAX
	ADD ESP, 4
	pop edi
	pop esi
	XCHG ESI,EDI //������ ������� ������ ��� �������� ���-������ � ���������
	mov ecx, 6
	REP MOVSD //�������� ��� ��������� ����� �� ���-������ � ���-���� � ����� (��� ��������� ���������)
	POPAD
	TEST BYTE [$A4AAFC],1 //�������� CM:R
	JNZ @@standart
	PUSH $5DD64A
	RET
@@standart:
	PUSH $5DD3D0
END;

EXPORTS
MOP_TOWN_RECRUIT_WINDOW NAME 'MOP_TOWN_RECRUIT_WINDOW'; //��������� ������ ����� �������

BEGIN
hBattery:=Win.GetModuleHandle(C_MOP_DLLNAME);
Win.DisableThreadLibraryCalls(hBattery);
HookCode(POINTER($5DD2FC), @Fort_hall, C_HOOKTYPE_CALL); //������ ���, ����������� ����������, �� ����-����
HookCode(POINTER($5D4271), @Horde, C_HOOKTYPE_CALL); //������ ���, ����������� ����������, �� ������ ����
HookCode(POINTER($70DD2C), @allslots_realize, C_HOOKTYPE_JUMP); //��������� �������� �� �������
ASM //�������� ������ ��� ��������� ����������
	PUSH 4
	PUSH $1000
	PUSH 10752 //������ ������ = 8 ���� �� ���� (��� + ���-��) * 4 ����� * 7 ������� ���������� * 48 ������� �� �����
	PUSH 0
	CALL Win.VirtualAlloc
	PUSH 4
	PUSH $1000
	PUSH 10752 //������ ������
	PUSH EAX
	CALL Win.VirtualAlloc
	MOV [PointerOfSlotsTable], EAX
END;
HookCode(POINTER($74C7E5), @Reset_Table, C_HOOKTYPE_CALL); //����� �������� � ������� �� -2 (��������� ��������) ��� ������ ����� ����� �����������
HookCode(POINTER($751026), @Save_Table, C_HOOKTYPE_JUMP);  //���������� �������
HookCode(POINTER($7517EF), @Load_Table, C_HOOKTYPE_JUMP);  //�������� �������
HookCode(POINTER($70DF89), @CA_D_realize, C_HOOKTYPE_JUMP); //���������� ������� CA:D
HookCode(POINTER($5DD3CB), @Fort_Trigger, C_HOOKTYPE_JUMP); //���������� �������� �� ���� � ���� �����
END.
