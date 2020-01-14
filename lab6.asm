.386
rozkazy  SEGMENT  use16
         ASSUME   cs:rozkazy

odswiez PROC

; przechowywanie rejestrów
	push	ax
	push	bx
	push	cx
	push	dx
	push	es
  
	mov		ax, 0A000H    ; adres pamięci ekranu dla trybu 13H
	mov		es, ax
	
	mov		ax, 320*3
linie:
	; rysowanie paska
	mov		cx, 320
linia_ptl:
	cmp		cx, cs:progres
	jg		moze_biale
	
	mov		dl, cs:kolor
	jmp		rysuj
	
moze_biale:
	push	ax
	mov		ax, cx
	sub		ax, 20
	cmp		ax, cs:progres
	pop		ax
	jng		rysuj_biale
	
	mov		dl, cs:kolor
	jmp		rysuj
	
rysuj_biale:
	mov		dl, 7
	
rysuj:
	mov		bx, 320*100		; zaczecie od 100. linii
	sub		bx, 1			; korekcja, bo cx od 1 do 320
	add		bx, cx
	add		bx, ax
	mov		es:[bx], dl

	
	dec		cx
	cmp		cx, 0
	jg		linia_ptl

	sub		ax, 320
	cmp		ax, 0
	jg  	linie
	
	; dodaj progres
	mov		ax, cs:progres
	inc		ax
	cmp		ax, 320
	jng		dalej
	mov		ax, 0
	
dalej:
	mov		cs:progres, ax
	
	; odtworzenie rejestrów
	pop		es
	pop		dx
	pop		cx 
	pop		bx
	pop		ax
  
	; skok do oryginalnego podprogramu obsługi przerwania zegarowego
	jmp		dword ptr cs:wektor8
  
	; zmienne procedury
	kolor          db 1
	progres       dw 0
	wektor8        dd ?
  
odswiez ENDP


obsluga_klawiatury PROC
	push	ax
	in		al,	60H
	mov		cs:kolor, al
	pop		ax
	
	jmp		dword PTR cs:wektor9

	wektor9 dd ?
obsluga_klawiatury ENDP

; INT 10H, funkcja nr 0 ustawia tryb sterownika graficznego
zacznij:
    mov		ah, 0
    mov		al, 13H  ; nr trybu
    int		10H
    
	mov		ax, 0
	mov		ds, ax

	; odczytanie zawartoci wektora nr 8 i zapisanie go w zmiennej 'wektor8' (wektor nr 8 zajmuje w pamici 4 bajty poczwszy od adresu fizycznego 8 * 4 = 32) 
	mov		eax,ds:[36]  ; adres fizyczny 0*16 + 32 = 32 
	mov		cs:wektor9, eax   


	; wpisanie do wektora nr 8 adresu procedury 'obsluga_zegara' 
	mov		ax, SEG obsluga_klawiatury ; cz segmentowa adresu 
	mov		bx, OFFSET obsluga_klawiatury ; offset adresu 
 
	cli    ; zablokowanie przerwa  
 
	; zapisanie adresu procedury do wektora nr 8 
	mov		ds:[36], bx   ; OFFSET           
	mov		ds:[38], ax   ; cz. segmentowa 
 
	sti      
    mov		bx, 0
    mov		es, bx          ; zerowanie ES
    mov		eax, es:[32]    ; odczytanie wektora nr 8
    mov		cs:wektor8, eax ; zapiętanie ektora nr 8

    ; adres procedury 'linia' w postaci segment:offset
    mov		ax, SEG odswiez 
    mov		bx, OFFSET odswiez
    
    cli     ; zablokowanie  przerwań
    
    ; zapisanie adresu procedury 'linia' do wektora nr 8
    mov		es:[32], bx
    mov		es:[32+2], ax
    
    sti     ; odblokowanie przerwań
    
	push	bx
	push	cx
	push	es
	
aktywne_oczekiwanie: 
	mov		ah,1       
	int		16H              
	; funkcja INT 16H (AH=1) BIOSu ustawia ZF=1 jeli nacinito jaki klawisz 
	jz		aktywne_oczekiwanie 
 
	; odczytanie kodu ASCII nacinitego klawisza (INT 16H, AH=0)  do rejestru AL 
	mov		ah, 0 
	int		16H 
	cmp		al, 1BH    ; porównanie z kodem klawisza esc
	je		koniec   ; skok, gdy esc

	mov		bx, 0
	jmp		aktywne_oczekiwanie
koniec:
	; zakoczenie programu 

    mov		ah, 0     ; funkcja nr 0 ustawia tryb sterownika
    mov		al, 3H    ; nr trybu
    int		10H
	
	; odtworzenie oryginalnej zawartoci wektora nr 8 
	mov		eax, cs:wektor9
	cli 
	mov		ds:[36], eax  ; przes³anie wartoci oryginalnej do wektora 8 w tablicy wektorów przerwa 
	sti  
	mov		eax, cs:wektor8
	cli 
	mov		ds:[32], eax  ; przes³anie wartoci oryginalnej do wektora 8 w tablicy wektorów przerwa 
	sti 
	
	pop		es
	pop		cx
	pop		bx
	
    ; zakończenie wykonywanego programu
    mov		ax, 4C00H
    int		21H
    
rozkazy ENDS

stosik SEGMENT stack
    db 256 dup (?)
stosik ENDS

END zacznij