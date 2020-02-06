; ГЛАВНАЯ ПРОЦЕДУРА
proc OnAfterWoG uses esi edi ebx, Event ; после инициализации WoG
; ставим хуки
       mov esi, Table_Hooks
.LoopHooks:
       mov al, [esi+8]
       mov ecx, [esi+4]; тифон
       mov edx, [esi]; ориг
       mov [edx], al
       lea eax, [edx+5]
       sub ecx, eax
       mov [edx+1], ecx
       add esi, 9
       cmp esi, End_Table_Hooks
       jl .LoopHooks
; Меняем допустимое кол-во существ:
       mov esi, ChangeNumMon; таблица адресов
    @@:
       lodsd
       mov dword [eax], MonNum
       cmp esi, EndChangeNumMon
       jnz @b
; изменения для случайной генерации
       mov dword [541159h+1], MonNum-1
       mov eax, -0FB0h;
       mov dword [541013h+2], 0FB0h
       mov [54106Bh+2], eax
       mov [54109Ch+3], eax
       mov [5410E1h+3], eax
       mov [541174h+3], eax
; переносим структур MonNum
       mov eax, MonNamesERM; таблица имён и описаний для ERM
       mov [733390h], eax
       mov [7333C3h], eax
       mov [7514F4h], eax
       mov [752185h], eax
       mov [7521F1h], eax
       mov [752F35h], eax
       mov eax, 12*MonNum; размер таблицы
       mov [7514EFh], eax
       mov [75217Ch], eax
; Переносим таблицу ссылок на имена существ и способности
    @@:
       lodsd
       mov dword [eax], Имена
       cmp esi, _MonNames2
       jnz @b
    @@:
       lodsd
       mov dword [eax], Мн_имена
       cmp esi, _MonNames3
       jnz @b
    @@:
       lodsd
       mov dword [eax], Способности
       cmp esi, ChangeMonTable
       jnz @b
; переносим таблицу сушеств
       xor ecx, ecx
    @@:
       mov eax, [esi]; адрес
       mov cl, [esi+4]; смещение таблицы существ
       lea ebx, [MonTable+ecx]; адрес таблицы + смещение
       mov [eax], ebx; изменить адрес
       add esi, 5
       cmp esi, ChangeCrexbon
       jnz @b
; Поправки для Оборотня:
       mov dword [76761Ah], 194*sizeof._Creature_+MonTable+_Creature_.Здоровье;  HP
       mov dword [767699h], 194*sizeof._Creature_+MonTable+_Creature_.Название_ед_ч; имя
       mov dword [7676A3h], 194*sizeof._Creature_+MonTable+_Creature_.Название_мн_ч; мн. имя
       mov dword [767653h], 194*sizeof._Creature_+MonTable+_Creature_.Название_ед_ч; имя
       mov dword [767664h], 194*sizeof._Creature_+MonTable+_Creature_.Название_мн_ч; мн. имя
; Поправки для Санты:
       mov dword [760DA2h], 173*sizeof._Creature_+MonTable+_Creature_.Прирост
; CrAnim
; Глушим загрузку CrAnim.txt:
       mov byte [4EDF4Bh], 0B8h
       mov dword [4EDF4Bh+1], 01h
; Новый адрес CrAnim:
       mov eax, CrAnim
       mov [67FF74h], eax
       mov [50CC04h], eax
; Новая иаблица бонусных способностей:
    @@:
       lodsd
       mov dword [eax], CrExpBon
       cmp esi, ChangeUpgrades
       jnz @b
       mov eax, 340*MonNum
       mov dword [2B5B31h+465000h+1], eax
       mov dword [2B5B99h+465000h+1], eax
       mov dword [2B5D7Dh+465000h+1], eax
; Апгрейды:
    @@:
       lodsd
       mov dword [eax], Upgrades_Table
       cmp esi, ChangeSkeletonTransformer
       jnz @b
       mov eax, MonNum*4
       mov dword [2EC378h+465000h+1], eax
       mov dword [2ECEB9h+465000h+3], eax
; Трансформатор
    @@:
       lodsd
       mov dword [eax], Skeleton_Transformer_Table
       cmp esi, End_Changes
       jnz @b
; Иммунитеты к заклинаниям 1-го и второго уровня вместо 20% и 40% сопротивления (задаются теперь в другом месте)
       mov dword [44A634h], ImmunToSpells1Level;  CASE_0044A634_PROC0000
       mov dword [44A638h], ImmunToSpells12Level; CASE_0044A634_PROC0001
; исправление бага для взаимоненависти Чёрного Дракона и Титана (150% вместо 105%):
       mov byte [301EABh+465000h], 32h
       mov byte [301EE4h+465000h], 32h
; Удача работает для нейтральных существ:
       mov dword [441524h], 90909090h
       mov word [441524h+4], 9090h
       mov dword [43F642h], 90909090h
       mov word [43F642h+4], 9090h
; перенесение таблицы CrExpMod:
; размер массива
       mov eax, 20*MonNum
       mov [2B5720h+465000h+1], eax
       mov [71A608h+1], eax
       mov [71A670h+1], eax
       mov eax, CrExpMod
       mov [71A60Dh+1], eax
       mov [71A675h+1], eax
       mov [2B5727h+465000h+1], eax
       mov [2B58D9h+465000h+2], eax
       mov [2B5A39h+465000h+2], eax
       mov [2C28F7h+465000h+1], eax
       add eax, 4
       mov [2B5907h+465000h+2], eax
       mov [2B5A4Fh+465000h+2], eax
       add eax, 4
       mov [2B5935h+465000h+2], eax
       mov [2B5A67h+465000h+2], eax
       mov [2B59EAh+465000h+2], eax
       add eax, 4
       mov [2B5991h+465000h+2], eax
       mov [2B5A97h+465000h+2], eax
       add eax, 4
       mov [2B5963h+465000h+2], eax
       mov [2B5A7Fh+465000h+2], eax
; при переходе кода:
       mov eax, 12000
       mov dword [428885h+1], eax
       mov dword [4288C4h+2], eax
; Убрать проверку, запрещающую использование ERM-команд Z
       ; mov byte [741ECDh], 0EBh ; не требуется, убрана в Эра 2.9.9
; Подгрузка twcrport.def из Typhon.pac для WoG-диалога опыта армии:
       stdcall CopyText, LODDEF, 792968h; скопировать строку
; Копирование структуры основных обитателей городов:
       stdcall LoadFile, TownsSetup_mop
       lea esi, [eax+3168]; тифоновская структура основных обитателей городов
       xchg ebx, eax
       mov edi, 6747B4h; базовая для всех городов структура обитателей
       mov ecx, 504/4
       rep movsd
       xchg ecx, ebx
       call vFree
; Убрать некоторые проверки на существ при наложении заклинаний:
       mov eax, MonNum; несуществующий монстр за пределом лимита
       mov [75E84Dh+3], eax; Громовержец
       mov [75E883h+3], eax; Cвященный Феникс
       mov [75E8BAh+3], eax; Пожар
       mov [7606B6h+3], eax; Громовержец
       mov [7606ECh+3], eax; Cвященный Феникс
       mov [760723h+3], eax; Пожар
; Новые адрес Reset для команды UN:G1 с последним параметром = 0
       mov eax, Reset_Имена
       mov dword [733501h], eax
       mov dword [733514h], eax
       mov dword [750C78h], eax
       mov dword [750D0Eh], eax
       mov eax, Reset_Мн_имена
       mov dword [73352Dh], eax
       mov dword [733540h], eax
       mov dword [750CA7h], eax
       mov dword [750D3Dh], eax
       mov eax, Reset_Способности
       mov dword [733559h], eax
       mov dword [73356Ch], eax
       mov dword [750CD6h], eax
       mov dword [750D6Ch], eax
       mov eax, 4000
       mov dword [750C64h], eax
       mov dword [750C93h], eax
       mov dword [750CC2h], eax
       mov dword [750D00h], eax
       mov dword [750D2Fh], eax
       mov dword [750D5Eh], eax
; Возврат:
       ret
endp

proc CopyCrTable; копирование таблицы существ в файл настроек Тифона (особый режим)
       pushad
       stdcall LoadFile, MonstersSetup_mop; загрузить файл настроек
       mov [MonTable_Buffer], eax
       xchg edi, eax; передать адрес буфера с загр. файлом
       mov ebx, [6747B0h]; адрес таблицы монстров
       xor esi, esi; количество монстров
.Цикл_первых_пяти_параметров:
; деф
       mov eax, esi
       sal eax, 4; умножить на 16
       lea eax, [eax + edi]
       stdcall CopyText, dword [ebx + 12], eax; скопировать
; озвучка
       mov eax, esi
       sal eax, 2
       add eax, esi
       lea eax, [eax + edi + 16000]
       stdcall CopyText, dword [ebx + 8], eax; скопировать
; флаги
       push dword [ebx + 16]
       pop dword [esi * 4 + edi + 21000]; установить
; уровень
       mov eax, [ebx + 4]
       mov [esi + edi + 25000], al; установить
; город
       mov eax, [ebx]
       mov [esi + edi + 26000], al; установить
; копирование параметров таблицы монстров - начиная Цена_в_дереве, заканчивая Макс_кол_во_на_карте
       push 84; кол-во байт для копирования
       imul eax, esi, 84
       lea eax, [eax + edi + 85000]; смещение в файле
       push eax
       lea eax, [ebx + _Creature_.Цена_в_дереве]
       push eax;
       call MemCopy
       inc esi
       add ebx, 74h
       cmp esi, [521837h]
       jl .Цикл_первых_пяти_параметров
       imul ecx, [521837h], 84
       add edi, 169000; смещение до CrAnim
       mov esi, [67FF74h]
       rep movsd
       stdcall SaveFile, MonstersSetup_mop, [MonTable_Buffer], 254000
; Возврат в код игры:
       ret
endp

