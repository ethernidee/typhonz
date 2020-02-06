; TyphonME (Typhon library for Map Editor)
; Copyright � 2018, the Master
; All rights reserved.

; FORMAT
format PE GUI 4.0 DLL at 0
entry TYPHON

; Extendedheaders
 include '../../include/win32ax.inc'

; ������� ��� ��������
macro Word x {x dw ?}
macro Dword x {x dd ?}
macro Byte x {x db ?}
macro Char x, size {x db size dup (?)}
macro Pword x {x dp ?}

struct _Creature_
       Dword �����		   ; 00
       Dword �������		   ; 04
       Dword �������		   ; 08
       Dword ������_��� 	   ; 0C
       Dword �����		   ; 10
       Dword ��������_��_�	   ; 14
       Dword ��������_��_�	   ; 18
       Dword ��������		   ; 1C
       Dword ����_�_������	   ; 20
       Dword ����_�_�����	   ; 24
       Dword ����_�_������	   ; 28
       Dword ����_�_����	   ; 2C
       Dword ����_�_����������	   ; 30
       Dword ����_�_����_������    ; 34
       Dword ����_�_������	   ; 38
       Dword Fight_Value	   ; 3C
       Dword AI_Value		   ; 40
       Dword �������		   ; 44
       Dword ���_�������	   ; 48
       Dword ��������		   ; 4C
       Dword ��������		   ; 50
       Dword �����		   ; 54
       Dword ������		   ; 58
       Dword ���_����		   ; 5C
       Dword ����_����		   ; 60
       Dword ��������		   ; 64
       Dword ���������� 	   ; 68
       Dword ���_���_��_��_�����   ; 6C
       Dword ����_���_��_��_�����  ; 70
ends

; Code section
section '.code' code readable executable

rd 500; ��� �����������

proc TYPHON
       push Temp PAGE_READWRITE 12F000h 401000h
       call [VirtualProtect]
       mov byte [40C907h], 0E9h; ���
       mov dword [40C908h], LoadCreatures-(40C907h+5)
       mov byte [49F761h], 0E9h; ���
       mov dword [49F762h], CheckBan1-(49F761h+5)
       mov byte [4A0C86h], 0E9h; ���
       mov dword [4A0C87h], CheckBan2-(4A0C86h+5)
       push 0 [Temp] 12F000h 401000h
       call [VirtualProtect]
       xor eax, eax
       inc eax
       ret 0Ch
endp

CheckBan1:
       cmp byte [esi+BanTable], 0
       jnz @f
       mov ecx, [582298h]
       push 49F767h
       ret
     @@:
       push 49F799h
       ret

CheckBan2:
       cmp byte [esi+BanTable], 0
       jnz @f
       mov ecx, [582298h]
       push 4A0C8Ch
       ret
     @@:
       push 4A0CD0h
       ret

LoadCreatures:
	pushad
	push MonstersSetup_mop
	call ��������_�����
	mov edi, eax; �������� ����� ������
	mov ebx, [582298h]; ����� ������� ��������
	xor esi, esi; �������� ������� ��������
.����_������_����_����������:
; ���������� �����
	push dword [esi * 4 + edi + 16000 + 5000]
	pop dword [ebx + 16]; ���������� �����
; ���������� �������    
	movsx eax, byte [esi + edi + 16000 + 5000 + 4000] 
	mov [ebx + 4], eax; ����������
; ���������� �����      
	movsx eax, byte [esi + edi + 16000 + 5000 + 4000 + 1000] 
	mov [ebx], eax; ����������
; ����������� ���������� ������� �������� - ������� ����_�_������, ���������� ����_���_��_��_�����
	push 84; ���-�� ���� ��� �����������
	lea eax, [ebx + _Creature_.����_�_������]
	push eax; �������
	imul eax, esi, 84
	lea eax, [eax + edi + 85000]; �������� � �����
	push eax
	call �����������_������
	add ebx, 74h
	inc esi
	cmp esi, 1000
	jl .����_������_����_����������
	push 1000
	push BanTable
	lea eax, [edi+83000]
	push eax
	call �����������_������
; ���������� ���, ������������� ��� � ��������:
	push Lang
	call ��������_�����
	movzx ebx, byte [eax]; �������� �������� �����
	mov ecx, eax
	call MemFree
	stdcall ��������_�����, dword [ebx*4+_�����]
	enter 6*4, 0
	mov [ebp-4], eax
	stdcall lfcnt, eax; ��������� ������ � ����� ���� ��������      
	dec eax; ��� ��� ������ ������ - "��� ��������", �� �� ��� �� ������
	mov [ebp-8], eax; ��������� ����������
	stdcall ��������_�����, dword [ebx*4+_��_�����]
	mov [ebp-12], eax
	stdcall ��������_�����, dword [ebx*4+_�����������]
	mov [ebp-16], eax
; �������� ���� ��������� �����
	xor edi, edi; rpos ��� ����� ��� ��������      
	stdcall linein, dword [ebp-4], edi; ��� ������ ������
	mov edi, eax
	mov dword [ebp-20],0; rpos ��� ����� ������������� ��� ��������
	mov dword [ebp-24], 0
	xor esi, esi; �������� ������� ��������
	mov ebx, [582298h]; ����� ������� ��������
	add ebx, _Creature_.��������_��_�
