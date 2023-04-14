;
;%include "macro.c"
global _main
extern _printf,_gets,_puts,_putc,_scanf
section .data
msg db "Input Polymer:",0xa,0
input times 32 db  0
fmtPoly times 34 db  "%s .",0
scanInt db "%d",0
intNum dd 0
lf db 0xa,0
len db 0
inv times 31 db 0
badString db "Invalid input",0
proInv db "Inverse String",0
pPal db "Reverse Palindrome:",0
noMsg db "no",10,0
yesMsg db "yes",10,0
cntMsg db "Continue [y/n]?",0
section .text
_main:
    mov ebp, esp; for correct debugging
    ;write your code here


    push msg
    call _printf
    add esp,4
    push input
    call _gets
    add esp,4
    lea esi, [input]
    mov ecx,  esi
    
    lea edi, [inv]

strlen:
 
    mov al,[ecx]
    
    cmp al, 10
    je L2
    cmp al, 0x0
    je L2
    cmp al, 'A'
    je cont
    cmp al, 'C'
    je cont
    cmp al, 'G'
    je cont
    cmp al, 'T'
    je cont
    jne err
    mov edx, ecx
    sub edx,esi
    mov [len], edx
    mov edx,0    

L2: 

        dec ecx
    mov eax, 0
    mov al,[ecx]
A:
    mov bl, 'T'
    cmp al, 'A'
    je rev


    
C:  
    mov bl, 'G'
    cmp al, 'C'
    je rev
    

G:  
    mov bl, 'C'
    cmp al, 'G'
    je rev
T:  
    mov bl, 'A'
    cmp al, 'T'
    je rev    
    
nxt:

    cmp ecx,esi
    jg L2
    ;mov esi,ecx
    mov ecx,0
    mov dl,[len]
    lea edi, [inv]
    lea esi, [input]
pal_check:
    mov al, [esi+ecx]
    mov bl, [edi+ecx]
    cmp al, bl
    jne no_pal    
    inc cl
    cmp cl, dl
    jg pal_check
    push yesMsg
    call _puts
    add esp,4
end:
    
    

    
    
    ;push ecx
    ;push scanInt
    ;call _printf
    ;add esp,8
    
    push lf
    call _puts
    add esp,4
    push inv
    call _puts
    add esp,4
    
    
    
prompt:
    push lf
    call _puts
    add esp,4
    push cntMSg
    call _puts
    add esp,4
    GET_STRING string,3
    mov al,[string]

    cmp al, 'y'
    je main
    cmp al, 'n'
    je stop
    jmp err
    jmp prompt
stop:    ret
    
err:
    push lf
    call _puts
    add esp,4
    push badString
    call _puts
    add esp,4
    jmp prompt

rev:
    mov [edi],bl
    inc edi
    ;push inv
    jmp nxt
    
cont:    
    inc ecx
    jmp strlen
no_pal:
   push noMsg
    call _puts
    add esp,4
    jmp prompt