proc LoadCreatures
       pushad
       stdcall LoadFile, MonstersSetup_mop
       cmp dword [MonTable_Buffer], 0; проверяем, загружен ли уже файл в память
       je .файл_ещё_не_загружен
; Скопировать данные из вновь загруженного файла в уже образованный буфер       
       push eax
       mov esi, eax
       mov edi, [MonTable_Buffer]
       mov ecx, 254000/4; размер конфига
       rep movsd
; освободить новый буфер        
       pop ecx
       call vFree
       jmp .файл_уже_был_загружен
.файл_ещё_не_загружен:	
       mov [MonTable_Buffer], eax; передать адрес буфера с загруженным файлом
.файл_уже_был_загружен: 
       mov edi, [MonTable_Buffer]; получить адрес буфера
       mov ebx, MonTable; адрес таблицы монстров
       xor esi, esi; обнулить счётчик монстров
.Цикл_первых_пяти_параметров:
; установить деф
       mov eax, esi
       sal eax, 4; умножить на 16
       lea eax, [eax + edi]
       mov [ebx + 12], eax; установить ссылку на деф
; установить озвучку
       mov eax, esi
       sal eax, 2
       add eax, esi
       lea eax, [eax + edi + 16000]
       mov [ebx + 8], eax; установить ссылку на озвучку
; установить флаги
       push dword [esi * 4 + edi + 21000]
       pop dword [ebx + 16]; установить флаги
; Установить уровень    
       movsx eax, byte [esi + edi + 25000]
       mov [ebx + 4], eax; установить
; Установить город      
       movsx eax, byte [esi + edi + 26000]
       mov [ebx], eax; установить
; копирование параметров таблицы монстров - начиная Цена_в_дереве, заканчивая Макс_кол_во_на_карте
       push 84; кол-во байт для копирования
       lea eax, [ebx + _Creature_.Цена_в_дереве]
       push eax; приёмник
       imul eax, esi, 84
       lea eax, [eax + edi + 85000]; смещение в файле
       push eax
       call MemCopy
       add ebx, 74h
       inc esi
       cmp esi, 1000
       jl .Цикл_первых_пяти_параметров
; копирование всего основного массива абилок
       lea esi, [edi + 27000]; после первых пяти параметров
       mov edi, ebx
       mov ecx, 58000 / 4
       rep movsd
; копирование CrAnim
       add esi, 84000; смещение до CrAnim
       mov edi, CrAnim
       mov ecx, 84000 / 4
       rep movsd
; копирование таблицы защиты от стрел
       mov edi, ProtectFromShooting_Table
       mov ecx, 1000 / 4
       rep movsd
; установить имя, множественное имя и описание:
; сперва освободим буферы от прошлой игры
       mov ecx, [Temp1]
       call vFree
       mov ecx, [Temp2]
       call vFree
       mov ecx, [Temp3]
       call vFree
; теперь перезагружаем:
       stdcall LoadFile, Lang
       movzx ebx, byte [eax]; получить значение языка
       mov [Language], bl
       stdcall LoadFile, dword [ebx*4+_Имена]
       mov [Temp1], eax
       stdcall lfcnt, eax; сосчитать строки в файле имен монстров
       dec eax; так как первая строка - "нет апгрейда", то их как бы меньше
       mov [Temp4], eax; временная переменная
       stdcall LoadFile, dword [ebx*4+_Мн_имена]
       mov [Temp2], eax
       stdcall LoadFile, dword [ebx*4+_Способности]
       mov [Temp3], eax
; начинаем цикл обработки строк
       xor edi, edi; rpos для строк имён монстров
       stdcall linein, [Temp1], edi; для первой строки
       mov edi, eax
       mov dword [Temp5],0; rpos для строк множественных имён монстров
       mov dword [Temp6], 0
       xor esi, esi; обнулить счётчик монстров
       mov ebx, MonTable + _Creature_.Название_ед_ч
    @@:
       stdcall linein, [Temp1], edi
       mov edi, eax
       mov [ebx], ecx
       mov [esi*4+Имена], ecx
       stdcall linein, [Temp2], [Temp5]
       mov [Temp5], eax
       mov [ebx+4], ecx
       mov [esi*4+Мн_имена], ecx
       stdcall linein, [Temp3], [Temp6]
       mov [Temp6], eax
       mov [ebx+8], ecx
       mov [esi*4+Способности], ecx
       add ebx, sizeof._Creature_
       inc esi
       cmp esi, [Temp4]; сравнить кол-во строк с количеством монстров
       jl @b
; Наложенные заклинания
       stdcall LoadFile, ImposedSpells_mop
       push eax
       stdcall MemCopy, eax, ImposedSpells_Table, 6000
       pop ecx
       call vFree
; Бонус защиты в режиме обороны
       stdcall LoadFile, DefenseBonus_mop
       push eax
       stdcall MemCopy, eax, DefenseBonus_Table, 1000
       pop ecx
       call vFree
; Огненная стена
       stdcall LoadFile, FireWall_mop
       push eax
       stdcall MemCopy, eax, FireWall_Table, 125
       pop ecx
       call vFree
; Демонология
       stdcall LoadFile, Demonology_mop
       push eax
       stdcall MemCopy, eax, Demonology_Table, 2000
       pop ecx
       call vFree
       mov dword [27F9A34h], 0
       ret
endp

proc CallTrigger
; получаем номер триггера
       mov esi, [27C1950h]
.if esi = 30371 & dword [27F9964h] = 1986; диалог №1986
	     mov eax, dword [27F9968h]
      .if signed eax > 4 & signed eax < 9 & dword [27F996Ch] <> 13
	     sub eax, 5
	     mov ecx, [Адрес_параметров_альтерветки_для_диалога_постройки_альтерветок]
	     mov eax, [eax * 4 + ecx]
	     xor ecx, ecx
	     xor edx, edx
	     inc edx
	     cmp dword [27F996Ch], 12
	     jnz .правый_клик
	     xchg ecx, edx
	  .правый_клик:
	     stdcall OpenCreatureWindow, eax, 119, 20, ecx, edx
      .elseif (eax = 11 | eax = 13) & dword [27F996Ch] = 13
	     mov dword [887658h], 1; CloseDialog
      .endif
.elseif esi = 30303; Битва_!_перед_действием
       mov ebx, dword [699420h]; COMBAT_MANAGER; ebx теперь хранит CombatManager
       mov eax, [ebx + 3Ch]; Тип_действия
       mov [Тип_действия_в_бою], eax
       call Получить_адрес_структуры_стека_совершающего_действие
       mov [Адрес_структуры_стека_совершающего_действие], eax
       call Получить_адрес_структуры_стека_на_которого_направлено_действие
       mov [Адрес_структуры_стека_на_которого_направлено_действие], eax
.elseif esi = 30304; Битва_!_после_действия
     mov ebx, dword [699420h]; COMBAT_MANAGER; ebx теперь хранит CombatManager
     mov edi, [Адрес_структуры_стека_совершающего_действие]
     mov esi, [Адрес_структуры_стека_на_которого_направлено_действие]
  .if [Тип_действия_в_бою] = 7 & signed esi > -1 & signed [esi + Структура_стека.Текущее_количество] > 0 & [edi + Структура_стека.Тип_существа] <> 149; CR_Стрелковая_Башня
     mov eax, [esi + Структура_стека.Тип_существа]
     cmp byte [eax + RangeRetaliation_Table], 0
     je .нет_способности
  .есть_способность:
     push 0
     mov ecx, esi
     mov eax, 442610h; проверка возможности стрельбы
     call eax
     test al, al
     je .нет_способности
     push edi
     mov ecx, esi
     mov eax, 43F620h; Стрельба_отряда_по_отряду
     call eax
 ; фикс бага стрельбы уже в мёртвом состоянии, если стеку выпала Мораль
   .if signed [edi + Структура_стека.Текущее_количество] < 1; стек убит
     bt [edi + Структура_стека.Флаги], 24; Флаг_Отряду_выпала_Мораль; проверка на выпавшую мораль
     jnb .нет_Морали
     mov dword [ebx + 3Ch], 12; Отмена_действия_отряда
  .нет_Морали:
   .endif
  .нет_способности:
  .endif
.endif
; выполнение затёртого кода
       mov ecx, 28AAFD0h
       ret
endp

proc Получить_адрес_структуры_стека_совершающего_действие
       mov ecx, [699420h]
       imul eax,[ecx+000132B8h],15h
       add eax,[ecx+000132BCh]
       imul eax,00000548h
       lea eax,[eax+ecx+000054CCh]
       retn
endp

proc Получить_адрес_структуры_стека_на_которого_направлено_действие
       push ebx
       mov ebx, [699420h]
       push dword [ebx+44h]
       mov eax, 715872h
       call eax
       pop ecx
       mov edx, eax
       test edx,edx
       jnz L006369B0
       or eax, -1
       pop ebx
       ret
L006369B0:
       movsx eax, byte [edx+18h]
       cmp eax, -1
       jnz L006369BB
       pop ebx
       retn
L006369BB:
       imul eax, 15h
       movsx ecx, byte [edx+19h]
       add eax,ecx
       imul eax, 548h
       lea eax, [eax+ebx+000054CCh]
       pop ebx
       retn
endp

proc MapInstruction
; выполнение затёртого кода
       push 1
       mov eax, 72C8B1h
       call eax
       pop ecx
; 6977e8 - адрес оригинальной структуры дерева построек (8*44*9)
       stdcall LoadFile, TownsSetup_mop
       xchg ebx, eax
       mov esi, ebx
       mov edi, 835C58h
       mov ecx, 3168/4
       rep movsd
       push ebx; сохранить адрес буфера
