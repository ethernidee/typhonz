; Project Typhon (for gnom)
; Copyright © 2017-2019, the Master
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

; Количество существ в игре
MonNum = 1000

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

struct _Dwelling_
       Byte  тип
       Byte  подтип
       db ?
       db ?
       Dword тип_монстров_в_слоте_0
       Dword тип_монстров_в_слоте_1
       Dword тип_монстров_в_слоте_2
       Dword тип_монстров_в_слоте_3
       Word  кол_во_монстров_в_слоте_0
       Word  кол_во_монстров_в_слоте_1
       Word  кол_во_монстров_в_слоте_2
       Word  кол_во_монстров_в_слоте_3
       Dword тип_охранников_в_слоте_0
       Dword тип_охранников_в_слоте_1
       Dword тип_охранников_в_слоте_2
       Dword тип_охранников_в_слоте_3
       Dword тип_охранников_в_слоте_4
       Dword тип_охранников_в_слоте_5
       Dword тип_охранников_в_слоте_6
       Dword количество_охранников_в_слоте_0
       Dword количество_охранников_в_слоте_1
       Dword количество_охранников_в_слоте_2
       Dword количество_охранников_в_слоте_3
       Dword количество_охранников_в_слоте_4
       Dword количество_охранников_в_слоте_5
       Dword количество_охранников_в_слоте_6
       Byte  X_координата
       Byte  Y_координата
       Byte  L_координата
       Byte  хозяин
       db ?, ?, ?, ?
ends

struct Структура_стека
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
	Тип_существа dd ?;                                                   34
	Позиция dd ?;                                                        38
	dd ?
	dd ?
	dd ?
	dd ?
	Текущее_количество dd ?;                                             4C
	dd ?
	dd ?
	Потерянное_здоровье dd ?;                                            58 - потери здоровья последнего монстра
	dd ?
	Количество_в_начале_битвы dd ?;                                      60
	dd ?
	dd ?
	Полное_Здоровье dd ?;                                                6C - полное здоровье (исп. как база для лечения)
	dd ?
	dd ?
	dd ?
	dd ?
	dd ?
	Флаги dd ?;                                                          84
	Имя_ед_ч dd ?;                                                       88
	Имя_мн_ч dd ?;                                                       8C
	Описание_способностей dd ?;                                          90
	Цена_в_дереве dd ?;                                                  94
	Цена_в_ртути dd ?;                                                   98
	Цена_в_камнях dd ?;                                                  9C
	Цена_в_сере dd ?;                                                    A0
	Цена_в_кристаллах dd ?;                                              A4
	Цена_в_драг_камнях dd ?;                                             A8
	Цена_в_золоте dd ?;                                                  AC
	Fight_Value dd ?;                                                    B0
	AI_Value dd ?;                                                       B4
	Прирост dd ?;                                                        B8
	Доп_прирост dd ?;                                                    BC
	Максимальное_здоровье dd ?;                                          C0
	Скорость dd ?;                                                       C4
	Атака dd ?;                                                          C8
	Защита dd ?;                                                         CC
	dd ?,?
	Количество_боеприпасов dd ?;                                         D8
	Количество_магических_зарядов dd ?;                                  DC
	dd ?,?,?
	dd ?,?
	Принадлежность dd ?;                                                 F4
	Номер_стека dd ?;                                                    F8
	dd ?;                                                                FC
	dd ?;                                                                100
	dd ?;                                                                104
	dd ?;                                                                108
	dd ?;                                                                10C
	CrAnim db 84 dup (?);                                                110
	dd ?,?,?,?,?,?,?,?,?,?,?,?
	Количество_наложенных_заклинаний dd ?;                               194
	Длительность_заклинаний dd 81 dup (?);                             198
	Сила_заклинаний dd 81 dup (?);                                     2DC
	dd ?;                                                                420
	dd ?,?,?,?,?,?,?
	dd ?
	dd ?
	dd ?
	dd ?
	dd ?
	Контрудары dd ?;                                                     454
	Бонус_Благословления dd ?;                                           458
	Бонус_Проклятия dd ?;                                                45C
	Параметр_Антимагии dd ?;                                             460
	Бонус_Кровожадности dd ?;                                            464
	Бонус_Точности dd ?;                                                 468
	dd ?;                                                                46C
	dd ?;                                                                470
	dd ?;                                                                474
	Бонус_Молитвы dd ?;                                                  478
	Бонус_Радости dd ?;                                                  47C
	Бонус_Печали dd ?;                                                   480
	Бонус_Удачи dd ?;                                                    484
	Бонус_Неудачи dd ?;                                                  488
	dd ?;                                                                48C
	dd ?;                                                                490
	Бонус_контрударов_от_заклинания dd ?;                                494
	Бонус_Бешенства dd ?;                                                498
	dd ?;                                                                49C
	Бонус_Огненного_Щита dd ?;                                           4A0
	Бонус_Яда dd ?;                                                      4A4
	Бонус_Защиты_от_Воздуха dd ?;                                        4A8
	Бонус_Защиты_от_Огня dd ?;                                           4AC
	Бонус_Защиты_от_Воды dd ?;                                           4B0
	Бонус_Защиты_от_Земли dd ?;                                          4B4
	Бонус_Щита dd ?;                                                     4B8
	Бонус_Воздушного_Щита dd ?;                                          4BC
	dd ?;                                                                4C0
	Бонус_Забывчивости dd ?;                                             4С4
	Бонус_Медлительности dd ?;                                           4C8
	Бонус_Ускорения dd ?;                                                4CC
	dd ?
	dd ?
	dd ?
	dd ?
	Текущее_заклинание dd ?;                                             4E0 - то, что будет колдовать монстр
	dd ?
	Мораль dd ?;                                                         4E8
	Удача dd ?;                                                          4EC
	db 88 dup (?)
