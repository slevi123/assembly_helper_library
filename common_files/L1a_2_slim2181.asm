; Simofi Levente
; azonosito: slim2181
; csoport: 511 (ex514)
; elso labor, feladat sorszama: 2

; FELADAT: 
; aritmetikai kifejezés kiértékelése, „div” az egész osztás hányadosát, „mod” pedig a maradékát jelenti. 
; a, b, c, d, e, f, g előjeles egész számok, az io_readint függvénnyel olvassuk be őket ebben a sorrendben. Az eredményt az io_writeint eljárás segítségével írjuk ki.
; a * (c mod g) * ((d + b - (f div e)) mod 3) - ((c + 3) div (a - f * 2) + a - (b + d))
; E(-27, 11, -9, -3, 13, 14, 41) = 278

%include 'io.inc'

global main 

section .text
main:
    ; adatok beolvasa
    mov eax, str_input ; magyarazo sztring kiirasa
    call io_writestr

    mov ecx, 7 ; valtozok beolvasasa egy ciklus segitsegevel
    .beolvas_eleje:
        ; egy fordito talan optimalizalna ezt a ciklust, de igy atlathatobb
        call    io_readint
        push    eax
        loop .beolvas_eleje

    
    ; az atlathatosag erdekeben elofordito segitsegevel nevet adtam a valtozoimnak
    ; az otletet a helyi valtozok inspiraltak

    ; 4 byte-os ertekeket tarolok a veremben, melyeket ennek megfeleloen cimzek,
    ;   relativan az ebp regiszterhez
    mov ebp, esp
    %define a_var   [ebp+24]  
    %define b_var   [ebp+20]  
    %define c_var   [ebp+16]  
    %define d_var   [ebp+12]  
    %define e_var   [ebp+8]  
    %define f_var   [ebp+4]  
    %define g_var   [ebp]  

    ; eredmeny kiiratasa
    mov eax, str_ostart
    call io_writestr

    mov ecx, 6 ; a ciklus 6-szor fog futni, a hetedik valtozot utana iratom ki
        
    .kiir_eleje:
        mov eax, [ebp + 4*ecx] ; a veremben tarolt valtozok kiirasa
        call io_writeint
        inc edx
        mov eax, str_oseparator ; elvalaszto string kiirasa
        call io_writestr
        loop .kiir_eleje

    mov eax, g_var ; az utolso valtozot itt irom ki, hogy ne jelenjen meg ujra egy vesszo
    call io_writeint
    mov eax, str_oend
    call io_writestr
    

    ; calc (c mod g) and push to stack
    mov eax, c_var
    mov ebx, g_var
    cdq
    idiv ebx
    push edx

    ; calc (f div e) and push
    mov eax, f_var
    mov ebx, e_var
    cdq
    idiv ebx
    push eax

    ; calc (d+b-(f div e)) in eax
    ; removes ( f div e ) from the top of the stack
    mov eax, d_var
    add eax, b_var
    pop ebx
    sub eax, ebx

    ; calc (d+b-(f div e)) mod 3 in eax 
    mov ebx, 3
    cdq
    idiv ebx
    mov eax, edx

    ; calc a * ((d + b - (f div e)) mod 3) in eax
    mov ebx, a_var
    imul eax, ebx

    ; calc a * (c mod g) * ((d + b - (f div e)) mod 3) and push
    ; removes (c mod g) from the top of the stack
    pop ebx
    imul ebx
    push eax

    ; calc f*2 in ecx
    mov ecx, f_var
    mov ebx, 2
    imul ecx, ebx

    ; calc a - f*2 in ebx
    mov ebx, a_var
    sub ebx, ecx
 

    ; calc c+3 in eax
    mov eax, c_var
    add eax, 3

    ; calc (c + 3) div (a - f * 2)  in eax
    cdq
    idiv ebx

    ; calc  a - (b + d)
    add eax, a_var
    sub eax, b_var
    sub eax, d_var

    ; calc final
    mov ebx, eax
    pop eax
    sub eax, ebx

    ; vegso eredmeny kiirasa
    call io_writeint

    ret

section .data
    str_input  db `Add meg a valtozokat (soronkent) a kovetkezo sorrendben: a, b, c, d, e, f, g!\n`, 0
    str_ostart  db 'E(', 0
    str_oseparator  db ', ', 0
    str_oend  db ') = ', 0
