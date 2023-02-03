[ENABLE]
alloc(newmem,2048,"GRB.exe"+263A9DB)
label(returnhere)
label(originalcode)
label(exit)

newmem:
mov [rax+0C],(float)0

originalcode:
movss xmm0,[rax+0C]

exit:
jmp returnhere

"GRB.exe"+263A9DB:
jmp newmem
returnhere:
 
[DISABLE]
dealloc(newmem)
"GRB.exe"+263A9DB:
movss xmm0,[rax+0C]
//Alt: db F3 0F 10 40 0C