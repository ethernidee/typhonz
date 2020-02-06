; Dwellings.dll
; Copyright � 2017, the Master
; All rights reserved.

; FORMAT
format PE GUI 4.0 DLL at 1000000h
entry Dwellings

; Extendedheaders
 include '../../include/win32ax.inc'

; HookType constants:
TJump = 0xE9
TCall = 0xE8

; Macro instructions:
comment fix match +,-

macro Hook ExeAdress, ProcDll, HookType
{	dd ExeAdress
	dd ProcDll
	db HookType}

section '.text' code readable executable

proc Dwellings
	push esi
; ������ ����
	mov esi, Table_Hooks
.LoopHooks:
	mov al, [esi+8]
	mov ecx, [esi+4];
	mov edx, [esi]; ����
	mov [edx], al
	lea eax, [edx+5]
	sub ecx, eax
	mov [edx+1], ecx
	add esi, 9
	cmp esi, End_Table_Hooks
	jl .LoopHooks
	pop esi
	xor eax, eax
	inc eax
	ret 0Ch
endp

proc MAINDWELLINGS
	je .ERROR
	call DWTABLE
	test al, al
	jnz @f; ���� ������� ��������
.ERROR:
	push 0x4EE006
	ret
@@:
; ������ ��������� �� �������� ���������� ���� 17 ������� ������:
	mov eax, DwellingsTable+4
	mov [0x40B521], eax
	mov [0x413E78], eax
	mov [0x4A1553], eax
	mov [0x40B517], eax
	mov [0x413E6D], eax
	lea edi, [eax+4004]; �������� �� ������ �� ������ ������� � ���� ������
	lea ebx, [edi+4000]; �������� �� ���������� ����� = ������� ����������
; ������ ��������� �� ������� ���������� ���������� ���� 17:
	mov [0x418754], ebx
	mov [0x4B85A3], ebx
	mov [0x5032D8], ebx
	mov [0x521A87], ebx
	mov [0x534CEA], ebx
	mov esi, 1000; �������
; ����������� ����� � ����� � ������ ��������� � ������� ���������� ���������� ���� 17
@@:
	push dword [edi]
	mov eax, 0x77D3D7
	call eax; �������� ���-������� �������������� ������ � �����
	pop ecx
	mov [ebx], eax; ���������� ����� �������� � ������� ����������
	add ebx, 4
	add edi, 4
	dec esi
	jnz @b
; ������ ��������� �� �������� ���������� ���� 20:
	add ebx, 4
	mov [0x40B559], ebx
	mov [0x40B579], ebx
	mov [0x413EB3], ebx
	mov [0x413ED3], ebx
	mov [0x4A155F], ebx
; ����������� ����� � ����� � ������ ��������� � ������� ���������� ���������� ���� 20
	lea edi, [ebx+4004]; �������� �� ������ �� ������ ������� � ���� ������
	lea ebx, [ebx+20016]; �������� �� ������� ����������
	mov [0x4B85B7], ebx; ������ ��������� �� ������� ���������� ���������� #20
	mov esi, 1000; �������
@@:
	push dword [edi]; �������� 1
	mov eax, 0x77D3D7
	call eax; �������� ���-������� �������������� ������ � �����
	mov [ebx], eax
	push dword [edi+4004]; �������� 2
	mov eax, 0x77D3D7
	call eax; �������� ���-������� �������������� ������ � �����
	mov [ebx+4], eax
	push dword [edi+8008]; �������� 3
	mov eax, 0x77D3D7
	call eax; �������� ���-������� �������������� ������ � �����
	mov [ebx+8], eax
	push dword [edi+12012]; �������� 4
	mov eax, 0x77D3D7
	call eax; �������� ���-������� �������������� ������ � �����
	mov [ebx+12], eax
	add esp, 4*4; �� ��� ������
	add ebx, 4*4
	add edi, 4
	dec esi
	jnz @b
; ����������� ������ �� ���-�� ������ zlagport.def ��� ���������� � ����� (�� ���������� � �� �� ����������)
	push dword [NumberOfFrames17]
	mov eax, 0x77D3D7
	call eax; �������� ���-������� �������������� ������ � �����
	pop ecx
	mov [NumberOfFrames17], eax
	push dword [NumberOfFrames20]
	mov eax, 0x77D3D7
	call eax; �������� ���-������� �������������� ������ � �����
	pop ecx
	mov [NumberOfFrames20], EAX
	mov dword [0x5032BC], 999; ���������� ������� ���������� ���������� ��������� (��� ��������� � ��������� ������). �� ����� ������ �� ����� ������� � ������, ���� � �� ��� ����������
	mov dword [0x5032C8], DwellingsTable+12004; �����, � �������� ���������� ������������ (��������� ��������� ��������� 17, ��� ������������ ��� ����� ������)