; настройка альтернатив
       xor ecx, ecx; счётчик для файла
       mov edi, Alternatives_Table
       xor ebx, ebx; счётчик для диалога альтерветок
    @@:
       mov eax, [esi+ecx+504]; получить существо-альтернативу базовое
       mov [edi+ebx+8], eax
       mov eax, [esi+ecx]; получить основное существо базовое
       mov [edi+ebx], eax
       mov eax, [esi+ecx+28+504]; получить существо-альтернативу улучшенное
       mov [edi+ebx+12], eax
       mov eax, [esi+ecx+28]; получить основное существо улучшенное
       mov [edi+ebx+4], eax
       add ecx, 4
     .if ecx = 28
       xor ecx, ecx
       add esi, 56
     .endif
       add ebx, 24
       cmp ebx, 1512
       jl @b
       pop ecx
       call vFree
; Копирование структуры основных обитателей для каждого города:
       mov ebx, TownCreatures
     @@:
       push 504 ebx 6747B4h
       call MemCopy
       add ebx, 504
       cmp ebx, TownCreatures+48*504
       jl @b
       ret
endp

proc SetupRandomDwellings
       pushad
       stdcall LoadFile, TownsSetup_mop
       lea esi, [eax+3168]; тифоновская структура основных обитателей городов
       xchg ebx, eax
       mov edi, 6747B4h; базовая для всех городов структура обитателей
       mov ecx, 504/4
       rep movsd
       xchg ecx, ebx
       call vFree
       popad
; выполнение затёртого кода
       mov eax, 5031B0h
       call eax
       ret
endp

proc SaveParam
       push End_Save_Massive-Save_Massive
       push Save_Massive
       mov eax, 704062h
       call eax
       add esp, 8
       test eax,eax
       jz @f
       mov eax, 7712B0h
       mov eax, 1
       push 76137Ah
       ret
     @@:
       push 190h
       push 760F0Ch
       ret
endp

proc LoadParam
       push End_Save_Massive - Save_Massive
       push Save_Massive
       mov eax, 7040A7h
       call eax
       add esp, 8
       test eax,eax
       jz @f
       mov eax, 7712B0h
       mov eax, 1
       push 761964h
       ret
     @@:
       push 0190h
       push 7614B8h
       ret
endp

proc LoadFile; stdcall
       push ebp
       mov ebp,esp
       push esi
       push edi ebx
       push 0
       push 80h
       push 3
       push 0
       push 1
       push 0C0000000h
       mov ebx, [ebp+08h]
       push ebx
       call [CreateFileA]
       mov edi, eax
       push 0
       push edi
       call [GetFileSize]
       mov [ebp+08h], eax
       mov ecx, eax
       call MemAlloc
       mov esi, eax
       push 0
       lea ecx, [ebp+08h]
       push ecx
       push dword [ebp+08h]
       push eax
       push edi
       call [ReadFile]
       push edi
       call [CloseHandle]
.if ~esi
       push 10h
   .if ~[Language]
       push Load_File_Error_Title_Rus
       push ebx Load_File_Error_Text_Rus
   .else
       push Load_File_Error_Title_Eng
       push ebx Load_File_Error_Text_Eng
   .endif
       push 697428h
       mov eax, 6179DEh
       call eax
       add esp, 12
       push 697428h
       push dword [699650h]
       call dword [63A298h]
; показать сообщение об ошибке и закрыть игру
       mov ecx, 67F658h; Initialization_failed_
       mov eax, 0x4F3D20
       call eax
.endif
       mov eax, esi
       pop ebx edi
       pop esi
       pop ebp
       retn 4
endp

proc SaveFile
       push ebp
       mov ebp,esp
       push edi
       push 0
       push 80h
       push TRUNCATE_EXISTING
       push 0
       push 1
       push 0C0000000h
       push   dword    [ebp+08h]
		call	[CreateFileA]
		mov	edi,eax
		push	00000000h
		lea	ecx,[ebp+10h]
		push	ecx
		push   dword	[ebp+10h]
		push   dword	[ebp+0Ch]
		push	eax
		call	[WriteFile]
		push	edi
		call	[CloseHandle]
		pop	edi
		pop	ebp
		retn	000Ch
endp

proc MemAlloc
       push esi
       mov esi, ecx
       push 4
       push 1000h
       push esi
       push 0
       call [VirtualAlloc]
       push 4
       push 1000h
       push esi
       push eax
       call [VirtualAlloc]
       pop esi
       retn
endp

proc vFree; thiscall
       push 8000h
       push 0
       push ecx
       call [VirtualFree]
       retn
endp	

proc lfcnt
       xor eax, eax ; set counter to zero
       mov ecx, [esp+4]
       sub ecx, 1
       jmp @f
    pre:
       add eax, 1	      ; add 1 to return value if LF found
     @@:
       add ecx, 1
       cmp byte [ecx], 0   ; test for zero terminator
       je @f
       cmp byte [ecx], 10  ; test line feed
       je pre
       jmp @b
      @@:
       retn 4
endp

proc lineout string;, buffer
	mov ecx, [string]; адрес строки
	mov edx, esi; адрес буфера
     @@:
	mov al, [ecx]; символ
      .if al <> 0Dh; игнорируем отступы Win
	mov [edx], al
	inc edx
      .endif
	inc ecx
	test al, al
	jnz @b
	mov word [edx-1], 0A0Dh
	sub edx, esi
	inc edx
	add esi, edx
	mov eax, edx
	ret
endp


proc linein
       mov edx, [esp+4]
       add edx, [esp+8]
       push edx
       xor eax, eax
       or ecx, -1
    @@:
       inc ecx
       mov al, byte [ecx+edx]
       cmp al, 9
       je @b
       cmp al, 0Dh
       ja @b
       mov byte [ecx+edx], 0
       test eax, eax
       je @f
       lea eax, [ecx+2]
       add eax, [esp+12]
    @@:
       pop ecx
       retn 8
endp


proc MemCopy
       mov ecx, [esp+0Ch]
       push esi
       mov esi, [esp+08h]
       push edi
       mov edi, [esp+10h]
       mov eax, ecx
       shr ecx, 02h
       rep movsd
       mov ecx, eax
       and ecx, 3
       rep movsb
       pop edi
       pop esi
       retn 0Ch
endp

proc MonsterRandomGeneration
       cmp byte [ebx+Ban_Table-1],0
       je @f
       push 541137h
       ret
    @@:
       mov edx, [ecx+2Ch]
       mov esi, [ecx]
       push 541102h
       ret
endp

proc MonsterRandomGeneration2
       cmp eax, edx
       jg @f
       cmp dword [edi], -1
       je @f
       lea eax, [esi+esi*4]
       push 541116h
       ret
     @@:
       push 541137h
       ret
endp

proc ArrowTable
       pushad
       xchg esi, eax; номер существа
       stdcall LoadFile, Ammo_mop
       push eax; сохранить адрес буфера с файлом
       shl esi, 4; умножить на 16
       add esi, eax; добавить адрес буфера с файлом
       stdcall CopyText, esi, TextBufferAmmo; скопировать в буфер для текста
       pop ecx
       call vFree; освободить буфер
       popad
    .if ~byte [TextBufferAmmo]; нет снаряда
       push 43DB1Ah
       ret
    .endif
       mov ecx, TextBufferAmmo
       push 43DB1Dh
       ret
endp

proc Counterstrike
       movzx eax, byte [eax+Counterstrike_Table]
       mov [esi+454h], eax
       push 43D6CBh
       ret
endp

proc Counterstrike2
       movzx eax, byte [eax+Counterstrike_Table]
       mov [esi+454h], eax
       push 446E9Ch
       ret
endp

proc AlwaysPositiveMorale
       cmp byte [edi+AlwaysPositiveMorale_Table], 0
       jnz @f
       push 044AF0Bh; нет бонуса
       ret
    @@:
       push 44AF01h; есть бонус
       ret
endp

proc AlwaysPositiveMorale2
       cmp byte [eax+AlwaysPositiveMorale_Table], 0
       jnz @f
       push 44BCBDh; нет бонуса
       ret
    @@:
       push 44BC58h; есть бонус
       ret
endp

proc AlwaysPositiveMorale3
       cmp byte [ecx+AlwaysPositiveMorale_Table], 0
       jnz @f
       push 76714Bh; нет бонуса
       ret
    @@:
       push 76713Fh; есть бонус
       ret
endp

proc AlwaysPositiveLuck
       cmp byte [ebx+AlwaysPositiveLuck_Table], 0
       jnz @f
       push 044C18Ah; нет бонуса
       ret
     @@:
       mov esi, 1
       cmp dword [ebp+14h], esi
       jl @f
       push 44C18Ah
       ret
     @@:
       imul ebx, sizeof._Creature_
       push dword [ebx+MonTable+_Creature_.Название_мн_ч]
       lea eax, [ebp-30h]
     .if [Language] = 0
       push PlusLuckEngText
     .else
       push PlusLuckRusText
     .endif
       push    eax
       mov eax, 50C7F0h
       call eax
       push 44C161h
       ret
endp

proc AlwaysPositiveLuck2
       mov ebx, [edi+34h]
       cmp byte [ebx+AlwaysPositiveLuck_Table], 0
       jnz @f
       push 43DCFFh; нет бонуса
       ret
     @@:
       push 43DCE8h
       ret
endp

proc AlwaysPositiveLuck3
       mov ecx, [esi+edi*4]
       cmp byte [ecx+AlwaysPositiveLuck_Table], 0
       jnz @f
       push 44B12Eh; нет бонуса
       ret
     @@:
       push 44B124h
       ret
endp

proc Ballistic
       movsx edi, byte [edi+Ballistic_Table]
    .if ~edi; обычное существо
       push 445ADAh
       ret
    .elseif edi = 4; зависимость от уровня Баллистики
       push 445ABCh
       ret
    .else
       mov eax, edi; уровень Баллистики
       push 445ADDh
       ret
    .endif
endp

proc DeathBlow
       mov ecx, [eax+34h]
       xor edx, edx
       mov dword [ebp-4], 0
       mov dl, [ecx+DeathBlow_Table]
       add [ebp-4], edx
       push 766CF5h
       ret
endp

proc DeathBlowCorrect
       cmp eax, [2860220h]
       jg @f
       push 4436E7h
       ret
     @@:
       push 44388Eh
       ret
endp

