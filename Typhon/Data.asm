macro Hook ExeAdress, ProcDll, HookType
{	dd ExeAdress
	dd ProcDll
	db HookType}

macro DwordByteTable [D, B]
{	dd D
	db B}
match =FALSE, COPYMODE
{
Table_Hooks:
      Hook 4EDE90h, LoadCreatures,		  TCall; �������� ���������� �������
      Hook 4EDE90h, LoadCreatures,		  TCall; �������� ���������� �������
      Hook 4FDF5Bh, SetupRandomDwellings,   TCall; ����� ���������� ��������� �����
      Hook 4FDF5Bh, SetupRandomDwellings,	  TCall; ����� ���������� ��������� �����
      Hook 760F07h, SaveParam,			  TJump; ���������� ������
      Hook 7614B3h, LoadParam,			  TJump; �������� ������
      Hook 5410FDh, MonsterRandomGeneration,	  TJump; ������ �� ������� �������
      Hook 54110Fh, MonsterRandomGeneration2,	  TJump; ������ ��� ���������� ���� � ����������
      Hook 43DA91h, ArrowTable, 		  TJump; �������
      Hook 43D6A6h, Counterstrike,		  TJump; ���������� � ������ �����
      Hook 446E77h, Counterstrike2,		  TJump; ���������� � ������ ������
      Hook 44AEF7h, AlwaysPositiveMorale,	  TJump; ������ ������������� ������ (� ����� ��������)
      Hook 44BC4Eh, AlwaysPositiveMorale2,	  TJump; ������ ������������� ������ (�����)
      Hook 767133h, AlwaysPositiveMorale3,	  TJump; ������ ������������� ������ (�� ���� ���)
      Hook 44C132h, AlwaysPositiveLuck, 	  TJump; ������ ������������� ����� (�����)
      Hook 43DCDFh, AlwaysPositiveLuck2,	  TJump; ������ ������������� ����� (�� ���� ���)
      Hook 44B11Bh, AlwaysPositiveLuck3,	  TJump; ������ ������������� ����� (� ����� ��������)
      Hook 445AAFh, Ballistic,			  TJump; ���������� �������
      Hook 766CE8h, DeathBlow,			  TJump; ����������� ����
      Hook 4436DEh, DeathBlowCorrect,		  TJump; ���������� ���� ������������� ������� ����� ��������� ������ � ����� �������; ����������� ���-�������� � ������������ � ������������ ���-����������
      Hook 43F72Ch, DeathCloudAndFireBall,	  TJump; ����� ������� ������ � �������� �����
      Hook 41ED5Ah, DeathCloudAndFireBall2,	  TJump; ����� ������� ������ � �������� �����
      Hook 4E605Ch, Espionage,			  TJump; �������
      Hook 7604F1h, Fear,			  TJump; �����
      Hook 760481h, Fearless,			  TJump; ����������
      Hook 760590h, NoWallPenalty,		  TJump; ��� ������ �������
      Hook 767244h, MagicAura,			  TJump; ���������� ����
      Hook 76729Fh, MagicAura,			  TJump; ���������� ���� (���-������� ���������, ��� ��� �������� ��� �� ���)
      Hook 4225D6h, FireShield, 		  TJump; �������� ���
      Hook 442E61h, FireShield2,		  TJump; �������� ���
      Hook 4227F2h, FireShield3,		  TJump; �������� ��� (��)
      Hook 75E059h, StrikeAndReturn,		  TJump; ����� � ���������
      Hook 762940h, StrikeAndReturn2,		  TJump; ����� � ��������� (����� ������ ���������)
      Hook 421C0Dh, StrikeAndReturn3,		  TJump; ����� � ��������� (��)
      Hook 766BCCh, SpellsCostLess,		  TJump; ���������� ��������� ���������� ��� �������
      Hook 4E554Ch, SpellsCostDump,		  TJump; ���������� ��������� ���������� ��� �����
      Hook 44022Bh, Properties1,		  TJump; �������� ��� ����� �1
      Hook 440906h, Properties2,		  TJump; �������� ��� ����� �2
      Hook 447465h, Properties3,		  TJump; ���. ��������
      Hook 42146Dh, Properties4,		  TJump; ���. ��������
      Hook 448248h, Properties5,		  TJump; ���. ��������
      Hook 492A53h, Properties5_1,		  TJump; ���. ��������
      Hook 492D03h, Properties5_2,		  TJump; ���. ��������, ����������
      Hook 44A4A7h, Immun,			  TJump; ����������
      Hook 75D9FCh, GnomResistance,		  TJump; ������ �������������
      Hook 44B187h, GolemResistance,		  TJump; �������� �������������
      Hook 4483C4h, Spells,			  TJump; �����, ����������
      Hook 4476C8h, Spells2,			  TJump; �����, ����������
      Hook 75D0F2h, Spells3,			  TJump; ������� ����������
      Hook 75CDE2h, Spells4,			  TJump; ������� ����������
      Hook 75CEDDh, SantaFix,			  TJump; ������ ������ ��� �����
      Hook 766E57h, Hate,			  TJump; ���������
      Hook 75D823h, JoustingBonus,		  TJump; ������������� �����
      Hook 44307Ah, ImmunToJoustingBonus,	  TJump; ��������� � �������������� ������
      Hook 75DE5Bh, Regeneration,		  TJump; �����������
      Hook 441386h, ThreeHeadedAttack,		  TJump; ����� ����� ��������
      Hook 4487E9h, ThreeHeadedAttack2, 	  TJump; ����� ����� ��������
      Hook 4650D0h, ManaDrain,			  TJump; ����� ���� (������� �����������)
      Hook 465174h, ManaDrain2, 		  TJump; ����� ���� (���-�� �����)
      Hook 5A24DCh, MagicChannel,		  TJump; ���������� �����
      Hook 448528h, MagicMirror,		  TJump; ��������� �������
      Hook 75DD50h, Sharpshooters,		  TJump; �����������
      Hook 767195h, ShootingAdjacent,		  TJump; �������� ��������
      Hook 75D4A0h, ReduceTargetDefense,	  TJump; �������� ������ �����
      Hook 4422E3h, ReduceTargetDefense2,	  TJump; �������� ������ �����
      Hook 75E108h, Rebirth,			  TJump; �����������
      Hook 443D15h, ProtectFromShooting1,	  TJump; ������ �� ����� (��� ��������� ����)
      Hook 4427ECh, ProtectFromShooting2,	  TJump; ������ �� ����� (��)
      Hook 443ACBh, ProtectFromShooting3,	  TJump; ������ �� �����
      Hook 443BB7h, ProtectFromShooting4,	  TJump; ������ �� �����
      Hook 43F271h, RayColor,			  TJump; ���� ����
      Hook 5D6C04h, ChooseAlternative,		  TJump; ��������� �����������
      Hook 551A14h, Alternatives01,		  TJump; �����������
      Hook 5C7196h, Alternatives02,		  TJump; �����������
      Hook 5C6023h, Alternatives03,		  TJump; �����������
      Hook 5BFFDFh, Alternatives04,		  TJump; �����������
      Hook 5D9DE4h, Alternatives05,		  TJump; �����������
      Hook 5DD96Bh, Alternatives06,		  TJump; �����������
      Hook 5DDAD6h, Alternatives07,		  TJump; �����������
      Hook 5DD099h, Alternatives08,		  TJump; �����������
      Hook 5519A7h, Alternatives09,		  TJump; �����������
      Hook 4285FCh, Alternatives10,		  TJump; �����������
      Hook 428964h, Alternatives11,		  TJump; �����������
      Hook 429BB1h, Alternatives12,		  TJump; �����������
      Hook 429DECh, Alternatives13,		  TJump; �����������
      Hook 429F32h, Alternatives14,		  TJump; �����������
      Hook 42A026h, Alternatives15,		  TJump; �����������
      Hook 42B538h, Alternatives16,		  TJump; �����������
      Hook 42B5D9h, Alternatives1718,		  TJump; �����������
      Hook 42B724h, Alternatives19,		  TJump; �����������
      Hook 42BE42h, Alternatives20,		  TJump; �����������
      Hook 42CF07h, Alternatives21,		  TJump; �����������
      Hook 42D23Fh, Alternatives22,		  TJump; �����������
      Hook 432E85h, Alternatives23,		  TJump; �����������
      Hook 432F5Fh, Alternatives24,		  TJump; �����������
      Hook 43363Bh, Alternatives25,		  TJump; �����������
      Hook 4C8D2Dh, Alternatives26,		  TJump; �����������
      Hook 4BF302h, Alternatives2728,		  TJump; �����������
      Hook 51CFD8h, Alternatives29,		  TJump; �����������
      Hook 525A8Bh, Alternatives3031,		  TJump; �����������
      Hook 52A31Bh, Alternatives32,		  TJump; �����������
      Hook 551B57h, Alternatives33,		  TJump; �����������
      Hook 5BEF9Eh, Alternatives34,		  TJump; �����������
      Hook 5C7CE5h, Alternatives35,		  TJump; �����������
      Hook 5C7D1Eh, Alternatives36,		  TJump; �����������
      Hook 5C0250h, Alternatives37,		  TJump; �����������
      Hook 5219AFh, Alternatives38,		  TJump; �����������
      Hook 5218F1h, Alternatives39,		  TJump; �����������
      Hook 521901h, Alternatives40,		  TJump; �����������
      Hook 521945h, Alternatives41,		  TJump; �����������
      Hook 5C8037h, Alternatives42,		  TJump; �����������
      Hook 42BCC9h, Alternatives43,		  TJump; �����������
      Hook 4C69AFh, Alternatives44,		  TJump; �����������
      Hook 5BFC66h, Alternatives46,		  TJump; �����������
      Hook 5C0098h, Alternatives47,		  TJump; �����������
      Hook 70B844h, Alternatives48,		  TJump; �����������
      Hook 731197h, ERM_UN_Z,			  TJump; ���������� ERM-������� UN:Z
      Hook 441ADEh, �����_����������,		  TJump; ����� ������ ������
      Hook 75E8F9h, ImposedSpells1,		  TJump; ��������� ���������� � ������ �����
      Hook 7607B1h, ImposedSpells2,		  TJump; ��������� ���������� � ������ ������
      Hook 766C9Bh, DefenseBonus,		  TCall; ����� ������ ��� ��������� � �������
      Hook 732CE1h, UNT_fix,			  TJump; ���� ������� UN:T ��� ������ �����, �� ������������ �����������
      Hook 75CA39h, Firewall,			  TJump; �������� �����
      Hook 4211B3h, AngDem1,			  TJump; ���� ����������� � ����������� ����������
      Hook 4211EDh, Dem1,			  TJump
      Hook 42127Ah, Dem2,			  TJump
      Hook 42131Dh, Dem3,			  TJump
      Hook 44705Ah, Ang1,			  TJump
      Hook 4470FDh, AngDem2,			  TJump
      Hook 447154h, Dem4,			  TJump
      Hook 44718Eh, Ang2,			  TJump
      Hook 447480h, AngDem3,			  TJump
      Hook 4474D1h, Dem5,			  TJump
      Hook 491E93h, AngDem4,			  TJump
      Hook 491F42h, Dem6,			  TJump
      Hook 492065h, AngDem5,			  TJump
      Hook 5A87ADh, Ang3,			  TCall; ������ ���� ����� ��������� (������ ���-����)
      Hook 447204h, Demon,			  TJump
      Hook 4470CDh, Demon2,			  TJump
      Hook 5A776Ah, Demon3,			  TJump
End_Table_Hooks = $
; ������ ��� ��������� ���-�� ������� � ����:
ChangeNumMon = $
   dd 756410h, 7504F8h, 732CA9h, 733326h, 726511h, 71B02Dh, 718153h, 71A9F8h, 723B66h, 721818h, 723973h, 723D58h, 726127h, 726177h, 726366h, 7263D0h,\
      73A84Ah, 7401CEh, 740282h, 7402FBh, 749E4Fh, 750493h, 75054Bh, 75059Ch, 750821h, 7508A8h, 7521A7h, 752E2Ah, 752F0Bh, 756A43h, 756A9Dh, 760F41h,\
      7614E0h, 7183FCh, 4A1657h, 4A189Ch, 40C2B1h, 43FE26h, 44192Fh, 479143h, 4925BFh, 49295Ah, 4A6A7Fh, 4A6C98h, 4DBA62h, 4F5BD2h, 5213E6h,\
      52141Eh, 521813h, 521837h, 52191Dh, 52195Dh, 5219BEh, 5219CFh, 5219F9h, 52FEF9h, 52FF5Dh, 52FFBBh, 550826h, 551D90h, 5C605Dh, 5C656Bh, 5C84B1h,\
      5DD977h, 5F393Ah, 5F40CDh, 5DDA4Bh, 47ADEDh, 47AE7Dh, 47B04Eh, 47B0E6h, 47B106h, 47B126h, 40AC92h, 40ACF3h, 416949h, 43F9B3h, 43FA89h, 43FDA9h,\
      4401B6h, 4409D8h, 440A22h, 440A86h, 440C9Bh, 440CD6h, 440D4Ah, 440D87h, 440F5Ch, 4418D1h, 443266h, 44329Bh, 443308h, 44333Dh, 44372Ch, 443798h,\
      446C87h, 446CF5h, 44730Fh, 44BB15h, 44BC65h, 44C062h, 464671h, 46487Bh, 464A92h, 465243h, 4652E5h, 478594h, 4785CCh, 4790D8h, 479280h, 47931Ch,\
      4840B3h, 4863FEh, 491F66h, 491FB6h, 4920ABh, 4921A3h, 4921EEh, 4922B7h, 4922EEh, 49233Fh, 492376h, 492522h, 492630h, 4926CAh, 49275Eh, 4927E9h,\
      492D0Ch, 492DAEh, 49E707h, 49E72Ah, 49EE74h, 49EFC1h, 4A0437h, 4A04D9h, 4A17DAh, 4A1804h, 4A1829h, 4A184Eh, 4A19FCh, 4A1AA1h, 4A42F2h, 4A6F59h,\
      4A6FC7h, 4AB895h, 4ABC6Dh, 4ABF69h, 4AE280h, 4AE2CEh, 4CC86Eh, 4CC8CAh, 4CC989h, 4DBA9Fh, 4DBAE2h, 4DBB2Eh, 4DBB75h, 4DBB98h, 4F1F89h, 4F2011h,\
      4F20D7h, 4F2139h, 4F479Ch, 4F5C4Ch, 51402Fh, 514079h, 5217C8h, 55036Fh, 55113Fh, 5632DCh, 565366h, 56637Ch, 5664C9h, 56EBD4h, 56ECD5h, 56F116h,\
      5706A6h, 570A6Fh, 570D4Eh, 59F90Ch, 5A21EEh, 5A22E7h, 5A2CC4h, 5A2DCFh, 5A2E29h, 5A753Bh, 5A77C2h, 5A77FDh, 5A79B3h, 5A79EEh, 5A7D4Dh, 5A7DBDh,\
      5A8A0Ah, 5A8A6Bh, 5A8B54h, 5A9379h, 5B0E0Bh, 5C08ECh, 5C789Bh, 5C7947h, 5C79BDh, 5C7A1Eh, 5C7AB1h, 5C7B27h, 5C7B49h, 5C7FD5h, 5C8047h, 5C9C3Bh,\
      5D0C57h, 5D105Bh, 5DD0A5h, 5EF08Dh, 4288E4h, 4288A6h, 74EC6Fh, 74ED0Ch, 72476Bh, 71EF50h, 750D8Dh, 724A89h, 4CF73Ch, 4CF7AAh, 48E61Fh, 541064h,\
      5410B4h, 71B23Eh, 71A9DAh, 7278CCh, 71A8A6h, 724B15h
EndChangeNumMon = $
; ����� ������� ������ �� ����� ������� � ������������ �����:
_MonNames1:
   dd 733459h, 73351Bh, 750C72h, 750D14h, 750D9Fh, 752280h, 47AE2Bh, 47ADF6h, 47B12Dh
; ����� ������� ������ �� ����� ������� �� ��. �����:
_MonNames2:
   dd 73348Eh, 733547h, 750CA1h, 750D43h, 750DB5h, 7522B5h, 76C532h, 76C5ACh, 47AEBFh, 47AE86h, 47B10Dh
; ����� ������� ������ �� �������� �������:
_MonNames3:
   dd 7334C3h, 733573h, 750CD0h, 750D72h, 750DCBh, 7522EBh, 47B094h, 47B058h, 47B0EDh
ChangeMonTable = $
; ����� ������� �������
; ��������������� ����������: �����, ��������
DwordByteTable\
      47ADD1h, 000, 6747B0h, 000, 7505D2h, 000, 7508E0h, 000, 756473h, 000, 756482h, 000, 756492h, 000, 7564A1h, 000, 760F55h, 000, 7613AEh, 000,\
      7613CAh, 000, 76150Ch, 000, 7626E0h, 000, 76C05Ch, 000, 76DBEDh, 000, 71F26Eh, 024, 71F252h, 020, 756455h, 000, 7564CAh, 004, 7568C5h, 016,\
      733440h, 020, 733475h, 024, 7334ABh, 028, 756579h, 032, 7565AFh, 060, 7565E5h, 064, 75661Bh, 068, 756651h, 072, 756687h, 076, 7566BDh, 080,\
      756713h, 084, 75674Ah, 088, 756781h, 092, 7567B8h, 096, 7567EFh, 100, 756826h, 104, 75685Dh, 108, 756894h, 112, 70B54Ch, 076, 718EC4h, 004,\
      718F2Bh, 004, 71AA0Fh, 004, 71AFACh, 016, 71AFBBh, 016, 71AFC7h, 100, 71AFD9h, 016, 71AFE8h, 016, 71B054h, 004, 71B480h, 016, 71B48Fh, 016,\
      71B49Bh, 100, 71B4ADh, 016, 71B4BCh, 016, 721826h, 024, 7219BAh, 024, 723981h, 024, 723B74h, 024, 723D66h, 024, 724E05h, 020, 7275EDh, 004,\
      733507h, 020, 733533h, 024, 73355Fh, 028, 7505EAh, 004, 750602h, 016, 750639h, 032, 750654h, 060, 75066Ch, 064, 750684h, 068, 75069Ch, 072,\
      7506B4h, 076, 7506CCh, 080, 7506E4h, 084, 7506FCh, 088, 750714h, 092, 75072Ch, 096, 750744h, 100, 75075Ch, 104, 750774h, 108, 75078Ch, 112,\
      7508F8h, 004, 750910h, 016, 750948h, 032, 750962h, 060, 75097Ah, 064, 750992h, 068, 7509AAh, 072, 7509C2h, 076, 7509DAh, 080, 7509F2h, 084,\
      750A0Ah, 088, 750A22h, 092, 750A3Ah, 096, 750A52h, 100, 750A6Ah, 104, 750A82h, 108, 750A9Ah, 112, 750DA5h, 020, 750DBBh, 024, 750DD1h, 028,\
      752267h, 020, 75229Dh, 024, 7522D2h, 028, 7564E8h, 004, 7564F7h, 004, 756507h, 004, 756516h, 004, 7566DBh, 080, 7566EAh, 080, 757341h, 020,\
      75735Dh, 024, 757382h, 024, 75A0B5h, 064, 75A7D3h, 076, 75A83Ch, 076, 75DB00h, 016, 75DB20h, 016, 75DB4Ah, 016, 760F7Fh, 004, 760FA8h, 016,\
      760FD2h, 032, 760FFCh, 036, 761025h, 040, 76104Fh, 044, 761079h, 048, 7610A2h, 052, 7610CCh, 056, 7610F6h, 060, 76111Fh, 064, 761149h, 068,\
      761173h, 072, 76119Ch, 076, 7611C6h, 080, 7611F0h, 084, 761219h, 088, 761243h, 092, 76126Dh, 096, 761296h, 100, 7612C0h, 104, 7612EAh, 108,\
      761310h, 112, 761536h, 004, 76155Fh, 016, 761589h, 032, 7615B3h, 036, 7615DCh, 040, 761606h, 044, 761630h, 048, 761659h, 052, 761683h, 056,\
      7616ADh, 060, 7616D6h, 064, 761700h, 068, 76172Ah, 072, 761753h, 076, 76177Dh, 080, 7617A7h, 084, 7617D0h, 088, 7617FAh, 092, 761824h, 096,\
      76184Dh, 100, 761877h, 104, 7618A1h, 108, 7618CAh, 112, 767679h, 020, 76768Ah, 024, 76798Bh, 076, 76C99Ch, 016, 76C9ABh, 016
ChangeCrexbon = $
   dd 71AB37h, 71AB9Fh, 71AD83h, 71B042h, 71B251h, 7280FEh, 728138h, 728188h
ChangeUpgrades = $
   dd 724A95h, 724AABh, 74EC7Dh, 74EC97h, 74ED1Ah, 74ED36h, 75137Eh, 751EC5h, 7568F4h
ChangeSkeletonTransformer = $
   dd 5664B8h, 5668A0h, 566D7Ch, 566F3Fh, 566FA7h, 566FD4h
End_Changes = $

PrShoot1C671 dw 100
PrShoot4AEFF dw 1
}
_�����:       dd _�����_eng, _�����_rus
_��_�����:    dd _��_�����_eng, _��_�����_rus
_�����������: dd _�����������_eng, _�����������_rus

