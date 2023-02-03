[ENABLE]
alloc(newmem,2048,"GRB.exe"+2A1779A)
label(returnhere)
label(exit)

newmem:
nop
nop dword ptr [rax]

exit:
jmp returnhere

"GRB.exe"+2A1779A:
jmp newmem
nop
returnhere:

[DISABLE]
dealloc(newmem)
"GRB.exe"+2A1779A:
mov byte ptr [rdx],00
nop dword ptr [rax]