@@:
	stdcall linein, dword [ebp-4], edi
	mov edi, eax
	mov [ebx], ecx
	stdcall linein, dword [ebp-12], dword [ebp-20]
	mov [ebp-20], eax
	mov [ebx+4], ecx
	stdcall linein, dword [ebp-16], dword [ebp-24]
	mov [ebp-24], eax
	mov [ebx+8], ecx
	add ebx, sizeof._Creature_
	inc esi
	cmp esi, [ebp-8]; �������� ���-�� ����� � ����������� ��������
	jl @b
	leave
	popad
	mov al, 1
	ret

��������_�����:
	push ebp
	mov ebp, esp
	push esi edi 0 80h 3 0 1 0C0000000h dword [ebp+8]
	call [CreateFileA]
	mov edi, eax
	push 0 edi
	call [GetFileSize]
	mov [ebp+8], eax
	mov ecx, eax
	call MemFree
	mov esi, eax
	push 0
	lea ecx, [ebp+8]
	push ecx dword [ebp+8] eax edi
	call [ReadFile]
	push edi
	call [CloseHandle]
	mov eax, esi
	pop edi esi ebp
	ret 4

MemFree:
	push esi
	mov esi, ecx
	push 4 1000h esi 0
	call [VirtualAlloc]
	push 4 1000h esi eax
	call [VirtualAlloc]
	pop esi
	ret

�����������_������:
	mov ecx, [esp+0Ch]
	push esi
	mov esi,[esp+08h]
	push edi
	mov edi,[esp+10h]
	mov eax, ecx
	shr ecx,02h
	rep movsd
	mov ecx, eax
	and ecx,00000003h
	rep movsb
	pop edi
	pop esi
	retn 0Ch

lfcnt:
    xor eax, eax ; set counter to zero
    mov ecx, [esp+4]
    sub ecx, 1
    jmp @f
  pre:
    add eax, 1		    ; add 1 to return value if LF found
  @@:
    add ecx, 1
    cmp byte [ecx], 0	; test for zero terminator
    je @f
    cmp byte [ecx], 10	; test line feed
    je pre
    jmp @b
  @@:
    retn 4

proc linein
	mov edx,[ESP+4]
	ADD EDX,[ESP+8]
	push edx
	XOR EAX,EAX
	or ECX,-1
L404268:	
	inc ecx
	mov al,byte [ECX+EDX]
	CMP AL,9
	JE L404268
	CMP AL,0Dh
	JA L404268
	MOV BYTE [ECX+EDX],0
	TEST EAX,EAX
	JE L404288
	LEA EAX,[ECX+2]
	ADD EAX,[ESP+12]
L404288:
	pop ecx
	RETN 8
endp

section '.data' data readable writeable

_�����:       dd _�����_eng, _�����_rus
_��_�����:    dd _��_�����_eng, _��_�����_rus
_�����������: dd _�����������_eng, _�����������_rus
_�����_eng	 db '"..\..\EraPlugins\MCrEdit\eng\Monsters.txt', 0
_�����_rus	 db '"..\..\EraPlugins\MCrEdit\rus\Monsters.txt', 0
_��_�����_eng	 db '"..\..\EraPlugins\MCrEdit\eng\Plural.txt', 0
_��_�����_rus	 db '"..\..\EraPlugins\MCrEdit\rus\Plural.txt', 0
_�����������_eng db '"..\..\EraPlugins\MCrEdit\eng\Ability.txt', 0
_�����������_rus db '"..\..\EraPlugins\MCrEdit\rus\Ability.txt', 0
MonstersSetup_mop db '"..\..\EraPlugins\MCrEdit\MonstersSetup.mop', 0
Lang db '"..\..\EraPlugins\MCrEdit\Lang', 0

Temp dd ?
BanTable rb 1000

section '.bss' writeable
db 1 dup 0

section '.idata' data readable
data import
; ������������� ���������
  library kernel32,'kernel32.dll'

  import kernel32,\
	 CreateFileA,'CreateFileA',\
	 GetFileSize, 'GetFileSize',\
	 VirtualAlloc, 'VirtualAlloc',\
	 ReadFile, 'ReadFile',\
	 CloseHandle, 'CloseHandle',\
	 VirtualFree, 'VirtualFree',\
	 VirtualProtect,'VirtualProtect'
end data

section '.rsrc' data readable resource
  directory RT_VERSION,versions

  resource versions,\
	   1,LANG_NEUTRAL,version

  versioninfo version,VOS__WINDOWS32,VFT_DLL,VFT2_UNKNOWN,LANG_ENGLISH+SUBLANG_DEFAULT,0,\
	      'FileDescription','Typhon_ME',\
	      'LegalCopyright','Copyright � 2018 the Master.',\
	      'FileVersion','2.2',\
	      'ProductVersion','Typhon library for Map Editor.'

section '.reloc' data readable discardable fixups