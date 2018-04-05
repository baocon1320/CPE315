/* -- first.s */
/* This is a comment */
.global main /* 'main' is our entry point and must be global */
main: /* This is main */
mov r0, #2 /* Put a 2 inside the register r0 */
mov r1, #3 /* Put a 3 inside the register r0 */
add r0, r0, r1 /* add register r0 and r1 and place result in r0*/
bx lr /* Return from main */
