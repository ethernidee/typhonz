; Dwellings.dll
; Copyright © 2017, the Master
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
; ставим хуки
	mov esi, Table_Hooks
.LoopHooks:
	mov al, [esi+8]
	mov ecx, [esi+4];
	mov edx, [esi]; ориг
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
	jnz @f; файл успешно загружен
.ERROR:
	push 0x4EE006
	ret
@@:
; Патчим указатели на названия двеллингов типа 17 адресом буфера:
	mov eax, DwellingsTable+4
	mov [0x40B521], eax
	mov [0x413E78], eax
	mov [0x4A1553], eax
	mov [0x40B517], eax
	mov [0x413E6D], eax
	lea edi, [eax+4004]; смещение до ссылок на номера существ в виде текста
	lea ebx, [edi+4000]; смещение до свободного места = таблицы обитателей
; патчим указатели на таблицу обитателей двеллингов типа 17:
	mov [0x418754], ebx
	mov [0x4B85A3], ebx
	mov [0x5032D8], ebx
	mov [0x521A87], ebx
	mov [0x534CEA], ebx
	mov esi, 1000; счётчик
; Конвертация строк в числа и запись последних в таблицу обитателей двеллингов типа 17
@@:
	push dword [edi]
	mov eax, 0x77D3D7
	call eax; вызываем вог-функцию преобразования текста в число
	pop ecx
	mov [ebx], eax; записываем номер существа в таблицу обитателей
	add ebx, 4
	add edi, 4
	dec esi
	jnz @b
; Патчим указатели на названия двеллингов типа 20:
	add ebx, 4
	mov [0x40B559], ebx
	mov [0x40B579], ebx
	mov [0x413EB3], ebx
	mov [0x413ED3], ebx
	mov [0x4A155F], ebx
; Конвертация строк в числа и запись последних в таблицу обитателей двеллингов типа 20
	lea edi, [ebx+4004]; смещение до ссылок на номера существ в виде текста
	lea ebx, [ebx+20016]; смещение до таблицы обитателей
	mov [0x4B85B7], ebx; патчим указатель на таблицу обитателей двеллингов #20
	mov esi, 1000; счётчик
@@:
	push dword [edi]; существо 1
	mov eax, 0x77D3D7
	call eax; вызываем вог-функцию преобразования текста в число
	mov [ebx], eax
	push dword [edi+4004]; существо 2
	mov eax, 0x77D3D7
	call eax; вызываем вог-функцию преобразования текста в число
	mov [ebx+4], eax
	push dword [edi+8008]; существо 3
	mov eax, 0x77D3D7
	call eax; вызываем вог-функцию преобразования текста в число
	mov [ebx+8], eax
	push dword [edi+12012]; существо 4
	mov eax, 0x77D3D7
	call eax; вызываем вог-функцию преобразования текста в число
	mov [ebx+12], eax
	add esp, 4*4; за все вызовы
	add ebx, 4*4
	add edi, 4
	dec esi
	jnz @b
; Конвертация ссылок на кол-во кадров zlagport.def для двеллингов в числа (из переменных в те же переменные)
	push dword [NumberOfFrames17]
	mov eax, 0x77D3D7
	call eax; вызываем вог-функцию преобразования текста в число
	pop ecx
	mov [NumberOfFrames17], eax
	push dword [NumberOfFrames20]
	mov eax, 0x77D3D7
	call eax; вызываем вог-функцию преобразования текста в число
	pop ecx
	mov [NumberOfFrames20], EAX
	mov dword [0x5032BC], 999; пропатчить номером последнего обитаемого двеллинга (для генерации в случайном жилище). Всё равно Жилище не будет браться в расчёт, если в нём нет обитателей
	mov dword [0x5032C8], DwellingsTable+12004; адрес, с которого начинается сканирование (последний обитатель двеллинга 17, ибо сканирование идёт задом наперёд)
; номера кадров для остальных типов объектов:
; Маяк
	add eax, [NumberOfFrames17]; суммарное кол-во кадров двеллингов = кадр Маяка
	mov [0x520D1D], eax; и сразу пропатчить место, где используется номер кадра в виде двойного слова (во избежание лишней процедуры)
; Гарнизон (обычный)
	inc eax; увеличиваем на 1
	mov [0x520EFF], eax; пропатчить
; Гарнизон (антимагический)
	inc eax; увеличиваем на 1
	mov [0x520F58], eax; пропатчить
; Заброшенная Шахта
	inc eax; увеличиваем на 1
	mov [0x520CAA], eax; пропатчить
; Примечание: дубликат кадра Cопряжения в zlagport.def, скорее всего, не используется, однако, оставлен. Поэтому для номера кадра Верфи EBX увеличиваем на 2.
; Верфь
	add eax, 2; увеличиваем на 2. Если не используем дубликат кадра Сопряжения, то лучше заменить на INC EBX
	mov [0x52103D], eax; пропатчить
	mov dword [0x539C77], 1000; кол-во двеллингов для генерации на случайной карте
	push 0x4EDED6
	ret
endp

