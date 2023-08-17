[bits 64]
section .data
    num:
        dd 100
section .text
    mov word eax, [num]