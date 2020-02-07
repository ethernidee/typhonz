; Project Typhon (for gnom)
; Copyright � 2017-2019, the Master
; All rights reserved.

define COPYMODE FALSE

; FORMAT
format PE GUI 4.0 DLL at 1000000h
entry TYPHON

; Extendedheaders
 include '../../include/win32ax.inc'

; HookType constants:
TJump = $E9
TCall = $E8

; ���������� ������� � ����
MonNum = 1000

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

struct _Dwelling_
       Byte  ���
       Byte  ������
       db ?
       db ?
       Dword ���_��������_�_�����_0
       Dword ���_��������_�_�����_1
       Dword ���_��������_�_�����_2
       Dword ���_��������_�_�����_3
       Word  ���_��_��������_�_�����_0
       Word  ���_��_��������_�_�����_1
       Word  ���_��_��������_�_�����_2
       Word  ���_��_��������_�_�����_3
       Dword ���_����������_�_�����_0
       Dword ���_����������_�_�����_1
       Dword ���_����������_�_�����_2
       Dword ���_����������_�_�����_3
       Dword ���_����������_�_�����_4
       Dword ���_����������_�_�����_5
       Dword ���_����������_�_�����_6
       Dword ����������_����������_�_�����_0
       Dword ����������_����������_�_�����_1
       Dword ����������_����������_�_�����_2
       Dword ����������_����������_�_�����_3
       Dword ����������_����������_�_�����_4
       Dword ����������_����������_�_�����_5
       Dword ����������_����������_�_�����_6
       Byte  X_����������
       Byte  Y_����������
       Byte  L_����������
       Byte  ������
       db ?, ?, ?, ?
ends

struct ���������_�����
	dd ?
	dd ?
	dd ?
	dd ?
	dd ?
	dd ?
	dd ?
	dd ?
	dd ?
	dd ?
	dd ?
	dd ?
	dd ?
	���_�������� dd ?;                                                   34
	������� dd ?;                                                        38
	dd ?
	dd ?
	dd ?
	dd ?
	�������_���������� dd ?;                                             4C
	dd ?
	dd ?
	����������_�������� dd ?;                                            58 - ������ �������� ���������� �������
	dd ?
	����������_�_������_����� dd ?;                                      60
	dd ?
	dd ?
	������_�������� dd ?;                                                6C - ������ �������� (���. ��� ���� ��� �������)
	dd ?
	dd ?
	dd ?
	dd ?
	dd ?
	����� dd ?;                                                          84
	���_��_� dd ?;                                                       88
	���_��_� dd ?;                                                       8C
	��������_������������ dd ?;                                          90
	����_�_������ dd ?;                                                  94
	����_�_����� dd ?;                                                   98
	����_�_������ dd ?;                                                  9C
	����_�_���� dd ?;                                                    A0
	����_�_���������� dd ?;                                              A4
	����_�_����_������ dd ?;                                             A8
	����_�_������ dd ?;                                                  AC
	Fight_Value dd ?;                                                    B0
	AI_Value dd ?;                                                       B4
	������� dd ?;                                                        B8
	���_������� dd ?;                                                    BC
	������������_�������� dd ?;                                          C0
	�������� dd ?;                                                       C4
	����� dd ?;                                                          C8
	������ dd ?;                                                         CC
	dd ?,?
	����������_����������� dd ?;                                         D8
	����������_����������_������� dd ?;                                  DC
	dd ?,?,?
	dd ?,?
	�������������� dd ?;                                                 F4
	�����_����� dd ?;                                                    F8
	dd ?;                                                                FC
	dd ?;                                                                100
	dd ?;                                                                104
	dd ?;                                                                108
	dd ?;                                                                10C
	CrAnim db 84 dup (?);                                                110
	dd ?,?,?,?,?,?,?,?,?,?,?,?
	����������_����������_���������� dd ?;                               194
	������������_���������� dd 81 dup (?);                             198
	����_���������� dd 81 dup (?);                                     2DC
	dd ?;                                                                420
	dd ?,?,?,?,?,?,?
	dd ?
	dd ?
	dd ?
	dd ?
	dd ?
	���������� dd ?;                                                     454
	�����_�������������� dd ?;                                           458
	�����_��������� dd ?;                                                45C
	��������_��������� dd ?;                                             460
	�����_������������� dd ?;                                            464
	�����_�������� dd ?;                                                 468
	dd ?;                                                                46C
	dd ?;                                                                470
	dd ?;                                                                474
	�����_������� dd ?;                                                  478
	�����_������� dd ?;                                                  47C
	�����_������ dd ?;                                                   480
	�����_����� dd ?;                                                    484
	�����_������� dd ?;                                                  488
	dd ?;                                                                48C
	dd ?;                                                                490
	�����_�����������_��_���������� dd ?;                                494
	�����_��������� dd ?;                                                498
	dd ?;                                                                49C
	�����_���������_���� dd ?;                                           4A0
	�����_��� dd ?;                                                      4A4
	�����_������_��_������� dd ?;                                        4A8
	�����_������_��_���� dd ?;                                           4AC
	�����_������_��_���� dd ?;                                           4B0
	�����_������_��_����� dd ?;                                          4B4
	�����_���� dd ?;                                                     4B8
	�����_����������_���� dd ?;                                          4BC
	dd ?;                                                                4C0
	�����_������������ dd ?;                                             4�4
	�����_�������������� dd ?;                                           4C8
	�����_��������� dd ?;                                                4CC
	dd ?
	dd ?
	dd ?
	dd ?
	�������_���������� dd ?;                                             4E0 - ��, ��� ����� ��������� ������
	dd ?
	������ dd ?;                                                         4E8
	����� dd ?;                                                          4EC
	db 88 dup (?)