; ������ ������ ��� ��������� ����� ��������:
; ����
	add eax, [NumberOfFrames17]; ��������� ���-�� ������ ���������� = ���� �����
	mov [0x520D1D], eax; � ����� ���������� �����, ��� ������������ ����� ����� � ���� �������� ����� (�� ��������� ������ ���������)
; �������� (�������)
	inc eax; ����������� �� 1
	mov [0x520EFF], eax; ����������
; �������� (��������������)
	inc eax; ����������� �� 1
	mov [0x520F58], eax; ����������
; ����������� �����
	inc eax; ����������� �� 1
	mov [0x520CAA], eax; ����������
; ����������: �������� ����� C��������� � zlagport.def, ������ �����, �� ������������, ������, ��������. ������� ��� ������ ����� ����� EBX ����������� �� 2.
; �����
	add eax, 2; ����������� �� 2. ���� �� ���������� �������� ����� ����������, �� ����� �������� �� INC EBX
	mov [0x52103D], eax; ����������
	mov dword [0x539C77], 1000; ���-�� ���������� ��� ��������� �� ��������� �����
	push 0x4EDED6
	ret
endp

; ������� �������� ����������
proc DWTABLE
	mov ecx, TXT_name; �������� ����������
	mov eax, 0x55C2B0
	call eax
	test eax, eax
	jnz @f; ������ �� �������� ����� ���������� � ������ �������� ��������
	xor al, al; �������������� ��������� ��������
	ret
@@:
	push ebx esi edi
	xor esi, esi
	mov edi, 0x691260
@@:
	mov ecx, [eax+0x20]
	mov ecx, [ecx+esi]
	mov edx, [ecx+4]
	mov ecx, [edx]
	mov [esi+DwellingsTable], ecx; ������� 1
	add esi, 4
	cmp esi, 4004
	JL @b
	xor esi, esi
@@:
	mov ecx, [eax+0x20]
	mov ecx, [ecx+esi]
	mov edx, [ecx+4]
	mov ecx, [edx+4]
	mov [esi+DwellingsTable+4004], ecx; ������� 2
	add esi, 4
	cmp esi, 4004
	JL @b
; �������� ���� ������� ��� ���������� ���� 20
	mov ebx, DwellingsTable+8004; ��������� ����� ������ + �������� �� ������� ���������� ���������� ���� 17 -> ������� ����� �� ��������� ����������
	xor edi, edi
.LoopFiveColumns: ;������� ����
	add ebx, 4004; �������� ��������
	xor esi, esi
@@:; ���������� ���� (������� - ESI)
	mov edx, [eax+0x20]
	mov ecx, [edx+esi]
	mov edx, [ecx+4]
	mov edx, [edx+edi*4+12]
	mov [esi+ebx], edx
	add esi, 4
	cmp esi, 4004
	jl @b
	inc edi
	cmp edi, 5
	jl .LoopFiveColumns
; �������� ������ �� ������ ������������, ��� ���������� ����� ������ � zlagport.def
	mov edx, [eax+0x20]
	mov ecx, [edx]
	mov edx, [ecx+4]
	mov ecx, edx
	mov edx, [ecx+8]; ������� 3 (��� 17)
	mov [NumberOfFrames17], edx
	mov edx, [ecx+32]; ������� 9 (��� 20)
	mov [NumberOfFrames20], edx
	mov al, 1; �������������� �������� ��������
	pop edi esi ebx
	ret
endp

proc PatchDword1
	mov ecx, [edx+ecx*4+0x3C]; �������� ������ ��������� � ������� dword
	mov [Temp], ecx; ������� ������ �� ��������� ����������
	mov [ebp-0x67], cl; ������������ ������ � ������� 1 ����, ������� ������ �� ���� ���������� � ��������� �������
	push 0x4FF3FC; ������� � ���
	ret
endp

proc PatchDword2
	jnz .DwellingType20
	mov eax, [Temp]; �������� ������ �� ��������� ����������
	push 0x4B85A0
	ret
.DwellingType20:
	mov ecx, [Temp]
	push 0x4B85B2
	ret
endp

proc PatchDword3
	mov eax, 0x74E007; ���������� �������� ���-����
	call eax
	movzx ebx, word [eax+0x22]; �������� �������� ������ �� ������ ������� �������� ��������
	mov [Temp], ebx; ���������� ��� �� ��������� ����������
	push 0x40B156
	ret
endp

proc PatchDword3_17
	mov eax, [Temp]
	cmp ecx, -1; ������� ���
	push 0x40B50B
	ret
endp

proc PatchDword3_20
	mov eax, [Temp]
	cmp ecx, -1; ������� ���
	push 0x40B54D
	ret