_�����_eng	 db 'EraPlugins\MCrEdit\eng\Monsters.txt', 0
_�����_rus	 db 'EraPlugins\MCrEdit\rus\Monsters.txt', 0
_��_�����_eng	 db 'EraPlugins\MCrEdit\eng\Plural.txt', 0
_��_�����_rus	 db 'EraPlugins\MCrEdit\rus\Plural.txt', 0
_�����������_eng db 'EraPlugins\MCrEdit\eng\Ability.txt', 0
_�����������_rus db 'EraPlugins\MCrEdit\rus\Ability.txt', 0

TownsSetup_mop db 'EraPlugins\MTwEdit\TownsSetup.mop', 0
MonstersSetup_mop db 'EraPlugins\MCrEdit\MonstersSetup.mop', 0
ImposedSpells_mop db 'EraPlugins\MCrEdit\ImposedSpells.mop', 0
DefenseBonus_mop db 'EraPlugins\MCrEdit\DefenseBonus.mop', 0
Ammo_mop db 'EraPlugins\MCrEdit\Ammo.mop', 0
FireWall_mop db 'EraPlugins\MCrEdit\FireWall.mop', 0
Demonology_mop db 'EraPlugins\MCrEdit\Demonology.mop', 0
Lang db 'EraPlugins\MCrEdit\Lang', 0
MoPAlt_txt db 'MoPAlt.txt', 0


