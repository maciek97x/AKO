; Program linie.asm
; Wyświetlanie znaków * w takt przerwańzegarowych
; Uruchomienie w trybie rzeczywistym procesora x86
; lub na maszynie wirtualnej
; zakończenie programu po naciśnięciu dowolnego klawisza
; asemblacja (MASM 4.0)   : masm gwiazdki.asm,,,;
; konsolidacja (LINK 3.60): link gwiazdki.obj;

.386
rozkazy  SEGMENT  use16
         ASSUME   cs:rozkazy

linia PROC

; przechowywanie rejestrów
	push	ax
	push	bx
	push	es
  
	mov		ax, 0A000H    ; adres pamięci ekranu dla trybu 13H
	mov		es, ax
	  
	mov		bx, cs:adres_piksela  ; adres bieżący piksela
	mov		al, cs:kolor
	mov		es:[bx], al           ; wpisanie kodu koloru do pam. ekranu
  
	;
	;x   8
	; xx
	;   x   5
	;    xx
	;      xx
	
	mov		ax, cs:licznik
	cmp		ax, 1
	jl      rusz_h
	cmp		ax, 2
	jl      dalej_2
	cmp		ax, 3
	jl      rusz_h
	cmp		ax, 4
	jl      rusz_h
	cmp		ax, 5
	jl      dalej_2
	cmp		ax, 6
	jl      rusz_h
	cmp		ax, 7
	jl      dalej_2
rusz_h:
	mov		ax, cs:przyrost_h
	cmp		ax, 0
	jl		w_gore
	add		bx, 320
	jmp		dalej_2
w_gore:
	sub		bx, 320
dalej_2:

	add		bx, 1

	mov		ax, cs:licznik
	inc		ax
	cmp		ax, 8
	jne		dalej_3
	mov		ax, 0
dalej_3:
	mov		cs:licznik, ax
  
	; sprawdzanie czy cała linia wykreślona
	cmp		bx, 320*200
	jb		dalej     ; skok, gdy linia jeszcze nie wykreślona
  
	; kreślenie linii zostało zakończone - następna linia
	; będzie kreślona w innym kolorze o 10 pikseli dalej
	mov		ax, cs:przyrost_h
	neg     ax
	cmp		ax, 0
	jg		teraz_w_dol
	mov		bx, 320*199
	jmp		teraz_w_gore
teraz_w_dol:
	mov		bx, 0
teraz_w_gore:

	mov		cs:przyrost_h, ax
	inc		cs:kolor          ; kolejny kod koloru
  
	; zapisanie adresu bieżącego piksela
 dalej:
    mov		cs:adres_piksela, bx

	; odtworzenie rejestrów
	pop		es
	pop		bx
	pop		ax
  
	; skok do oryginalnego podprogramu obsługi przerwania zegarowego
	jmp		dword ptr cs:wektor8
  
	; zmienne procedury
	kolor			db 1
	adres_piksela	dw 0
	przyrost_h		dw 1
	licznik			dw 0
	wektor8			dd ?
  
linia ENDP

; INT 10H, funkcja nr 0 ustawia tryb sterownika graficznego
zacznij:
    mov		ah, 0
    mov		al, 13H  ; nr trybu
    int		10H
    
    mov		bx, 0
    mov		es, bx          ; zerowanie ES
    mov		eax, es:[32]    ; odczytanie wektora nr 8
    mov		cs:wektor8, eax ; zapiętanie ektora nr 8

    ; adres procedury 'linia' w postaci segment:offset
    mov		ax, SEG linia
    mov		bx, OFFSET linia
    
    cli     ; zablokowanie  przerwań
    
    ; zapisanie adresu procedury 'linia' do wektora nr 8
    mov		es:[32], bx
    mov		es:[32+2], ax
    
    sti     ; odblokowanie przerwań
    
czekaj:
    mov		ah, 1       ; sprawdzanie czy jest jakiś znak
    int		16H         ; w buforze klawiatury 
    jz		czekaj
  
    mov		ah, 0     ; funkcja nr 0 ustawia tryb sterownika
    mov		al, 3H    ; nr trybu
    int		10H

    ; odtworzenie oryginalnej zawartości wektora nr 8
    mov		eax, cs:wektor8
    mov		es:[32], eax
    
    ; zakończenie wykonywanego programu
    mov		ax, 4C00H
    int		21H
    
rozkazy ENDS

stosik SEGMENT stack
    db 256 dup (?)
stosik ENDS

END zacznij
