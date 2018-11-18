%include "asm_io.inc"

segment .data               ; espaço para variáveis inicializadas
    pilares dd 0            ; quantidade de pilares 
    pontes dd 0             ; quantidade de pontes
    pilarDe dd 0            ; numero do pilar inicial 
    pilarPara dd 0          ; numero do pilar destino
    buracos dd 0            ; quantidade de buracos entre o pilar inicial e o pilar destino
    no db -1
    i db 0
    zero db 0
    minusone db -1
    ; O valor de N é considerado no máximo e com uma margem de erro de 10 pra mais
    A times 3600 db 0x3f            ; A = matriz NxN
    visitado times 60 db 0x0        ; visitado = vetor[N] 
    dis times 60 db 0x3f             ; dis = vetor[N] 

segment .bss                ; espaço para variáveis reservadas
    espaco resb 1           ; espaço entre os numeros
    
segment .text               ; código do programa
    global asm_main
    



asm_main:                   ; função main
    
    call read_int           ; eax = numero de pilares no desfiladeiro
    add eax, 2              ; eax += 2 
    mov [pilares], eax      ; [pilares] = eax
    
    call read_int           ; eax = numero de pontes no desfiladeiro
    mov [pontes], eax       ; [pontes] = eax   
    
    call read_char
        
    mov ecx, [pontes]       ; ecx = [pontes] para realizar as M leituras de S, T e B

readingfor:

    call read_int           ; lê o valor S em eax
    mov [pilarDe], eax      ; [pilarDe] = eax
    
    call read_char          ; para o espaço entre os numeros
    
    call read_int           ; lê o valor de T em eax
    mov [pilarPara], eax    ; [pilarPara] = eax
    
    call read_char          ; para o espaço entre os numeros
    
    call read_int           ; lê o valor de B em eax
    mov [buracos], eax      ; [buracos] = eax
    
    call read_char          ; para o enter pros próximos numeros
    
    ;Calculo da posição da matriz de maneira rowwise
    mov ebx, [pilarDe]
    imul eax, ebx, 60
    add eax, [pilarPara]
    mov edx, [buracos]
    mov [A+eax], dl        ; A[S][T] = B
    
    mov ebx, [pilarPara]
    imul eax, ebx, 60
    add eax, [pilarDe]
    mov edx, [buracos]
    mov [A+eax], dl        ; A[T][S] = B

    loop readingfor 
    

    
resolve:                   ; função dijkstra

   
    mov eax, 0
    mov [dis], eax
    
while:

    mov edx, -1             ; edx = no 
    mov ecx, 0
    cld
    mov esi, visitado
innerfor1:
    lodsb
    cmp eax, 0              ; eax == 1
    jne endinnerfor1         ; se sim, end
    cmp edx, -1             ; edx == -1
    je condicao             ; se sim, condicao
    mov eax, [dis + ecx]
    mov ebx, [dis + edx]    ; ebx = dis[edx]
    cmp eax, ebx
    jl condicao
    jmp endinnerfor1
condicao:
    mov edx, ecx            ; edx = ecx
endinnerfor1: 
    inc ecx
    cmp ecx, [pilares]
    jl innerfor1
    
    cmp edx, -1
    je break
    
    mov [visitado + edx], byte 1
    mov ecx, 0
innerfor2:
    mov ebx, 0
    imul bx, dx, byte 60
    add bl, cl            ; ebx = [no][i]           
    mov al, [dis + edx]      ; eax = dis[no]
    add al, [A + ebx]        ; eax = dis[no] + A[no][i]
    mov bl, [dis + ecx]      ; ebx = dis[i]  
    cmp eax, ebx      ; soma >= dis[i]
    jge endinnerfor2
    mov [dis + ecx], al
endinnerfor2:
    inc ecx
    cmp ecx, [pilares]
    jl innerfor2
    jmp while
break:
    
    mov ebx, [pilares]
    dec ebx
    mov al, [dis + ebx] 
    call print_int
    call print_nl
    
    leave
    ret

    