PlusLuckRusText db 0Ah, '%s ������ ��������.', 0
PlusLuckEngText db 0Ah, '%s are always lucky.', 0

AltEng1 db 'Choose the development way', 0
AltRus1 db '����� ���� ��������', 0
AltEng db 'This structure has two ways of development.', 0Ah, 'Depending on what you choose there can live %s and %s or %s and %s.', 0Ah, 0Ah, 'You can click on creatures portraits to overview their characteristics.', 0
AltRus db '��� ������ ����� ��� ���� ��������.', 0Ah, '� ����������� �� ������ � �� ����� ������� ���� %s � %s, ���� %s � %s.', 0Ah, 0Ah, '���� �� �������� �������� ��� ��������� ��� �������������.', 0

UN_Z__insufficient_parameters db '"!!UN:Z"-insufficient parameters.', 0
UN_Z__wrong_town_type__1_8 db '"!!UN:Z"-wrong town type(-1...8).', 0
UN_Z__wrong_town_number__1_47 db '"!!UN:Z"-wrong town number(-1...47).', 0
UN_Z__wrong_dwelling_number_0_6 db  '"!!UN:Z"-wrong dwelling number(0...6).', 0
UN_Z__wrong_upgrade_0_1 db '"!!UN:Z"-wrong upgrade(0,1).', 0
UN_Z__wrong_monster_type db '"!!UN:Z"-wrong monster type.', 0

LODDEF db '[LODDEF]Typhon.pac;TwCrPort.def;',0

Load_File_Error_Title_Eng db '�����: ������', 0
Load_File_Error_Title_Rus db 'Typhon: error', 0

Load_File_Error_Text_Eng db '�����: ���� %s �� ������', 0
Load_File_Error_Text_Rus db 'Typhon: file %s is not found', 0