ends

; Code section
section '.code' code readable executable

rd 500; ��� �����������

_OnAfterWoG           db 'OnAfterWoG', 0
_OnCustomDialogEvent  db 'OnCustomDialogEvent', 0
_OnBeforeBattleAction db 'OnBeforeBattleAction', 0
_OnAfterBattleAction  db 'OnAfterBattleAction', 0

DLL_PROCESS_ATTACH = 1

match =FALSE, COPYMODE
{
proc TYPHON, hDll, Reason, Reserved
  ; ������ ��� ����������� dll � ��������, �� � �������
  .if dword [Reason] = DLL_PROCESS_ATTACH
    ; ������������ ����������� �������
    stdcall [RegisterHandler], OnAfterWoG,           _OnAfterWoG
    stdcall [RegisterHandler], OnCustomDialogEvent,  _OnCustomDialogEvent
    stdcall [RegisterHandler], OnBeforeBattleAction, _OnBeforeBattleAction
    stdcall [RegisterHandler], OnAfterBattleAction,  _OnAfterBattleAction
    
    mov dword [761381h], 39859587; ��������� ���-������� ResetMonTable,
    mov dword [761385h], 3271623302; �������� ��������� �������
    mov dword [71180Fh+1], LoadCreatures
  .endif
  
  ; ���������� ����� ������������� dll
  xor eax, eax
  inc eax
  ret
endp
}

match =TRUE, COPYMODE
{
proc TYPHON
; ��� AfterWoG
    mov byte [50CBE4h], 0E9h; ���
    mov dword [50CBE5h], CopyCrTable-(50CBE4h+5); AfterWog
    xor eax, eax
    inc eax
    ret 0Ch
endp
}


 include 'functions.asm'

section '.data' data readable writeable
 include 'Data.ASM'
 include 'Virtual.asm'; ����������

section '.bss' writeable
db 1 dup 0

section '.idata' data readable
data import
; ������������� ���������
  library kernel32, 'kernel32.dll',\
    era, 'era.dll'

  import kernel32,\
	  CreateFileA,'CreateFileA',\
	  GetFileSize, 'GetFileSize',\
	  VirtualAlloc, 'VirtualAlloc',\
	  ReadFile, 'ReadFile',\
	  CloseHandle, 'CloseHandle',\
	  VirtualFree, 'VirtualFree',\
	  WriteFile, 'WriteFile'

  import era,\
    RegisterHandler, 'RegisterHandler',\
    RedirectMemoryBlock, 'RedirectMemoryBlock'

end data

section '.rsrc' data readable resource
  directory RT_VERSION,versions

  resource versions,\
	   1,LANG_NEUTRAL,version

  versioninfo version,VOS__WINDOWS32,VFT_DLL,VFT2_UNKNOWN,LANG_ENGLISH+SUBLANG_DEFAULT,0,\
	      'FileDescription','TyphonZ project',\
	      'LegalCopyright','Copyright � 2017-2020 the Master & co.',\
	      'FileVersion','1.0.0',\
	      'ProductVersion','TyphonZ'

section '.reloc' data readable discardable fixups