endp

proc PatchDword4
	mov eax, 0x40AF10
	call eax
	movzx ebx, word [eax+0x22]; �������� �������� ������ �� ������ ������� �������� ��������
	mov [Temp], ebx; ���������� ��� �� ��������� ����������
	push 0x413917
	ret
endp

proc PatchDword4_17_20
	mov eax, [Temp]
	ret
endp

proc PatchDword5
	mov ecx, [ebp+0x18]
	mov [Temp], ecx
	lea ecx, [0x83EE58]
	push 0x713443
	ret
endp

proc PatchDword6
	mov edx, [ebp-8]
	mov [Temp], edx
	mov al, [ebp-4]
	push 0x5033B7
	ret
endp

proc DisableMessage0
	pushad
	lea ecx, [ebx+4]; �������� �� ������ ������� � ���������
	mov edx, [0x6747B0]; �������� ����� ������� ��������
	add edx, 4; �������� �� ������ ��������
	xor esi, esi; �������� ������� ������
.Loop_Slots:
	mov eax, [ecx]; �������� ����� ��������
	test eax, eax; ��������� �� ���������� ��������
	jl .Increment
	imul eax, 116; �������� �� ������ ���������
	mov eax, [eax+edx]; �������� ������� ��������
	test eax, eax; 1-�� (0-��) �� �������?
	jnz .Increment; ���� �������� �� ������� ������, �� ������
	lea eax, [ebx+20]; �������� �� ���-�� ������� (������ ������ - word)
	cmp word [esi*2+eax], 0; ��������� ����������
	jg .Level_0; ���� ���-�� ������ ����, ��� ������� ��������������, ���������� �� ����
.Increment:
	add ecx, 4; ��������� ����
	inc esi; ��������� �������
	cmp esi, 4
	jl .Loop_Slots
	popad
	add esp, 0x28; ��������� ������ �������
	mov eax, 0x716E02
	call eax; ��������������� ������
	push 0x4A1917; ������ � ����� �������� �� "��"
	ret
.Level_0:
	popad
	mov eax, 0x4F6C00
	call eax; �������� ���������-������
	push 0x4A1904; � ��������� � �������� ���
	ret
endp

proc DisableMessage1
	mov byte [ebp+0x13], 1; ��� �������������
	retn 0x28
endp

proc DisableMessage2
	add esp, 0x28
	mov eax, 0x716E02
	call eax; ��������������� ������
	push 0x4AA2F5
	ret
endp

proc FramesDwellings
	pushad; ��������� ��������
	movzx eax, byte [ecx+edi+0x56]; �������� �������
	push eax
	movzx eax, byte [ecx+edi+0x55]; �������� ���������� y
	push eax
	movzx eax, byte [ecx+edi+0x54]; �������� ���������� x
	push eax
	mov eax, 0x711E7F; MixedPos
	call eax
	push eax
	mov eax, 0x7112C3; �������� ����� ��������� ������� �� ��� �����������
	call eax
	add esp, 0x0C+4; ��� ����� �������
	movzx edx, word [eax+0x22]; �������� �������� ������
	mov [Temp], edx; ����� ��� �� ��������� ����������
	popad; ����������� ��������
	mov edx, [Temp]; �������� ������ �� ��������� ����������
	cmp byte [ecx+edi], 20; ��������� ������ �� ��� 20
	jnz .Type_17
	mov esi, [NumberOfFrames17]; �������� ���-�� ������ ���������� ���� 17
	add edx, esi; �������� � ������ �����, ��������������� ��� ��������� ���� 20
.Type_17:
	test eax, eax
	ret
endp

proc HintFrameDwellings
	cmp eax, [NumberOfFrames17]
	jge .Limit
	push 0x521A84
	ret
.Limit:
	push 0x521AC1
	ret
endp

proc FrameLighthouse
	mov ecx, [0x520D1D]
	cmp [eax], ecx
	je .YES
	push 0x520CEE
	ret
.YES:
	push 0x520CF8
	ret
endp

proc FrameGarrison
	mov ecx, [0x520EFF]
	cmp [eax], ecx
	je .YES
	push 0x520ED4
	ret
.YES:
	push 0x520EDE
	ret
endp

proc FrameAntimagicGarrison
	mov ecx, [0x520F58]
	cmp [eax], ecx
	je .YES
	push 0x520F31
	ret
.YES:
	push 0x520F3B
	ret
endp

proc FrameAbandonedMine
	mov ecx, [0x520CAA]
	cmp [eax], ecx
	je .YES
	push 0x520C7B
	ret
.YES:
	push 0x520C85
	ret
endp

proc FrameShipyard
	mov ecx, [0x52103D]
	cmp [eax], ecx
	je .YES
	push 0x520FFE
	ret