proc DeathCloudAndFireBall
       movsx ecx, byte [eax+DeathCloudAndFireBall_Table]
     .if ~ecx
       push 43FA31h
       ret
     .elseif ecx = 1
       push 43F735h
       ret
     .else
       push 43FB27h
       ret
     .endif
endp

proc DeathCloudAndFireBall2
       cmp byte [eax+DeathCloudAndFireBall_Table], 0
       jnz @f
       push 41ED6Dh
       ret
     @@:
       push 41ED69h
       ret
endp

proc Espionage
       mov ecx, 6
.cycle:
       mov edx, [ecx*4+esi+91h]
       test edx, edx
       jl @f
       cmp byte [edx+Espionage_Table], 0
       je @f
       mov eax, 3
       pop esi
       ret
    @@:
       dec ecx
       jge .cycle
       mov eax, [esi+00000129h]
       pop esi
       ret
endp

proc Fear
       cmp byte [ebx+Fear_Table], 0
       jnz @f
       push 760509h; нет бонуса
       ret
     @@:
       push 76056Eh; есть бонус
       ret
endp

proc Fearless
       mov eax, [edi+34h]
       cmp byte [eax+Fearless_Table], 0
       jnz @f
       push 76049Ch; нет бонуса
       ret
     @@:
       push 7604D0h; есть бонус
       ret
endp

proc NoWallPenalty
       cmp byte [eax+NoWallPenalty_Table], 0
       jnz @f
       push 7605C5h; нет бонуса
       ret
     @@:
       push 760622h; есть бонус
       ret
endp

proc MagicAura
       mov eax, [eax+34h]
       cmp byte [eax+MagicAura_Table], 0
       jnz @f
       push 7672B1h; нет бонуса
       ret
     @@:
       push 7672A5h; есть бонус
       ret
endp


proc FireShield
       mov eax, [esi+34h]
       cmp byte [eax+FireShield_Table], 0
       jnz @f
       push 4225DCh; нет бонуса
       ret
     @@:
       push 4225E6h; есть бонус
       ret
endp

proc FireShield2
       mov eax, [ecx+34h]
       cmp byte [eax+FireShield_Table], 0
       jnz @f
       push 442E6Eh; нет бонуса
       ret
     @@:
       push 442E67h; есть бонус
       ret
endp

proc FireShield3
       mov edx, [edi+34h]
       cmp byte [eax+FireShield_Table], 0
       jnz @f
       push 422867h; нет бонуса
       ret
     @@:
       push 4227F8h; есть бонус
       ret
endp

proc StrikeAndReturn
       movsx eax, byte [eax+StrikeAndReturn_Table]
     .if ~eax
       push 75E06Ah
       ret
     .elseif eax = 1
       push 75E0BBh
       ret
     .else
       push 75E08Bh
       ret
     .endif
endp

proc StrikeAndReturn2
       mov edx, [ebp-4]
       cmp byte [edx+StrikeAndReturn_Table], 0
       jnz @f
       push 762955h
       ret
     @@:
       push 762969h
       ret
endp

proc StrikeAndReturn3
       cmp byte [ecx+StrikeAndReturn_Table], 0
       jnz @f
       push 421C17h
       ret
     @@:
       push 421C36h
       ret
endp

proc SpellsCostLess
       cmp dword [803288h], 0
       jz .L00766BDE
       cmp dword [2772730h], 0
       jnz .L00766BF3
.L00766BDE:
       mov eax, [ebp-18h]
       movzx eax, byte [eax+SpellsCostLess_Table]
    .if eax
       mov [ebp-14h], eax
    .endif
       push 766B90h
       ret
.L00766BF3:
       mov dword [ebp-0Ch],0
       mov eax, [ebp-18h]
       movzx eax, byte [eax+SpellsCostLess_Table]
    .if eax
       mov [ebp-0Ch], eax
    .endif
       push 766C0Dh
       ret

endp

proc SpellsCostDump
       push ebx
       xor ebx, ebx
       xor ecx, ecx
.cycle:
       mov eax, [edi+ecx*4]
       test eax, eax
       jl @f
       movzx eax, byte [eax+SpellsCostDump_Table]
       cmp eax, ebx
       jl @f
       mov ebx, eax
      @@:
       inc ecx
       cmp ecx, 7
       jl .cycle
       add esi, ebx
       pop ebx
       push 4E5569h
       ret
endp

proc Properties1
       movsx ecx, byte [eax+Properties1_Table]
       jmp dword [440634h+ecx*4]
endp

proc Properties2
       movsx ecx, byte [eax+Properties2_Table]
       jmp dword [4412C0h+ecx*4]
endp

proc Properties3
       movsx edx, byte [eax+Properties3_Table]
       jmp dword [4476FCh+edx*4]
endp

proc Properties4
       movsx edx, byte [ecx+Properties4_Table]
       jmp dword [4214DCh+edx*4]
endp

proc Properties5
       dec edx
       mov [esi+0DCh],edx
       movsx ecx, byte [eax+Properties5_Table]
       jmp dword [448460h+ecx*4]
endp

proc Properties5_1
       movsx ecx, byte [edi+Properties5_Table]
       jmp dword [492EACh+ecx*4]
endp

proc Properties5_2
       xor edx,edx
       cmp dword [eax+4Ch], 1
       setg dl
       imul ecx, [eax+34h], sizeof._Creature_
       push dword [ecx+edx*4+MonTable+_Creature_.Название_ед_ч]
       movzx ecx, byte [edi+Spells_Table]
       imul ecx, 88h
       push dword [ecx+7BD2D0h]
       mov edx, [6A5DC4h]
       mov eax, [edx+20h]
       push dword [eax+70h]
       push 697428h
       mov eax, 6179DEh
       call eax
       add esp, 10h
       push 492E3Bh
       ret
endp

proc Immun
       movsx ecx, byte [edx+Immun_Table]
       jmp dword [44A634h+ecx*4]
endp


proc ImmunToSpells1Level
       cmp dword [esi+18h], 1
       push 44A569h
       ret
endp

proc ImmunToSpells12Level
       cmp dword [esi+18h], 2
       push 44A569h
       ret
endp

proc GnomResistance
       mov eax, [ecx+34h]
       movsx ebx, byte [eax+GnomResistance_Table]
       mov edx,[283282Ch]
       sub edx, ebx
       push 75DA0Eh
       ret
endp

proc GolemResistance
       mov esi, eax
       movsx eax, byte [esi+GolemResistance_Table]
       jmp dword [44B25Ch+eax*4]
endp

proc Spells
       mov eax, [esi+34h]
       cmp eax, 0AEh
       jl .L004483C4
       cmp eax, 0BFh
       jg .L004483C4
       push esi
       mov eax, 76BEEAh
       call eax
       pop ecx
       push eax
       push 2
       push -1
       push 1
       push dword [ebp+08h]
       mov eax, [esi+34h]
       movzx eax, byte [eax+Spells_Table]
       push eax
       push 4483D2h
       ret
.L004483C4:
       mov eax,[ebp+08h]
       push 6
       push 2
       push -1
       mov ecx, [esi+34h]
       push 1
       push eax
       movzx eax, byte [ecx+Spells_Table]
       push eax
       push 4483D2h
       ret
endp

proc Spells2
       push 1 edi eax
       mov eax, [esi+34h]
       movzx eax, byte [eax+Spells_Table]
       push eax
       push 4476CEh
       ret
endp

proc Spells3
       mov eax,[ebp-0Ch]
       mov bl, byte [eax+Spells_Table]
       test bl,bl
       jnz @f
       push 75D112h
       ret
@@:
       push 75D0FBh
       ret
endp

proc Spells4
       mov edx,[ebp+20h]
       movzx ecx, byte [edx+Spells_Table]
       mov [eax+000004E0h], ecx
       push 75CDECh
       ret
endp

proc SantaFix
       cmp dword [ebp+20h],000000ADh
       jnz .L0075D03E
       mov ecx,[ebp-10h]
       cmp ecx,[ebp-0Ch]
       push  0075CEE3h
       ret
.L0075D03E:
       push 75D03Eh
       ret
endp

proc Hate
       movzx ecx, byte [edx+Hate_Table]
       jmp dword [766F29h+ecx*4]
endp

proc JoustingBonus
       mov eax, [28460C0h]
       cmp byte [eax+JoustingBonus_Table], 0
       jnz @f
       push 75D84Dh; нет бонуса
       ret
     @@:
       mov dword [2846420h], 0Bh
       push 75D860h; есть бонус
       ret
endp

proc ImmunToJoustingBonus
       cmp byte [eax+ImmunToJoustingBonus_Table], 0
       jnz @f
       push 443083h; нет бонуса
       ret
     @@:
       push 4430A3h; есть бонус
       ret
endp

proc Regeneration
       mov esi, [RegenerationHitPoints_Table+eax*4]
       mov [2846BC8h], esi
       movsx ebx, byte [eax+RegenerationChance_Table]
       test ebx, ebx
       jnz @f
       push 75DE8Eh
       ret
@@:
       mov eax, 7563A0h
       call eax
       cmp eax,ebx
       push 75DF28h
       ret
endp

proc ThreeHeadedAttack
       cmp byte [eax+ThreeHeadedAttack_Table], 0
       jnz @f
       push 4414A4h
       ret
    @@:
       push 44138Fh
       ret
endp

proc ThreeHeadedAttack2
       cmp byte [eax+ThreeHeadedAttack_Table], 0
       jnz @f
       push 4488DFh
       ret
    @@:
       push 4487F3h
       ret
endp

proc ManaDrain
       cmp word [eax*2+ManaDrain_Table], 0
       lea eax, [eax-3Dh]
       jnz @f
       push 4650D5h
       ret
     @@:
       push 465128h
       ret
endp

proc ManaDrain2
       mov edx, [ebx+34h]
       sub ax, [edx*2+ManaDrain_Table]
       test ax, ax
       push 46517Ah
       ret
endp

