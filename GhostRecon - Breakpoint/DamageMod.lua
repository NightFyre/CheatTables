[ENABLE]
alloc(dmgMOD1,2048,"GRB.exe"+26130D1)
label(returnhere)
label(originalcode)
label(exit)
dmgMOD1:
mov [rax+08],(float)999

originalcode:
movss [rax+08],xmm6

exit:
jmp returnhere

"GRB.exe"+26130D1:
jmp dmgMOD1
returnhere:

alloc(dmgMOD2,2048,"GRB.exe"+261A590)
label(returnhere2)
label(originalcode2)
label(exit2)
dmgMOD2:
mov [rcx+08],(float)999

originalcode2:
movss xmm0,[rcx+08]

exit2:
jmp returnhere2

"GRB.exe"+261A590:
jmp dmgMOD2
returnhere2:

alloc(dmgMOD3,2048,"GRB.exe"+267B809)
label(returnhere3)
label(originalcode3)
label(exit3)

dmgMOD3:
mov [rcx+08],(float)999

originalcode3:
movss xmm0,[rcx+08]

exit3:
jmp returnhere3

"GRB.exe"+267B809:
jmp dmgMOD3
returnhere3:

[DISABLE]
dealloc(dmgMOD1)
"GRB.exe"+26130D1:
movss [rax+08],xmm6

dealloc(dmgMOD2)
"GRB.exe"+261A590:
movss xmm0,[rcx+08]

dealloc(dmgMOD3)
"GRB.exe"+267B809:
movss xmm0,[rcx+08]