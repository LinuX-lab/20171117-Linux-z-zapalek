SECTION .data
    message: db 'Hello, LinuX-LAB!',0x0a
    length:    equ    $-message

SECTION .text
global _start   
_start:
        mov    rax, 1          ; 'write' syscall
        mov    rdi, 1          ; uchwyt pliku (stdout)
        mov    rsi, message    ; adres danych
        mov    rdx, length     ; dlugosc danych
        syscall

        mov    rax, 60         ; 'exit' syscall
        mov    rdi, 0          ; kod powrotu
        syscall