proc MagicChannel
       mov ecx, [eax-000000C0h]
       cmp byte [ecx+MagicChannel_Table], 0
       jnz @f
       push 5A250Ah
       ret
    @@:
       push 5A24E5h
       ret
endp

proc MagicMirror
       mov ecx, [ecx+34h]
       cmp byte [ecx+MagicMirror_Table], 0
       jnz @f
       push 44854Fh
       ret
    @@:
       push 448531h
       ret
endp

proc Sharpshooters
       cmp byte [eax+Sharpshooters_Table], 0
       jnz @f
       push 75DD6Ch
       ret
    @@:
       push 75DDD2h
       ret
endp

proc ShootingAdjacent
       mov [2846414h], esi
       test ecx,ecx
       jz .L007671A5
       push dword [ebp+08h]
       mov eax, 4D9460h
       call eax
       test al,al
       jnz .L007671CD
 .L007671A5:
       mov esi, [2846414h]
       mov eax, [esi+34h]
       mov al, [eax+ShootingAdjacent_Table]
       test al,al
       jnz .L007671CD
       pushad
       push  dword  [2846414h]
       mov eax, 71ED4Bh
       call eax
       pop ecx
       test al,al
       popad
       jnz .L007671CD
       xor al,al
 .L007671CD:
       pop edi
       pop esi
       pop ebx
       pop ebp
       retn 4
endp

proc ReduceTargetDefense
       mov edx, [2846BCCh]
       mov dword [ebp-14h], 64h
       movzx eax, byte [ecx+ReduceTargetDefense_Table]
       mov [ebp-10h],eax
       mov dword [ebp-0Ch], 0
       fild qword [ebp-10h]
       fidiv dword [ebp-14h]
       fstp qword [ebp-10h]
       fild dword [edx+000000CCh]
       fmul qword [ebp-10h]
       push 75D4F2h
       ret
endp

proc ReduceTargetDefense2
       mov word [Temp1], 64h
       movzx eax, byte [eax+ReduceTargetDefense_Table]
       mov [Temp2],eax
       fild dword [Temp2]
       fidiv word [Temp1]
       fstp dword [Temp2]
       fild dword [ebp+0Ch]
       fstp dword [ebp+0Ch]
       fld dword [ebp+0Ch]
       fmul dword [Temp2]
       push 44230Dh
       ret
endp

proc Rebirth
       mov eax, [esi+34h]
       mov al, [eax+Rebirth_Table]
     .if ~al
       push 75E11Ah; нет
       ret
     .elseif al = 1
       push 75E149h; обычное
       ret
     .endif
       push 75E136h; всегда
       ret
endp

proc ProtectFromShooting1
       call MAIN_ProtectFromShooting
       add dword [ebp-08h], ecx
       cmp dword [ebp-08h], 0
       mov eax, [esi+00000208h]; Воздушный Щит
       jz  L00443D1B
       fild dword [ebp-08h]
       fidiv word [PrShoot1C671]
       test eax,eax
       jz L00576046
       fstp dword [ebp-08h]
       fld dword [esi+000004BCh]
       fsub dword [ebp-08h]
L00576041:
       push 443D37h
       ret
L00576046:
       fchs
       fiadd word [PrShoot4AEFF]
       jmp  L00576041
L00443D1B:
       push 443D1Bh
       ret
endp

proc ProtectFromShooting2
       call MAIN_ProtectFromShooting
       add dword [ebp-10h], ecx
       cmp dword [ebp-10h], 0
       mov eax, [esi+00000208h]; Воздушный Щит
       jz L004427F2
       fild dword [ebp-10h]
       fidiv word [PrShoot1C671]
       test eax,eax
       jz L005760F9
       fstp dword [ebp-10h]
       fld dword [esi+000004BCh]
       fsub dword [ebp-10h]
L005760F4:
       push 44280Eh
       ret
L005760F9:
       fchs
       fiadd word [PrShoot4AEFF]
       jmp L005760F4
L004427F2:
       push 4427F2h
       ret
endp

proc ProtectFromShooting3
       push ecx esi
       mov esi, ecx
       call MAIN_ProtectFromShooting
       add dword [ebp-8], ecx
       cmp dword [ebp-08h], 0
       pop esi ecx
       mov eax, [ecx+00000208h]; Воздушный Щит
       jz L00443AD1
       fild dword [ebp-08h]
       fidiv word [PrShoot1C671]
       test eax,eax
       jz L0040533F
       fstp dword [ebp-08h]
       fld dword [ecx+000004BCh]
       fsub dword [ebp-08h]
L0040533A:
       push 443AEDh
       ret
L0040533F:
       fchs
       fiadd word [PrShoot4AEFF]
       jmp L0040533A
L00443AD1:
       push 443AD1h
       ret
endp

proc ProtectFromShooting4
       call MAIN_ProtectFromShooting
       add dword [EBP-8], ecx
       cmp dword [ebp-08h], 0
       mov eax, [esi+00000208h]; Воздушный Щит
       jz L00443BBD
       fild dword [ebp-08h]
       fidiv word [PrShoot1C671]
       test eax, eax
       jz L004053D7
       fstp dword [ebp-08h]
       fld dword [esi+000004BCh]
       fsub dword [ebp-08h]
 L004053D2:
       push 443BD9h
       ret
 L004053D7:
       fchs
       fiadd word [PrShoot4AEFF]
       jmp L004053D2
L00443BBD:
       push 443BBDh
       ret
endp


proc MAIN_ProtectFromShooting; Разрешены EAX, ECX, EDX
; Структура стека = ESI
       mov eax, [esi+34h]
       movsx ecx, byte [eax+ProtectFromShooting_Table]
       ret
endp

proc RayColor
       movsx ecx, byte [ebx+RayColor_Table]
    .if ecx = 3; красный
       mov ecx, 12Ch
       push 43F298h
       ret
    .elseif signed ecx > 3; синий
       mov ecx, 3Fh
       push 43F298h
       ret
    .endif
       jmp dword [43F5B8h+ecx*4]
       ret
endp

; ******************ALTERNATIVES********************
proc Alternatives01
       movsx edx,byte [esi]
       imul edx, 1F8h
       lea edx, [edx+TownCreatures-1Ch]
       mov edx, [edx+ecx*4]
       push 551A1Bh
       ret
endp

proc Alternatives02
       mov eax, [ebx+38h]
       movsx eax, byte [eax]
       imul eax, 1F8h
       lea eax, [eax+TownCreatures]
       mov eax, [eax+ecx*4]
       push 5C719Dh
       ret
endp

proc Alternatives03
       movsx ecx, byte [esi]
       imul ecx, 1F8h
       lea ecx,[ecx+TownCreatures]
       mov eax,[ecx+eax*4]
       push 5C602Ah
       ret
endp

proc Alternatives04
       movsx eax, byte [esi]
       imul eax, 1F8h
       lea eax, [eax+TownCreatures]
       mov eax, [eax+edx*4]
       push 5BFFE6h
       ret
endp

proc Alternatives05
       mov ecx, [69954Ch]
       mov ecx, [ecx+38h]
       movsx ecx, byte [ecx]
       imul ecx, 1F8h
       lea ecx, [ecx+TownCreatures]
       mov edx, [ecx+edx*4]
       mov [5D9E60h],ecx
       mov [5D9ED6h],ecx
       mov [5D9F4Fh],ecx
       mov [5D9FC8h],ecx
       mov [5DA041h],ecx
       mov [5DA0C5h],ecx
       mov [5DA1BDh],ecx
       push 5D9DEBh
       ret
endp

proc Alternatives06
       mov eax, [esi+38h]
       movsx eax, byte [eax]
       imul eax, 1F8h
       lea eax, [eax+TownCreatures]
       mov eax,[eax+edx*4]
       push 5DD972h
       ret
endp

proc Alternatives07
       mov eax, [ebp-08h]
       mov eax, [eax+38h]
       movsx eax, byte [eax]
       imul eax, 1F8h
       lea eax, [eax+TownCreatures]
       mov eax, [eax+ecx*4]
       push 5DDADDh
       ret
endp

proc Alternatives08
       movsx eax, byte [esi]
       imul eax, 1F8h
       lea eax, [eax+TownCreatures]
       mov eax,[eax+edx*4]
       push 5DD0A0h
       ret
endp

proc Alternatives09
       movsx eax, byte [esi]
       imul eax, 1F8h
       lea eax, [eax+TownCreatures]
       mov eax, [eax+edx*4]
       push 5519AEh
       ret
endp

proc Alternatives10
       lea edx, [edi+ecx*2]
       mov eax, [ebp+08h]
       movsx eax, byte [eax]
       imul eax, 1F8h
       lea eax, [eax+TownCreatures]
       mov eax, [eax+edx*4]
       cmp [esi], bx
       push 428609h
       ret
endp

proc Alternatives11
       movsx eax, byte [ebx]
       imul eax, 1F8h
       lea eax, [eax+TownCreatures]
       mov eax,[eax+edx*4]
       push 42896Bh
       ret
endp

proc Alternatives12
       mov eax,[ebp-14h]
       movsx eax, byte [eax]
       imul eax, 1F8h
       lea eax,[eax+TownCreatures]
       mov eax,[eax+edx*4]
       push 429BB8h
       ret
endp

proc Alternatives13
       movsx ecx, byte [edi]
       imul ecx, 1F8h
       lea ecx, [ecx+TownCreatures]
       mov ecx, [ecx+eax*4]
       push 429DF3h
       ret
endp

proc Alternatives14
       movsx edx, byte [edi]
       imul edx, 1F8h
       mov eax, dword [edx+eax*4+TownCreatures]
       push 429F39h
       ret
endp

proc Alternatives15
       movsx edx, byte [edi]
       imul edx, 1F8h
       lea edx, [edx+TownCreatures]
       mov eax, [edx+eax*4]
       push 42A02Dh
       ret
endp

proc Alternatives16
       movsx eax, byte [ecx]
       imul eax, 1F8h
       lea eax, [eax+TownCreatures]
       mov eax, [eax+edx*4]
       push 42B53Fh
       ret
