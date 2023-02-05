{ Game   : metro.exe
  Version: [https://steamdb.info/app/286690/patchnotes/3790582]
  Date   : 2023-02-05
  Author : NightFyre

  Essentially this makes it so that ammo and money will never deplete below 50
  Whenever this function is fired 50 is moved into EDX
  a few instructions later the value of EDX is moved into rcx+0x4F4

  Offset 0x4F4 is where Current Ammo & $$ reside in their respective classes
(chances are they share the very same class, but I have not determined as much at this point)
}

[ENABLE]
aobscanmodule(Set4F4,metro.exe,40 57 48 83 EC 20 48 8B F9 89) // should be unique
alloc(newmem,$1000,Set4F4)
label(code)
label(return)

newmem:
mov edx, 50
code:
  push rdi
  sub rsp,20
  jmp return

Set4F4:
  jmp newmem
  nop
return:
registersymbol(Set4F4)

[DISABLE]
Set4F4:
  db 40 57 48 83 EC 20

unregistersymbol(Set4F4)
dealloc(newmem)

{
// ORIGINAL CODE - INJECTION POINT: metro.exe.text+2B1720
metro.exe.text+2B170E: 48 8B 7C 24 40        - mov rdi,[rsp+40]
metro.exe.text+2B1713: 48 83 C4 20           - add rsp,20
metro.exe.text+2B1717: 41 5E                 - pop r14
metro.exe.text+2B1719: C3                    - ret 
metro.exe.text+2B171A: CC                    - int 3 
metro.exe.text+2B171B: CC                    - int 3 
metro.exe.text+2B171C: CC                    - int 3 
metro.exe.text+2B171D: CC                    - int 3 
metro.exe.text+2B171E: CC                    - int 3 
metro.exe.text+2B171F: CC                    - int 3 
// ---------- INJECTING HERE ----------
metro.exe.text+2B1720: 40 57                 - push rdi
// ---------- DONE INJECTING  ----------
metro.exe.text+2B1722 - 48 83 EC 20           - sub rsp,20
metro.exe.text+2B1726 - 48 8B F9              - mov rdi,rcx
metro.exe.text+2B1729 - 89 91 F4040000        - mov [rcx+000004F4],edx <-- Instruction that increases / decreases inventory item count
metro.exe.text+2B172F - 48 81 C1 30040000     - add rcx,00000430
metro.exe.text+2B1736 - 48 8B 01              - mov rax,[rcx]
metro.exe.text+2B1739 - FF 90 28020000        - call qword ptr [rax+00000228]
metro.exe.text+2B173F - 83 F8 05              - cmp eax,05
metro.exe.text+2B1742 - 0F85 CA000000         - jne metro.exe.text+2B1812
metro.exe.text+2B1748 - 48 8B 87 18010000     - mov rax,[rdi+00000118]
metro.exe.text+2B174F - 33 D2                 - xor edx,edx
metro.exe.text+2B1751 - 48 89 5C 24 30        - mov [rsp+30],rbx
metro.exe.text+2B1756 - 8B DA                 - mov ebx,edx
metro.exe.text+2B1758 - 48 85 C0              - test rax,rax
metro.exe.text+2B175B - 74 07                 - je metro.exe.text+2B1764
metro.exe.text+2B175D - 48 8B D8              - mov rbx,rax
metro.exe.text+2B1760 - F0 FF 40 08           - lock inc [rax+08]
metro.exe.text+2B1764 - 48 8B 05 3DF7A400     - mov rax,[metro.exe+D01EA8]
metro.exe.text+2B176B - 48 8B 40 38           - mov rax,[rax+38]
metro.exe.text+2B176F - 48 85 C0              - test rax,rax
metro.exe.text+2B1772 - 74 08                 - je metro.exe.text+2B177C
metro.exe.text+2B1774 - 48 05 A0000000        - add rax,000000A0
metro.exe.text+2B177A - EB 03                 - jmp metro.exe.text+2B177F
metro.exe.text+2B177C - 48 8B C2              - mov rax,rdx
metro.exe.text+2B177F - 48 85 DB              - test rbx,rbx
metro.exe.text+2B1782 - 74 05                 - je metro.exe.text+2B1789
metro.exe.text+2B1784 - 48 39 13              - cmp [rbx],rdx
metro.exe.text+2B1787 - 75 05                 - jne metro.exe.text+2B178E
metro.exe.text+2B1789 - 48 85 C0              - test rax,rax
metro.exe.text+2B178C - 74 27                 - je metro.exe.text+2B17B5
metro.exe.text+2B178E - 48 85 DB              - test rbx,rbx
metro.exe.text+2B1791 - 74 7A                 - je metro.exe.text+2B180D
metro.exe.text+2B1793 - 48 8B 0B              - mov rcx,[rbx]
metro.exe.text+2B1796 - 48 85 C9              - test rcx,rcx
metro.exe.text+2B1799 - 74 4A                 - je metro.exe.text+2B17E5
metro.exe.text+2B179B - 48 85 C0              - test rax,rax
metro.exe.text+2B179E - 74 45                 - je metro.exe.text+2B17E5
metro.exe.text+2B17A0 - 48 81 C1 60FFFFFF     - add rcx,FFFFFFFFFFFFFF60
metro.exe.text+2B17A7 - 74 07                 - je metro.exe.text+2B17B0
metro.exe.text+2B17A9 - 48 8D 91 A0000000     - lea rdx,[rcx+000000A0]
metro.exe.text+2B17B0 - 48 3B D0              - cmp rdx,rax
metro.exe.text+2B17B3 - 75 30                 - jne metro.exe.text+2B17E5
metro.exe.text+2B17B5 - 48 85 DB              - test rbx,rbx
metro.exe.text+2B17B8 - 74 53                 - je metro.exe.text+2B180D
metro.exe.text+2B17BA - 48 8B 0B              - mov rcx,[rbx]
metro.exe.text+2B17BD - 48 85 C9              - test rcx,rcx
metro.exe.text+2B17C0 - 74 23                 - je metro.exe.text+2B17E5
metro.exe.text+2B17C2 - 48 81 C1 60FFFFFF     - add rcx,FFFFFFFFFFFFFF60
metro.exe.text+2B17C9 - 48 8B 01              - mov rax,[rcx]
metro.exe.text+2B17CC - FF 90 D8060000        - call qword ptr [rax+000006D8]
metro.exe.text+2B17D2 - 48 85 C0              - test rax,rax
metro.exe.text+2B17D5 - 74 0E                 - je metro.exe.text+2B17E5
metro.exe.text+2B17D7 - 8B 97 F4040000        - mov edx,[rdi+000004F4]
metro.exe.text+2B17DD - 48 8B C8              - mov rcx,rax
metro.exe.text+2B17E0 - E8 5B45FDFF           - call metro.exe.text+285D40
metro.exe.text+2B17E5 - 48 85 DB              - test rbx,rbx
metro.exe.text+2B17E8 - 74 23                 - je metro.exe.text+2B180D
metro.exe.text+2B17EA - 83 C8 FF              - or eax,-01
metro.exe.text+2B17ED - F0 0FC1 43 08         - lock xadd [rbx+08],eax
metro.exe.text+2B17F2 - 83 F8 01              - cmp eax,01
metro.exe.text+2B17F5 - 75 16                 - jne metro.exe.text+2B180D
metro.exe.text+2B17F7 - B9 FDFFFFBF           - mov ecx,BFFFFFFD
metro.exe.text+2B17FC - 33 C0                 - xor eax,eax
metro.exe.text+2B17FE - F0 0FB1 4B 08         - lock cmpxchg [rbx+08],ecx
metro.exe.text+2B1803 - 75 08                 - jne metro.exe.text+2B180D
metro.exe.text+2B1805 - 48 8B CB              - mov rcx,rbx
metro.exe.text+2B1808 - E8 B3B03800           - call metro.exe.text+63C8C0
metro.exe.text+2B180D - 48 8B 5C 24 30        - mov rbx,[rsp+30]
metro.exe.text+2B1812 - 48 83 C4 20           - add rsp,20
metro.exe.text+2B1816 - 5F                    - pop rdi
metro.exe.text+2B1817 - C3                    - ret

}