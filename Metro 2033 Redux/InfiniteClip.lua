{ Game   : metro.exe
  Version: [https://steamdb.info/app/286690/patchnotes/3790582]
  Date   : 2023-02-05
  Author : NightFyre

  This script essentially moves the integer amount (1) into the r14d register.
  After doing so normal execution flow is restored.

  NOTE:
  Its unclear if this script will be sufficient for all weapon and ammo types.
  Modifications may be required to support every weapon in the game.
  More testing is required.
}

[ENABLE]
aobscanmodule(InfiniteClip,metro.exe,44 89 B6 48 04 00 00) // should be unique
alloc(newmem,$1000,InfiniteClip)
label(code)
label(return)

// Set Ammo Count to 1
newmem:
 mov r14d, 1

code:
  mov [rsi+00000448],r14d
  jmp return

InfiniteClip:
  jmp newmem
  nop 2
return:
registersymbol(InfiniteClip)

[DISABLE]
InfiniteClip:
  db 44 89 B6 48 04 00 00

unregistersymbol(InfiniteClip)
dealloc(newmem)

{
// ORIGINAL CODE - INJECTION POINT: metro.exe.text+2BFB2F

metro.exe.text+2BFB11: 0F B6 C8              - movzx ecx,al
metro.exe.text+2BFB14: 41 0F B6 C6           - movzx eax,r14l
metro.exe.text+2BFB18: 2B D1                 - sub edx,ecx
metro.exe.text+2BFB1A: 2A C1                 - sub al,cl
metro.exe.text+2BFB1C: C1 FA 1F              - sar edx,1F
metro.exe.text+2BFB1F: 22 D0                 - and dl,al
metro.exe.text+2BFB21: 02 D1                 - add dl,cl
metro.exe.text+2BFB23: 0F B6 C2              - movzx eax,dl
metro.exe.text+2BFB26: 88 86 38 0B 00 00     - mov [rsi+00000B38],al
metro.exe.text+2BFB2C: 44 2B F0              - sub r14d,eax
// ---------- INJECTING HERE ----------
metro.exe.text+2BFB2F: 44 89 B6 48 04 00 00  - mov [rsi+00000448],r14d
// ---------- DONE INJECTING  ----------
metro.exe.text+2BFB36: 48 8B 5C 24 40        - mov rbx,[rsp+40]
metro.exe.text+2BFB3B: 48 8B 6C 24 48        - mov rbp,[rsp+48]
metro.exe.text+2BFB40: 48 8B 74 24 50        - mov rsi,[rsp+50]
metro.exe.text+2BFB45: 48 83 C4 20           - add rsp,20
metro.exe.text+2BFB49: 41 5F                 - pop r15
metro.exe.text+2BFB4B: 41 5E                 - pop r14
metro.exe.text+2BFB4D: 5F                    - pop rdi
metro.exe.text+2BFB4E: C3                    - ret 
metro.exe.text+2BFB4F: 48 8B 03              - mov rax,[rbx]
metro.exe.text+2BFB52: 41 8B D6              - mov edx,r14d
}