endp

proc Alternatives1718
       movsx eax, byte [ecx]
       imul eax, 1F8h
       lea eax, [eax+TownCreatures]
       mov edi, [eax+edx*4]
       mov esi, [eax+esi*4]
       mov edx, [699538h]
       cmp word [edx+0001F63Eh], 5
       movsx eax, word [ecx+ebx*2+16h]
       push 42B5FAh
       ret
endp

proc Alternatives19
       movsx eax, byte [edi]
       imul eax, 1F8h
       lea eax, [eax+TownCreatures]
       mov eax,[eax+ecx*4]
       push 42B72Bh
       ret
endp

proc Alternatives20
       movsx edx, byte [esi]
       imul edx, 1F8h
       lea edx, [edx+TownCreatures]
       mov edx, [edx+eax*4]
       push 42BE49h
       ret
endp

proc Alternatives21
       mov eax, [ebp+0Ch]
       movsx eax, byte [eax]
       imul eax, 1F8h
       lea eax, [eax+TownCreatures]
       mov eax, [eax+edx*4]
       push 42CF0Eh
       ret
endp

proc Alternatives22
       mov edi, [ebp+08h]
       movsx edi, byte [edi]
       imul edi, 1F8h
       lea edi, [edi+TownCreatures]
       mov eax, [edi+eax*4]
       mov edi, ecx
       push 42D248h
       ret
endp

proc Alternatives23
       lea ecx, [eax*8]
       sub ecx, eax
       lea edx, [edx+ecx*2]
       movsx eax, byte [esi]
       imul eax, 1F8h
       lea eax, [eax+TownCreatures]
       mov eax, [eax+edx*4]
       pop edi
       pop esi
       pop ebx
       push 432E9Bh
       ret
endp

proc Alternatives24
       movsx edx, byte [edi]
       imul edx, 1F8h
       lea edx, [edx+TownCreatures]
       mov edx, [edx+ecx*4]
       push 432F66h
       ret
endp

proc Alternatives25
       movsx ecx, byte [edx]
       imul ecx, 1F8h
       lea ecx, [ecx+TownCreatures]
       mov eax,[ecx+eax*4]
       push 433642h
       ret
endp

proc Alternatives26
       movsx edx, byte [esi]
       imul edx, 1F8h
       lea edx, [edx+TownCreatures]
       mov edx, [edx+ecx*4]
       push 4C8D34h
       ret
endp

proc Alternatives2728
       mov esi, [ebp-10h]
       movsx esi, byte [esi]
       imul esi, 1F8h
       lea esi, [esi+TownCreatures]
       mov edi,[eax+esi]
       sub esi, 1Ch
       mov [4BF30Ah], esi
       push 4BF308h
       ret
endp

proc Alternatives29
       mov eax, [ebp-14h]
       movsx eax, byte [eax]
       imul eax, 1F8h
       lea eax, [eax+TownCreatures]
       mov eax, [eax+edx*4]
       push 51CFDFh
       ret
endp

proc Alternatives3031
       movsx edx, byte [esi]
       imul edx, 1F8h
       lea edx,[edx+TownCreatures+1Ch]
       sub edx, 1Ch
       mov [525AB0h],edx
       mov edx, [edx+eax*4]
       push 525A92h
       ret
endp

proc Alternatives32
       movsx ebx, byte [edi]
       imul ebx, 1F8h
       lea ebx, [ebx+TownCreatures]
       mov ebx,[ebx+eax*4]
       push 52A322h
       ret
endp


proc Alternatives33
       push edi
       mov edi, ecx
       movsx ecx, byte [ecx+04h]
       lea esi, [ecx*8]
       sub esi, ecx
       lea eax, [eax+esi*2]
       pop esi
       movsx edi, byte [edi]
       imul edi, 1F8h
       lea edi,[edi+TownCreatures]
       mov ecx,[edi+eax*4]
       pop edi
       push 551B80h
       ret
endp

proc Alternatives34
       movsx ebx, byte [ecx]
       imul ebx, 1F8h
       lea ebx, [ebx+TownCreatures]
       mov eax, [ebx+eax*4]
       push 5BEFA5h
       ret
endp

proc Alternatives35
       mov eax, [ebx+38h]
       movsx eax, byte [eax]
       imul eax, 1F8h
       lea eax, [eax+TownCreatures]
       mov eax, [eax+edx*4]
       push 5C803Eh
       ret
endp

proc Alternatives36
       mov edx, [ebx+38h]
       movsx edx, byte [edx]
       imul edx, 1F8h
       lea edx, [edx+TownCreatures]
       mov eax, [edx+eax*4]
       push 5C803Eh
       ret
endp

proc Alternatives37
       push ebp
       mov ebp,esp
       movsx edx, byte [ecx+04h]
       push esi
       xor eax, eax
       lea esi, [edx*8]
       push edi
       sub esi, edx
       movsx edx, byte [ecx]
       imul edx, 1F8h
       lea edx, [edx+TownCreatures]
       lea edx, [edx+esi*8]
       push 5C026Bh
       ret
endp

proc Alternatives38
       lea ecx, [ebx+ecx*2]
       movsx edx, byte [edx]
       imul edx, 1F8h
       lea edx, [edx+TownCreatures-114h]
       mov eax, [edx+ecx*4]
       push 5219B9h
       ret
endp

proc Alternatives39
       lea ecx, [ebx+ecx*2]
       movsx eax, byte [edx]
       imul eax, 1F8h
       lea eax, [eax+TownCreatures-84h]
       mov eax, [eax+ecx*4]
       push 521914h
       ret
endp

proc Alternatives40
       lea ecx, [eax*8]
       sub ecx, eax
       lea eax, [ebx+ecx*2]
       movsx edx, byte [edx]
       imul edx, 1F8h
       lea edx, [edx+TownCreatures-4Ch]
       mov eax, [edx+eax*4]
       push 521914h
       ret
endp

proc Alternatives41
       lea ecx, [eax*8]
       sub ecx, eax
       lea eax, [ebx+ecx*2]
       movsx edx, byte [edx]
       imul edx, 1F8h
       lea edx, [edx+TownCreatures-14Ch]
       mov eax, [edx+eax*4]
       push 521958h
       ret
endp

proc Alternatives42
       movsx ecx, byte [ecx]
       imul ecx, 1F8h
       lea ecx, [ecx+TownCreatures-78h]
       mov eax, [ecx+eax*4]
       push 5C803Eh
       ret
endp

proc Alternatives43
       movsx ecx, byte [esi]
       imul ecx, 1F8h
       lea ecx,[ecx+TownCreatures-78h]
       mov edi,[ecx+eax*4]
       push 42BCD0h
       ret
endp

proc Alternatives44
       movsx edx, byte [ebx]
       imul ecx, edx, 1F8h
       lea ecx,[ecx+TownCreatures-78h]
       cmp [ecx+eax*4], edi
       push 4C69B6h
       ret
endp

; 45 - пропущен

proc Alternatives46
       movsx eax, byte [esi]
       imul eax, 1F8h
       lea eax, [eax+TownCreatures]
       mov eax, [eax+ecx*4]
       push 5BFC6Dh
       ret
endp

proc Alternatives47
       movsx eax, byte [esi]
       imul eax, 1F8h
       mov eax, dword [eax+edx*4+TownCreatures]
       push 5C009Fh
       ret
endp

proc Alternatives48
       movzx eax, word [edx+ecx*2]
       mov [ebp-20h], eax
       mov ecx, [ebx+38h]
       movsx ecx, byte [ecx]
       imul ecx, 1F8h
       lea ecx, [ecx+TownCreatures]
       mov eax, [ebp-68h]
       imul eax, 0Eh
       add eax, [ebp-64h]
       mov eax,[ecx+eax*4]
       push 70B86Ch
       ret
endp

proc ChooseAlternative
       je @f
       leave
       retn 0Ch
     @@:
       pushad
       mov ecx, [ebp+8]; номер строящегося здания
.if signed ecx > 29 & signed ecx < 37
       mov ebx, [69954Ch]
       mov ebx, [ebx+38h]; ebx = структура текущего города
       movsx eax, byte [ebx + 4]; тип города
       imul eax, 7
       lea esi, [eax + ecx - 30]
       imul esi, 24
       add esi, Alternatives_Table
       mov [Адрес_параметров_альтерветки_для_диалога_постройки_альтерветок], esi
  .if signed dword [esi+8] > -1; альтерветка для жилища существует
       stdcall InitDialog, 1986, MoPAlt_txt
       mov [ebp+10h], eax; handler
       stdcall ChangeDlgItem, eax, 100, 13, dword [69CCF4h]; Номер (цвет) текущего игрока
       xor edi, edi
   .repeat
       mov eax, [edi * 4 + esi]
       add eax, 2
       stdcall ChangeDlgItem, dword [ebp+10h], addr edi+5, 4, eax
       mov ecx, [edi * 4 + esi]
       mov eax, edi
       imul eax, 512
       add eax, 9273E8h; ERM_Z1
       stdcall CopyText, dword [ecx * 4 + Мн_имена], eax
       inc edi
   .until signed edi > 3
   .Цикл_параметров_преобразования_текста:
       mov eax, [edi * 4 + esi]
       push dword [eax * 4 + Мн_имена]
       dec edi
       jge .Цикл_параметров_преобразования_текста
     .if ~[Language]
       push AltEng
     .else
       push AltRus
     .endif
       push 697428h; TextBuffer
       mov eax, 6179DEh
       call eax; printf
       add esp, 28
       stdcall ChangeDlgItem, dword [ebp+10h], 102, 3, 697428h
     .if ~[Language]
       push AltEng1
     .else
       push AltRus1
     .endif
       stdcall ChangeDlgItem, dword [ebp+10h], 101, 3
       stdcall ShowDialog, dword [ebp+10h]
       imul edi, [esi], sizeof._Creature_
       mov edi, dword [edi + MonTable + _Creature_.Уровень]
       movsx ecx, byte [ebx]; номер города
       movsx edx, byte [ebx + 4]; тип города
       imul edx, 56
       imul ecx, 504
       add ecx, edx
       lea edi, [edi * 4 + ecx + TownCreatures]
       push dword [edi]; сохранить тип существа в стеке
      .if eax = 11
       push dword [esi]
       pop dword [edi]
       push dword [esi + 4]
       pop dword [edi + 28]
       pop eax; возвратить тип существа, который был
       .if eax <> [esi]
       stdcall Настройка_прироста_при_создании_альтерветки_в_городе, dword [esi], dword [esi+8]
       .endif
      .else
       push dword [esi + 8]
       pop dword [edi]
       push dword [esi + 12]
       pop dword [edi + 28]
       pop eax; возвратить тип существа, который был
       .if eax <> [esi + 8]
       stdcall Настройка_прироста_при_создании_альтерветки_в_городе, dword [esi + 8], dword [esi]
       .endif
      .endif
  .endif
