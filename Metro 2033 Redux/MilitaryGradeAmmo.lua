{ Game   : metro.exe
  Version: [https://steamdb.info/app/286690/patchnotes/3790582]
  Date   : 2023-02-04
  Author : NightFyre

  This script doesn't do anything on its own except detour execution flow.
  Below is aninstruction which handles the spending and gaining of Military Grade Ammo ( $$$ )
  Some examples on utilizing this information would be to obtain a pointer to rcx
  A Pointer to RCX would allow you to modify the class members.
  MilitaryGradeAmmo is offset 0x4F4

  UPDATE:
         - Upon further reversing it seems that this instruction was also tied into AR ammo
         - This was tested at the start point ammo bench
         - This class seems to share with Artyom . . . 0x70 is a Vector 3 for LocalPlayer Position
}

[ENABLE]
aobscanmodule(ChangeMilitaryGradeAmmo,metro.exe,89 91 F4 04 00 00)
alloc(newmem,$1000,ChangeMilitaryGradeAmmo)

label(code)
label(return)

newmem:

code:
  mov [rcx+000004F4],edx
  jmp return

ChangeMilitaryGradeAmmo:
  jmp newmem
  nop
return:
registersymbol(ChangeMilitaryGradeAmmo)

[DISABLE]
ChangeMilitaryGradeAmmo:
  db 89 91 F4 04 00 00

unregistersymbol(ChangeMilitaryGradeAmmo)
dealloc(newmem)

{
// ORIGINAL CODE - INJECTION POINT: metro.exe.text+2B1729

metro.exe.text+2B1719: C3                    - ret 
metro.exe.text+2B171A: CC                    - int 3 
metro.exe.text+2B171B: CC                    - int 3 
metro.exe.text+2B171C: CC                    - int 3 
metro.exe.text+2B171D: CC                    - int 3 
metro.exe.text+2B171E: CC                    - int 3 
metro.exe.text+2B171F: CC                    - int 3 
metro.exe.text+2B1720: 40 57                 - push rdi
metro.exe.text+2B1722: 48 83 EC 20           - sub rsp,20
metro.exe.text+2B1726: 48 8B F9              - mov rdi,rcx
// ---------- INJECTING HERE ----------
metro.exe.text+2B1729: 89 91 F4 04 00 00     - mov [rcx+000004F4],edx
// ---------- DONE INJECTING  ----------
metro.exe.text+2B172F: 48 81 C1 30 04 00 00  - add rcx,00000430
metro.exe.text+2B1736: 48 8B 01              - mov rax,[rcx]
metro.exe.text+2B1739: FF 90 28 02 00 00     - call qword ptr [rax+00000228]
metro.exe.text+2B173F: 83 F8 05              - cmp eax,05
metro.exe.text+2B1742: 0F 85 CA 00 00 00     - jne metro.exe.text+2B1812
metro.exe.text+2B1748: 48 8B 87 18 01 00 00  - mov rax,[rdi+00000118]
metro.exe.text+2B174F: 33 D2                 - xor edx,edx
metro.exe.text+2B1751: 48 89 5C 24 30        - mov [rsp+30],rbx
metro.exe.text+2B1756: 8B DA                 - mov ebx,edx
metro.exe.text+2B1758: 48 85 C0              - test rax,rax
}