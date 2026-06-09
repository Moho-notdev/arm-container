.text
.global _start

_start:

    @ write(stdout, msg, len)

    mov r7, #4
    mov r0, #1
    ldr r1, =message
    mov r2, #message_len
    svc 0

    @ exit(0)

    mov r7, #1
    mov r0, #0
    svc 0

.data

message:
    .ascii "ciao da mohamed, aurora e tiziana\n"

message_len = . - message