; Функция загрузки текстовика
proc DWTABLE
	mov ecx, TXT_name; название текстовика
	mov eax, 0x55C2B0
	call eax
	test eax, eax
	jnz @f; прыжок на загрузку строк текстовика в случае успешной загрузки
	xor al, al; инициализирует неудачную загрузку
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
	mov [esi+DwellingsTable], ecx; колонка 1
	add esi, 4
	cmp esi, 4004
	JL @b
	xor esi, esi
@@:
	mov ecx, [eax+0x20]
	mov ecx, [ecx+esi]
	mov edx, [ecx+4]
	mov ecx, [edx+4]
	mov [esi+DwellingsTable+4004], ecx; колонка 2
	add esi, 4
	cmp esi, 4004
	JL @b
; Загрузка пяти колонок для двеллингов типа 20
	mov ebx, DwellingsTable+8004; загрузить адрес буфера + смещение до таблицы обитателей двеллингов типа 17 -> занести адрес во временную переменную
	xor edi, edi
.LoopFiveColumns: ;внешний цикл
	add ebx, 4004; добавить смещение
	xor esi, esi
@@:; внутренний цикл (счётчик - ESI)
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
; загрузка ссылок на строки комментариев, где содержатся числа кадров в zlagport.def
	mov edx, [eax+0x20]
	mov ecx, [edx]
	mov edx, [ecx+4]
	mov ecx, edx
	mov edx, [ecx+8]; колонка 3 (тип 17)
	mov [NumberOfFrames17], edx
	mov edx, [ecx+32]; колонка 9 (тип 20)
	mov [NumberOfFrames20], edx
	mov al, 1; инициализирует успешную загрузку
	pop edi esi ebx
	ret
endp

proc PatchDword1
	mov ecx, [edx+ecx*4+0x3C]; получить подтип двеллинга в размере dword
	mov [Temp], ecx; занести подтип во временную переменную
	mov [ebp-0x67], cl; оригинальный подтип в размере 1 байт, который дальше по коду помещается в структуру объекта
	push 0x4FF3FC; возврат в код
	ret
endp

proc PatchDword2
	jnz .DwellingType20
	mov eax, [Temp]; получить подтип из временной переменной
	push 0x4B85A0
	ret
.DwellingType20:
	mov ecx, [Temp]
	push 0x4B85B2
	ret
endp

proc PatchDword3
	mov eax, 0x74E007; выполнение затёртого вог-хука
	call eax
	movzx ebx, word [eax+0x22]; получаем реальный подтип из общего массива структур объектов
	mov [Temp], ebx; записываем его во временную переменную
	push 0x40B156
	ret
endp

proc PatchDword3_17
	mov eax, [Temp]
	cmp ecx, -1; затёртый код
	push 0x40B50B
	ret
endp

proc PatchDword3_20
	mov eax, [Temp]
	cmp ecx, -1; затёртый код
	push 0x40B54D
	ret
endp

proc PatchDword4
	mov eax, 0x40AF10
	call eax
	movzx ebx, word [eax+0x22]; получаем реальный подтип из общего массива структур объектов
	mov [Temp], ebx; записываем его во временную переменную
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
	lea ecx, [ebx+4]; смещение до слотов существ в двеллинге
	mov edx, [0x6747B0]; получить адрес таблицы монстров
	add edx, 4; смещение до уровня существа
	xor esi, esi; обнулить счётчик слотов
.Loop_Slots:
	mov eax, [ecx]; получить номер существа
	test eax, eax; проверяем на отсутствие существа
	jl .Increment
	imul eax, 116; умножить на размер структуры
	mov eax, [eax+edx]; получить уровень существа
	test eax, eax; 1-ый (0-ой) ли уровень?
	jnz .Increment; если существо не первого уровня, то дальше
	lea eax, [ebx+20]; смещение до кол-ва существ (размер данных - word)
	cmp word [esi*2+eax], 0; проверяем количество
	jg .Level_0; если кол-во больше нуля, они захотят присоединиться, спрашиваем об этом
.Increment:
	add ecx, 4; следующий слот
	inc esi; увеличить счётчик
	cmp esi, 4
	jl .Loop_Slots
	popad
	add esp, 0x28; затирание вызова функции
	mov eax, 0x716E02
	call eax; восстанавливаем курсор
	push 0x4A1917; прыжок в обход проверки на "ОК"
	ret
.Level_0:
	popad
	mov eax, 0x4F6C00
	call eax; показать сообщение-вопрос
	push 0x4A1904; и вернуться в исходный код
	ret
endp

proc DisableMessage1
	mov byte [ebp+0x13], 1; для инициализации
	retn 0x28
endp

proc DisableMessage2
	add esp, 0x28
	mov eax, 0x716E02
	call eax; восстанавливаем курсор
	push 0x4AA2F5
	ret
endp

