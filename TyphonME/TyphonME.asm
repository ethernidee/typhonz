; TyphonME (Typhon library for Map Editor)
; Copyright © 2018, the Master
; All rights reserved.

; FORMAT
format PE GUI 4.0 DLL at 0
entry TYPHON

; Extendedheaders
 include '../../include/win32ax.inc'

; макросы для структур
macro Word x {x dw ?}
macro Dword x {x dd ?}
macro Byte x {x db ?}
macro Char x, size {x db size dup (?)}
macro Pword x {x dp ?}

struct _Creature_
       Dword Город		   ; 00
       Dword Уровень		   ; 04
       Dword Озвучка		   ; 08
       Dword Боевой_деф 	   ; 0C
       Dword Флаги		   ; 10
       Dword Название_ед_ч	   ; 14
       Dword Название_мн_ч	   ; 18
       Dword Описание		   ; 1C
       Dword Цена_в_дереве	   ; 20
       Dword Цена_в_ртути	   ; 24
       Dword Цена_в_камнях	   ; 28
       Dword Цена_в_сере	   ; 2C
       Dword Цена_в_кристаллах	   ; 30
       Dword Цена_в_драг_камнях    ; 34
       Dword Цена_в_золоте	   ; 38
       Dword Fight_Value	   ; 3C
       Dword AI_Value		   ; 40
       Dword Прирост		   ; 44
       Dword Доп_прирост	   ; 48
       Dword Здоровье		   ; 4C
       Dword Скорость		   ; 50
       Dword Атака		   ; 54
       Dword Защита		   ; 58
       Dword Мин_урон		   ; 5C
       Dword Макс_урон		   ; 60
       Dword Боезапас		   ; 64
       Dword Заклинания 	   ; 68
       Dword Мин_кол_во_на_карте   ; 6C
       Dword Макс_кол_во_на_карте  ; 70
ends

; Code section
section '.code' code readable executable

rd 500; для антивирусов

proc TYPHON
       push Temp PAGE_READWRITE 12F000h 401000h
       call [VirtualProtect]
       mov byte [40C907h], 0E9h; Хук
       mov dword [40C908h], LoadCreatures-(40C907h+5)
       mov byte [49F761h], 0E9h; Хук
       mov dword [49F762h], CheckBan1-(49F761h+5)
       mov byte [4A0C86h], 0E9h; Хук
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
	call Загрузка_файла
	mov edi, eax; получить адрес буфера
	mov ebx, [582298h]; адрес таблицы монстров
	xor esi, esi; обнулить счётчик монстров
.Цикл_первых_пяти_параметров:
; установить флаги
	push dword [esi * 4 + edi + 16000 + 5000]
	pop dword [ebx + 16]; установить флаги
; Установить уровень    
	movsx eax, byte [esi + edi + 16000 + 5000 + 4000] 
	mov [ebx + 4], eax; установить
; Установить город      
	movsx eax, byte [esi + edi + 16000 + 5000 + 4000 + 1000] 
	mov [ebx], eax; установить
; копирование параметров таблицы монстров - начиная Цена_в_дереве, заканчивая Макс_кол_во_на_карте
	push 84; кол-во байт для копирования
	lea eax, [ebx + _Creature_.Цена_в_дереве]
	push eax; приёмник
	imul eax, esi, 84
	lea eax, [eax + edi + 85000]; смещение в файле
	push eax
	call Копирование_памяти
	add ebx, 74h
	inc esi
	cmp esi, 1000
	jl .Цикл_первых_пяти_параметров
	push 1000
	push BanTable
	lea eax, [edi+83000]
	push eax
	call Копирование_памяти
; установить имя, множественное имя и описание:
	push Lang
	call Загрузка_файла
	movzx ebx, byte [eax]; получить значение языка
	mov ecx, eax
	call MemFree
	stdcall Загрузка_файла, dword [ebx*4+_Имена]
	enter 6*4, 0
	mov [ebp-4], eax
	stdcall lfcnt, eax; сосчитать строки в файле имен монстров      
	dec eax; так как первая строка - "нет апгрейда", то их как бы меньше
	mov [ebp-8], eax; временная переменная
	stdcall Загрузка_файла, dword [ebx*4+_Мн_имена]
	mov [ebp-12], eax
	stdcall Загрузка_файла, dword [ebx*4+_Способности]
	mov [ebp-16], eax
; начинаем цикл обработки строк
	xor edi, edi; rpos для строк имён монстров      
	stdcall linein, dword [ebp-4], edi; для первой строки
	mov edi, eax
	mov dword [ebp-20],0; rpos для строк множественных имён монстров
	mov dword [ebp-24], 0
	xor esi, esi; обнулить счётчик монстров
	mov ebx, [582298h]; адрес таблицы монстров
	add ebx, _Creature_.Название_ед_ч
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
	cmp esi, [ebp-8]; сравнить кол-во строк с количеством монстров
	jl @b
	leave
	popad
	mov al, 1
	ret

Загрузка_файла:
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

Копирование_памяти:
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

_Имена:       dd _Имена_eng, _Имена_rus
_Мн_имена:    dd _Мн_имена_eng, _Мн_имена_rus
_Способности: dd _Способности_eng, _Способности_rus
_Имена_eng	 db '"..\..\EraPlugins\MCrEdit\eng\Monsters.txt', 0
_Имена_rus	 db '"..\..\EraPlugins\MCrEdit\rus\Monsters.txt', 0
_Мн_имена_eng	 db '"..\..\EraPlugins\MCrEdit\eng\Plural.txt', 0
_Мн_имена_rus	 db '"..\..\EraPlugins\MCrEdit\rus\Plural.txt', 0
_Способности_eng db '"..\..\EraPlugins\MCrEdit\eng\Ability.txt', 0
_Способности_rus db '"..\..\EraPlugins\MCrEdit\rus\Ability.txt', 0
MonstersSetup_mop db '"..\..\EraPlugins\MCrEdit\MonstersSetup.mop', 0
Lang db '"..\..\EraPlugins\MCrEdit\Lang', 0

Temp dd ?
BanTable rb 1000

section '.bss' writeable
db 1 dup 0

section '.idata' data readable
data import
; Импортируемые процедуры
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
	      'LegalCopyright','Copyright © 2018 the Master.',\
	      'FileVersion','2.2',\
	      'ProductVersion','Typhon library for Map Editor.'

section '.reloc' data readable discardable fixups