.endif
       popad
       leave
       retn 0Ch
endp


proc Настройка_прироста_при_создании_альтерветки_в_городе uses edi esi, номер_выбранного_существа, номер_прежнего_существа
	mov edi, [69954Ch]
	mov edi, [edi+38h]
	mov esi, [номер_выбранного_существа]
; вычитание прироста от невыбранных существ
	stdcall Регулировка_прироста_альтерветок, edi, esi, [номер_прежнего_существа], 17, -1
	stdcall Регулировка_прироста_альтерветок, edi, esi, [номер_прежнего_существа], 20, -1
; добавление прироста от выбранных
	stdcall Регулировка_прироста_альтерветок, edi, esi, esi, 17, +1
	stdcall Регулировка_прироста_альтерветок, edi, esi, esi, 20, +1
	ret
endp


proc Регулировка_прироста_альтерветок uses esi edi ebx, TownStr, номер_выбранного_существа, номер_существа_в_двеллинге, DwType, sum

local Search_Object_Coordinate_X  :DWORD
local Search_Object_Coordinate_Y  :DWORD
local Search_Object_Coordinate_L  :DWORD

	mov eax, [TownStr]
	movsx ebx, byte [eax + 1]
	push -1 [DwType]
	mov eax, 72F468h; CalculateObjects
	call eax
	add esp, 8
	test eax, eax
	je .нет_двеллингов
; подсчёт жилищ, которые принадлежат игроку
	xor esi, esi; счётчик двеллингов для регулировки прироста
	xchg edi, eax; счётчик всех двеллингов
	or [Search_Object_Coordinate_X], -1
     .repeat
	mov eax, 72F67Bh
	ccall eax, [DwType], -1, addr Search_Object_Coordinate_X, addr Search_Object_Coordinate_Y, addr Search_Object_Coordinate_L, -1
	push [Search_Object_Coordinate_L] [Search_Object_Coordinate_Y] [Search_Object_Coordinate_X]
	mov eax, 711E7Fh
	call eax
	add esp, 0Ch
	push eax
	mov eax, 7112C3h
	call eax
	pop ecx
	imul eax, dword [eax], 5Ch
	mov ecx,[699538h]
	add eax,[ecx+0004E39Ch]
       .if [eax + _Dwelling_.хозяин] = bl
	mov eax, [eax+_Dwelling_.тип_монстров_в_слоте_0]
	cmp eax, [номер_существа_в_двеллинге]
	jnz @f
	add esi, [sum]
      @@:
       .endif
	dec edi
     .until ZERO?
	stdcall Регулирование_прироста_существ, [TownStr], [номер_выбранного_существа], esi
.нет_двеллингов:
	ret
endp

proc CopyText
       mov ecx,[esp+04h]
       mov edx,[esp+08h]
@@:
       mov al, [ecx]
       mov [edx], al
       test al,al
       jz @f
       inc ecx
       inc edx
       jmp @b
@@:
       retn 08h
endp

proc InitDialog
       push ebp
       mov ebp,esp
       push edi
       push 00Ch
       mov eax, 77D6B8h
       call eax
       pop ecx
       mov edi, eax
       push 0
       mov ecx, eax
       mov eax, 72B760h
       call eax
       push dword [ebp+0Ch]
       push dword [ebp+08h]
       mov ecx,eax
       mov eax, 729B27h
       call eax
       mov eax,edi
       pop edi
       leave
       retn 08h
endp

proc ShowDialog
       mov ecx, [esp+04h]
       push ecx
       push 0
       mov eax, 7291ACh
       call eax
       pop ecx
       push 1
       mov eax, 72B7F0h
       call eax
       mov eax, [6992D0h]
       mov eax,[eax+38h]
       retn 04h
endp


proc ChangeDlgItem
       push ebp
       mov ebp, esp
       push dword [ebp+14h]
       push dword [ebp+0Ch]
       push dword [ebp+10h]
       mov ecx, [ebp+08h]
       mov eax, 729992h
       call eax
       push dword [ebp+0Ch]
       mov ecx, [ebp+08h]
       mov eax, 7299FDh
       call eax
       leave
       retn 10h
endp

proc OpenCreatureWindow
       push ebp
       mov ebp,esp
       push -1
       push 62D90Bh
       mov eax, [fs:00000000h]
       push eax
       mov [fs:00000000h],esp
       sub esp,000000B8h
       push ebx
       push esi
       push edi
       push dword [ebp+14h]
       push dword [ebp+10h]
       push dword [ebp+0Ch]
       push dword [ebp+08h]
       lea ecx,[ebp-000000C4h]
       mov eax, 764AD6h
       call eax
       push -1 -1
       lea ecx, [ebp-000000C4h]
       mov dword [ebp-04h],00000000h
       mov eax, 5FF800h
       call eax
       cmp dword [ebp+18h],00000000h
       lea ecx,[ebp-000000C4h]
       jz L00732C75
       mov eax, 5F4B90h
       call eax
       jmp L00732C7A
 L00732C75:
       mov eax, 5F4BA0h
       call eax
 L00732C7A:
       lea ecx,[ebp-000000C4h]
       or dword [ebp-04h], 0FFFFFFFFh
       mov eax, 5F4980h
       call eax
       mov ecx, [ebp-0Ch]
       pop edi
       pop esi
       pop ebx
       mov [fs:00000000h],ecx
       leave
       retn 14h
endp


proc Регулирование_прироста_существ
       push ebp
       mov ebp, esp
       movsx edx, byte [ecx+04h]
       push esi
       xor eax,eax
       lea esi, [edx*8]
       push edi
       sub esi,edx
       movsx edx, byte [ecx]
       imul edx, 1F8h
       lea edx, [edx+TownCreatures]
       lea edx, [edx+esi*8]
       mov esi, [ebp+08h]
 L005C026E:
       cmp [edx],esi
       jz L005C027B
       inc eax
       add edx, 4
       cmp eax, 0Eh
       jl L005C026E
 L005C027B:
       cmp eax, 0Eh
       jz L005C029F
       mov edx, [ebp+0Ch]
       mov edi, [ecx+eax*4+118h]
       add edi,edx
       cmp eax, 7
       mov [ecx+eax*4+118h],edi
       jge L005C029F
       add [ecx+eax*4+134h],edx
 L005C029F:
       pop edi
       pop esi
       pop ebp
       retn 0Ch
endp

proc ERM_UN_Z
       sub eax, 41h
       mov [ebp-000000A4h],eax
       cmp eax, 19h
       je @f
       push 7311A6h
       ret
    @@:
; проверка количества параметров:
       cmp dword [ebp+0Ch], 5
       jge @f
       push UN_Z__insufficient_parameters
       jmp .ERROR
    @@:
; Тип города:
       push 0
       push dword [ebp+14h]
       push 4
       lea eax,[ebp-44h]
       push eax
       mov eax, 74195Dh
       call eax
       add esp, 10h
  .if signed dword [ebp-44h] < -1 | signed dword [ebp-44h] > 8
       push UN_Z__wrong_town_type__1_8
       jmp .ERROR
  .endif
  .if dword [ebp-44h] = -1
       mov eax, [69954Ch]
       mov eax, [eax+38h]; получаем структуру текущего города
       movsx eax, byte [eax+4]; получаем тип города
       mov [ebp-44h], eax
  .endif
; номер города:
       push 1
       push dword [ebp+14h]
       push 4
       lea eax,[ebp-2Ch]
       push eax
       mov eax, 74195Dh
       call eax
       add esp, 10h
  .if signed dword [ebp-2Ch] < -1 | signed dword [ebp-2Ch] > 47
       push UN_Z__wrong_town_number__1_47
       jmp .ERROR
  .endif
  .if dword [ebp-2Ch] = -1
       mov eax, [69954Ch]
       mov eax, [eax+38h]; получаем структуру текущего города
       movsx eax, byte [eax]; получаем номер города
       mov [ebp-2Ch], eax
  .endif
; Уровень жилища:
       push 2
       push dword [ebp+14h]
       push 4
       lea edx, [ebp-20h]
       push edx
       mov eax, 74195Dh
       call eax
       add esp, 10h
  .if signed dword [ebp-20h] < 0 | signed dword [ebp-20h] > 6
       push UN_Z__wrong_dwelling_number_0_6
       jmp .ERROR
  .endif
; базовый или улучшенный:
       push 3
       push dword [ebp+14h]
       push 4
       lea ecx, [ebp-0Ch]
       push ecx
       mov eax, 74195Dh
       call eax
       add esp, 10h
  .if signed dword [ebp-0Ch] < 0 | signed dword [ebp-0Ch] > 1
       push UN_Z__wrong_upgrade_0_1
       jmp .ERROR
  .endif
; Вычисление адреса:
       imul ecx, [ebp-0Ch], 1Ch; апгрейд
       imul eax, [ebp-2Ch], 504; номер города
       imul edx, [ebp-44h], 38h; тип города
       add ecx, eax
       add ecx, edx
       mov eax, [ebp-20h]; уровень жилища
       lea eax, [ecx+eax*4+TownCreatures]
       mov [ebp-2Ch], eax
