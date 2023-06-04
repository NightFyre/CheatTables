{ Game   : metro.exe
  Version: [https://steamdb.info/app/286690/patchnotes/3790582]
  Date   : 2023-02-05
  Author : NightFyre

  This script prevents bastard weapons from overheating by moving 0 into the xmm0 register
}

[ENABLE]
aobscanmodule(BastardOverheatRate,metro.exe,F3 0F 11 83 B0 0C 00 00 48 8D) // should be unique
alloc(newmem,$1000,BastardOverheatRate)

label(code)
label(return)

NoOverheat:
dd (float)0

// Set Overheat value to NULL
newmem:
  movss xmm0,[NoOverheat]

code:
  movss [rbx+00000CB0],xmm0
  jmp return

BastardOverheatRate:
  jmp newmem
  nop 3
return:
registersymbol(BastardOverheatRate)

[DISABLE]
//code from here till the end of the code will be used to disable the cheat
BastardOverheatRate:
  db F3 0F 11 83 B0 0C 00 00

unregistersymbol(BastardOverheatRate)
dealloc(newmem)

{
// ORIGINAL CODE - INJECTION POINT: metro.exe.text+2E95B4

metro.exe.text+2E9582: 48 8B 83 B8 01 00 00     - mov rax,[rbx+000001B8]
metro.exe.text+2E9589: 48 85 C0                 - test rax,rax
metro.exe.text+2E958C: 74 08                    - je metro.exe.text+2E9596
metro.exe.text+2E958E: 48 05 58 FF FF FF        - add rax,FFFFFFFFFFFFFF58
metro.exe.text+2E9594: EB 03                    - jmp metro.exe.text+2E9599
metro.exe.text+2E9596: 48 8B C7                 - mov rax,rdi
metro.exe.text+2E9599: F3 0F 59 B0 6C 15 00 00  - mulss xmm6,[rax+0000156C]
metro.exe.text+2E95A1: F3 0F 10 83 B0 0C 00 00  - movss xmm0,[rbx+00000CB0]
metro.exe.text+2E95A9: F3 0F 5C C6              - subss xmm0,xmm6
metro.exe.text+2E95AD: 48 8B 83 B8 01 00 00     - mov rax,[rbx+000001B8]
// ---------- INJECTING HERE ----------
metro.exe.text+2E95B4: F3 0F 11 83 B0 0C 00 00  - movss [rbx+00000CB0],xmm0
// ---------- DONE INJECTING  ----------
metro.exe.text+2E95BC: 48 8D 88 58 FF FF FF     - lea rcx,[rax-000000A8]
metro.exe.text+2E95C3: 48 85 C0                 - test rax,rax
metro.exe.text+2E95C6: 75 03                    - jne metro.exe.text+2E95CB
metro.exe.text+2E95C8: 48 8B CF                 - mov rcx,rdi
metro.exe.text+2E95CB: F3 0F 10 A1 60 15 00 00  - movss xmm4,[rcx+00001560]
metro.exe.text+2E95D3: 48 85 C0                 - test rax,rax
metro.exe.text+2E95D6: 74 08                    - je metro.exe.text+2E95E0
metro.exe.text+2E95D8: 48 05 58 FF FF FF        - add rax,FFFFFFFFFFFFFF58
metro.exe.text+2E95DE: EB 03                    - jmp metro.exe.text+2E95E3
metro.exe.text+2E95E0: 48 8B C7                 - mov rax,rdi
}