.YES:
	push 0x521008
	ret
endp


proc SaveParam
; ���������� ����� ���������� ����������
       mov eax, [699538h]
       mov edi, [eax+4E39Ch]
    .if edi
       add edi, 4
       mov esi, [eax+4E3A0h]
    @@:
       push 16 edi
       mov eax, 704062h
       call eax
       add esp, 8
       add edi, 5Ch
       cmp edi, esi
       jl @b
   .endif
       push 3E80h
       push 760EE7h
       ret
endp

proc LoadParam
; �������� ����� ���������� ����������
       mov eax, [699538h]
       mov edi, [eax+4E39Ch]
.if edi
       add edi, 4
       mov esi, [eax+4E3A0h]
    @@:
       push 16 edi
       mov eax, 7040A7h
       call eax
       add esp, 8
       add edi, 5Ch
       cmp edi, esi
       jl @b
.endif
       push 3E80h
       push 761493h
       ret
endp

section '.idata' data readable
data import
; ������������� ���������
  library kernel32,'kernel32.dll'

  import kernel32,\
	 CreateFileA,'CreateFileA'
end data

section '.data' data readable writeable

Table_Hooks:
; �������� ���������:
Hook 0x4EDED0, MAINDWELLINGS, TJump
; ��������� ��� ������������� ��������� ������� ��������� �� ����� ��������� �������� �� ����� (��� ������ - word):
; ��������� ������� �� ��������� ���������� ��� ������ �����:
Hook 0x4FF3F5, PatchDword1, TJump
; ��������� ������� �� ��������� ���������� ����� ���������� ���������� � ������:
Hook 0x4B859A, PatchDword2, TJump
; ������������� ��������� ������� ��� ��������� ��� ��������� ����:
Hook 0x40B151, PatchDword3, TJump; ����������� ��������� ������� � Temp
Hook 0x40B504, PatchDword3_17, TJump; #17
Hook 0x40B546, PatchDword3_20, TJump; #20
; ������������� ��������� ������� ��� ��������� �� ���:
Hook 0x413912, PatchDword4, TJump; ����������� ��������� ������� � Temp
Hook 0x413E59, PatchDword4_17_20, TCall; #17
Hook 0x413E9F, PatchDword4_17_20, TCall; #20
; ERM:
; ��������� ������� �� ��������� ���������� ����� ���������� ��������� �� �����:
Hook 0x71343D, PatchDword5, TJump
; ��������� ������� �� ��������� ���������� ����� ���������� ��������� ���������� ����:
Hook 0x5033B1, PatchDword6, TJump
; ���������� ���������:
Hook 0x4A18FF, DisableMessage0, TJump; � ����������: ������ ������ � ����� ��� ������� � ������� ����� 1-��
Hook 0x4AB982, DisableMessage1, TCall; � ����������: ������ ��������� ��������� �� ���������� ��������
Hook 0x4AA2DE, DisableMessage2, TJump; ������ ���������-������ � ������� ������� �������
; ����� ZLAGPORT.DEF:
; ����� ����������:
Hook 0x520DB3, FramesDwellings, TCall; �������� ���-��� �� ����
Hook 0x521A7F, HintFrameDwellings, TJump; ������ ������������ ���������
; ���� �����:
Hook 0x520CE9, FrameLighthouse, TJump
; ���� ���������:
Hook 0x520ECF, FrameGarrison, TJump
; ���� ��������������� ���������:
Hook 0x520F2C, FrameAntimagicGarrison, TJump
; ���� ����������� �����:
Hook 0x520C76, FrameAbandonedMine, TJump
; ���� �����:
Hook 0x520FF9, FrameShipyard, TJump
; ���������� � �������� ����������
Hook 760EE2h, SaveParam, TJump; ���������� ������
Hook 76148Eh, LoadParam, TJump; �������� ������
End_Table_Hooks = $

TXT_name db 'DwTable.txt', 0

; Virtual Data
Temp dd ?
NumberOfFrames17 dd ?
NumberOfFrames20 dd ?
; ������ ��� ������ �� ������ ����������� � ��� ������ ������� ����������
DwellingsTable rd 48000

section '.rsrc' data readable resource
  directory RT_VERSION,versions

  resource versions,\
	   1,LANG_NEUTRAL,version

  versioninfo version,VOS__WINDOWS32,VFT_DLL,VFT2_UNKNOWN,LANG_ENGLISH+SUBLANG_DEFAULT,0,\
	      'FileDescription','Dwellings.dll',\
	      'LegalCopyright','Copyright � 2017 the Master.',\
	      'FileVersion','2.0',\
	      'ProductVersion','Typhon'

section '.reloc' data readable discardable fixups
section '.bss' readable writeable
db 1 dup 0