; Существо:
       push 4
       push dword [ebp+14h]
       push 4
       lea ecx, [ebp-44h]
       push ecx
       mov eax, 74195Dh
       call eax
       add esp, 10h
  .if signed dword [ebp-44h] < 0 | signed dword [ebp-44h] >= MonNum
       push UN_Z__wrong_monster_type
       jmp .ERROR
  .endif
; применение команды:
       push 4
       push dword [ebp+14h]
       push 4
       push dword [ebp-2Ch]
       mov eax, 74195Dh
       call eax
       add esp, 10h
       push 733F4Dh
       ret
.ERROR:
       push 80Ch
       push 1
       mov eax, 712333h
       call eax
       add esp, 0Ch
       mov eax, 7712B0h
       call eax
       xor eax,eax
       pop edi esi ebx
       leave
       retn
  .endif
endp

proc Перед_рукопашной
       push esi edi
       call Перед_ударом
       test al, al
       je @f
       push 441C85h
       ret
@@:
; затёртый код:
       push dword [ebp+08h] esi
       push 441AE3h
       ret
endp


proc Перед_ударом uses ebx esi edi, Структура_атакующего, Структура_защитника
       mov esi, [Структура_атакующего]
       mov edi, [Структура_защитника]
       cmp [edi + Структура_стека.Контрудары], 0
       jle .нет_способности
       cmp [edi + (62*4) + Структура_стека.Длительность_заклинаний], 0; Слепота
       jnz .нет_способности
       cmp [edi + (70*4) + Структура_стека.Длительность_заклинаний], 0; Окаменение
       jnz .нет_способности
       cmp [edi + (74*4) + Структура_стека.Длительность_заклинаний], 0; Паралич
       jnz .нет_способности
       mov ecx, 2860244h; Структура_защищающегося_героя
       cmp [edi + Структура_стека.Принадлежность], 0
       jnz .защитник
       add ecx, 4
.защитник:
       bt [esi + Структура_стека.Флаги], 16; Флаг_Безответный
       jc .нет_способности
       mov eax, [edi + Структура_стека.Тип_существа]
       cmp byte [eax + PreventiveCounterstrikeTable], 0
       je .нет_способности
.есть_способность:
       mov ecx, [esi + Структура_стека.Позиция]; получить позицию атакующего
       mov eax, [edi + Структура_стека.Позиция]
       bt [edi + Структура_стека.Флаги], 0; Флаг_2_клеточность
    .if CARRY?
      .if [edi + Структура_стека.Принадлежность] = 0
       inc eax
      .else
       dec eax
      .endif
    .endif
       imul eax, 12; получить позицию защитника
       add eax, [699420h]; COMBAT_MANAGER
       add eax, 13468h; combatManager.Клетки_вокруг_монстра
       xor edx, edx
    .repeat
       cmp word [eax + edx*2], cx
       je .найдена_позиция
       inc edx
    .until signed edx > 5
.найдена_позиция:
       push edx esi
       mov ecx, edi
       mov eax, 441330h
       call eax
       dec [edi + Структура_стека.Контрудары]
       cmp [esi + (62*4) + Структура_стека.Длительность_заклинаний], 0
       jnz .отмена_удара
       cmp [esi + (70*4) + Структура_стека.Длительность_заклинаний], 0
       jnz .отмена_удара
       cmp [esi + (74*4) + Структура_стека.Длительность_заклинаний], 0
       jnz .отмена_удара
       cmp [esi + Структура_стека.Текущее_количество], 0
       sete al
       ret
.отмена_удара:
       mov al, 1
.нет_способности:
       xor al, al
       ret
endp

proc ImposedSpells1
       stdcall ImposedSpellsGeneral, dword [ebp-10h]
       push 75E9F9h
       ret
endp

proc ImposedSpells2
       stdcall ImposedSpellsGeneral, dword [ebp-0Ch]
       push 7608B1h
       ret
endp


proc ImposedSpellsGeneral
       imul edi, [esp+4], 6; существо
       add edi, ImposedSpells_Table
       xor ebx, ebx; счётчик заклинаний
@@:
       movsx eax, byte [edi+ebx]; заклинание
       test eax, eax
       jl .нет_заклинаний
       push 0
       movsx ecx, byte [edi+ebx+3]; уровень колдовства
       push ecx
       push 1000; кол-во раундов
       push eax
       push dword [ebp-4]
       mov eax, 71465Ah
       call eax
       add esp, 14h
.нет_заклинаний:
       inc ebx
       cmp ebx, 3
       jl @b
       ret 4
endp

proc DefenseBonus
       mov eax, 766C4Bh
       call eax
       mov eax, [ebx+Структура_стека.Тип_существа]
       movzx eax, byte [eax+DefenseBonus_Table]
       add [0x284642C], eax
       ret
endp

proc UNT_fix
       imul ecx, [ebp-20h], 1Ch; апгрейд
       imul edx, [ebp-44h], 38h; тип города
       add ecx, edx
       mov eax, [ebp-2Ch]; уровень жилища
       lea eax, [ecx+eax*4+TownCreatures]
       mov ecx,[ebp-0Ch]
       xor edi, edi
    @@:
       mov [eax], ecx
       inc edi
       add eax, 504
       cmp edi, 48
       jl @b
       push 733F4Dh
       ret
endp

proc Firewall
       mov eax, [ebp-2Ch]
       mov ecx, eax
       and eax, 1Fh
       shr ecx, 5
       bt dword [FireWall_Table+ecx*4], eax
       jc @f
       push 75CA76h
       ret
     @@:
       push 75CA42h
       ret
endp

; Демонология и воскрешение Архангелов
; проверка основана на таблице Properties5_Table, потому что только в ней нет пересечений между существами
; Архангел = 0, Адское Отродье = 2
proc AngDem1
       cmp byte [eax+Properties5_Table], 0
       je .ret
       cmp byte [eax+Properties5_Table], 2
       jnz .no
     .ret:
       push 4211BDh
       ret
     .no:
       push 4211C7h
       ret
endp

proc Dem1
       cmp byte [eax+Properties5_Table], 2
       mov dword [ebp-04h], 0
       je @f
       push 421218h
       ret
     @@:
       push 4211F9h
       ret
endp

proc Dem2
       mov ecx, [ecx+34h]
       cmp byte [ecx+Properties5_Table], 2
       jnz @f
       push 421280h
       ret
     @@:
       push 4212CDh
       ret
endp

proc Dem3
       mov eax, [eax+34h]
       cmp byte [eax+Properties5_Table], 2
       jnz @f
       push 421323h
       ret
     @@:
       push 421340h
       ret
endp

proc Ang1
       mov [Temp1], eax; запоминаем для последующего использования в расчете демонологии (proc Demon2)
       cmp byte [eax+Properties5_Table], 0
       jnz @f
       push 44705Fh
       ret
     @@:
       push 447098h
       ret
endp

proc AngDem2
       mov [Temp1], eax; запоминаем для последующего использования в расчете демонологии (proc Demon)
       cmp byte [eax+Properties5_Table], 0
       je .ret
       cmp byte [eax+Properties5_Table], 2
       jnz .no
     .ret:
       push 447107h
       ret
     .no:
       push 447111h
       ret
endp

proc Dem4
       mov eax, [esi+34h]
       cmp byte [eax+Properties5_Table], 2
       jnz @f
       push 44715Ah
       ret
     @@:
       push 44716Ch
       ret
endp

proc Ang2
       mov eax, [esi+34h]
       cmp byte [eax+Properties5_Table], 0
       jnz @f
       push 447194h
       ret
     @@:
       push 4471D2h
       ret
endp

proc AngDem3
       cmp byte [eax+Properties5_Table], 0
       je .ret
       cmp byte [eax+Properties5_Table], 2
       jnz .no
     .ret:
       push 44748Eh
       ret
     .no:
       push 4476F2h
       ret
endp

proc Dem5
       mov eax, [esi+34h]
       cmp byte [eax+Properties5_Table], 2
       jnz @f
       push 4474D7h
       ret
     @@:
       push 4474E6h
       ret
endp

proc AngDem4
       cmp byte [eax+Properties5_Table], 0
       je .ret
       cmp byte [eax+Properties5_Table], 2
       jnz .no
     .ret:
       push 491EA2h
       ret
     .no:
       push 491E9Dh
       ret
endp

proc Dem6
       mov eax, [ecx+34h]
       cmp byte [eax+Properties5_Table], 2
       je @f
       push 491F48h
       ret
     @@:
       push 491EE5h
       ret
endp

proc AngDem5
       cmp byte [eax+Properties5_Table], 0
       jnz @f
       push 492233h
       ret
    @@:
       cmp byte [eax+Properties5_Table], 2
       jnz @f
       push 492136h
       ret
    @@:
       push 492077h
       ret
endp

proc Ang3; расчет силы магии архангела (замена вог-хука)
       mov eax,[esi+34h]
       mov esi,[esi+4Ch]
       cmp byte [eax+Properties5_Table], 0
       je @f
       ret
     @@:
       mov eax, 0Dh
       ret
endp

proc Demon
       mov edi, [Temp1]; получить монстра-колдуна
       movsx edi, word [edi*2+Demonology_Table]
       imul edi, sizeof._Creature_
       idiv    [esi+edi+_Creature_.Здоровье]
       push 44720Ah
       ret
endp

proc Demon2
       push edi
       mov edi, [Temp1]; получить монстра-колдуна
       movsx edi, word [edi*2+Demonology_Table]
       imul edi, sizeof._Creature_
       idiv    [esi+edi+_Creature_.Здоровье]
       pop edi
       push 4470D3h
       ret
endp

proc Demon3
       mov ecx, [ebx+34h]
       movsx ecx, word [ecx*2+Demonology_Table]
       push ecx
       push eax
       mov ecx,edi
       push 5A776Fh
       ret
endp