ends

; Code section
section '.code' code readable executable

rd 500; для антивирусов

_OnAfterWoG           db 'OnAfterWoG', 0
_OnCustomDialogEvent  db 'OnCustomDialogEvent', 0
_OnBeforeBattleAction db 'OnBeforeBattleAction', 0
_OnAfterBattleAction  db 'OnAfterBattleAction', 0

DLL_PROCESS_ATTACH = 1

match =FALSE, COPYMODE
{
proc TYPHON, hDll, Reason, Reserved
  ; только при подключении dll к процессу, не к потокам
  .if dword [Reason] = DLL_PROCESS_ATTACH
    ; регистрируем обработчики событий
    stdcall [RegisterHandler], OnAfterWoG,           _OnAfterWoG
    stdcall [RegisterHandler], OnCustomDialogEvent,  _OnCustomDialogEvent
    stdcall [RegisterHandler], OnBeforeBattleAction, _OnBeforeBattleAction
    stdcall [RegisterHandler], OnAfterBattleAction,  _OnAfterBattleAction
    
    mov dword [761381h], 39859587; Заглушить вог-функцию ResetMonTable,
    mov dword [761385h], 3271623302; мешающую редактору существ
    mov dword [71180Fh+1], LoadCreatures
  .endif
  
  ; возвращаем успех инициализации dll
  xor eax, eax
  inc eax
  ret
endp
}

match =TRUE, COPYMODE
{
proc TYPHON
; Хук AfterWoG
    mov byte [50CBE4h], 0E9h; Хук
    mov dword [50CBE5h], CopyCrTable-(50CBE4h+5); AfterWog
    xor eax, eax
    inc eax
    ret 0Ch
endp
}


 include 'functions.asm'

section '.data' data readable writeable
 include 'Data.ASM'
 include 'Virtual.asm'; переменные

section '.bss' writeable
db 1 dup 0

section '.idata' data readable
data import
; Импортируемые процедуры
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
	      'LegalCopyright','Copyright © 2017-2020 the Master & co.',\
	      'FileVersion','1.0.0',\
	      'ProductVersion','TyphonZ'

section '.reloc' data readable discardable fixups