proc FramesDwellings
	pushad; сохраняем регистры
	movzx eax, byte [ecx+edi+0x56]; получить уровень
	push eax
	movzx eax, byte [ecx+edi+0x55]; получить координату y
	push eax
	movzx eax, byte [ecx+edi+0x54]; получить координату x
	push eax
	mov eax, 0x711E7F; MixedPos
	call eax
	push eax
	mov eax, 0x7112C3; получаем адрес структуры объекта по его координатам
	call eax
	add esp, 0x0C+4; для обеих функций
	movzx edx, word [eax+0x22]; получаем истинный подтип
	mov [Temp], edx; кладём его во временную переменную
	popad; выталкиваем регистры
	mov edx, [Temp]; получаем подтип из временной переменной
	cmp byte [ecx+edi], 20; проверяем объект на тип 20
	jnz .Type_17
	mov esi, [NumberOfFrames17]; получить кол-во кадров двеллингов типа 17
	add edx, esi; добавить к номеру кадра, использующемуся для двеллинга типа 20
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
; Сохранение типов обитателей двеллингов
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
; Загрузка типов обитателей двеллингов
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
; Импортируемые процедуры
  library kernel32,'kernel32.dll'

  import kernel32,\
	 CreateFileA,'CreateFileA'
end data

section '.data' data readable writeable

Table_Hooks:
; ОСНОВНАЯ ПРОЦЕДУРА:
Hook 0x4EDED0, MAINDWELLINGS, TJump
; ПРОЦЕДУРЫ ДЛЯ ИСПОЛЬЗОВАНИЯ ИСТИННОГО ПОДТИПА ДВЕЛЛИНГА ИЗ ОБЩЕЙ СТРУКТУРЫ ОБЪЕКТОВ НА КАРТЕ (тип ДАННЫХ - word):
; Занесение подтипа во временную переменную при старте карты:
Hook 0x4FF3F5, PatchDword1, TJump
; Получение подтипа из временной переменной перед установкой обитателей и охраны:
Hook 0x4B859A, PatchDword2, TJump
; Использование реального подтипа для подсказок при наведении мыши:
Hook 0x40B151, PatchDword3, TJump; запоминание истинного подтипа в Temp
Hook 0x40B504, PatchDword3_17, TJump; #17
Hook 0x40B546, PatchDword3_20, TJump; #20
; Использование реального подтипа для подсказок по ПКМ:
Hook 0x413912, PatchDword4, TJump; запоминание истинного подтипа в Temp
Hook 0x413E59, PatchDword4_17_20, TCall; #17
Hook 0x413E9F, PatchDword4_17_20, TCall; #20
; ERM:
; Занесение подтипа во временную переменную перед установкой двеллинга на карту:
Hook 0x71343D, PatchDword5, TJump
; Занесение подтипа во временную переменную перед настройкой двеллинга случайного типа:
Hook 0x5033B1, PatchDword6, TJump
; ОТКЛЮЧЕНИЕ СООБЩЕНИЙ:
Hook 0x4A18FF, DisableMessage0, TJump; в двеллингах: убрать вопрос о найме для существ с уровнем более 1-го
Hook 0x4AB982, DisableMessage1, TCall; в двеллингах: убрать вторичное сообщение об отсутствии рекрутов
Hook 0x4AA2DE, DisableMessage2, TJump; Убрать сообщение-вопрос в Фабрике Военной Техники
; КАДРЫ ZLAGPORT.DEF:
; Кадры двеллингов:
Hook 0x520DB3, FramesDwellings, TCall; заменяем вог-хук на свой
Hook 0x521A7F, HintFrameDwellings, TJump; правка ограничителя подсказки
; Кадр Маяка:
Hook 0x520CE9, FrameLighthouse, TJump
; Кадр Гарнизона:
Hook 0x520ECF, FrameGarrison, TJump
; Кадр Антимагического Гарнизона:
Hook 0x520F2C, FrameAntimagicGarrison, TJump
; Кадр Заброшенной Шахты:
Hook 0x520C76, FrameAbandonedMine, TJump
; Кадр Верфи:
Hook 0x520FF9, FrameShipyard, TJump
; СОХРАНЕНИЕ И ЗАГРУЗКА ОБИТАТЕЛЕЙ
Hook 760EE2h, SaveParam, TJump; сохранение данных
Hook 76148Eh, LoadParam, TJump; загрузка данных
End_Table_Hooks = $

TXT_name db 'DwTable.txt', 0

; Virtual Data
Temp dd ?
NumberOfFrames17 dd ?
NumberOfFrames20 dd ?
; память для ссылок на строки текстовиков и для таблиц жителей двеллингов
DwellingsTable rd 48000

section '.rsrc' data readable resource
  directory RT_VERSION,versions

  resource versions,\
	   1,LANG_NEUTRAL,version

  versioninfo version,VOS__WINDOWS32,VFT_DLL,VFT2_UNKNOWN,LANG_ENGLISH+SUBLANG_DEFAULT,0,\
	      'FileDescription','Dwellings.dll',\
	      'LegalCopyright','Copyright © 2017 the Master.',\
	      'FileVersion','2.0',\
	      'ProductVersion','Typhon'

section '.reloc' data readable discardable fixups
section '.bss' readable writeable
db 1 dup 0