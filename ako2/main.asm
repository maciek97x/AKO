.686
.model	flat

extern _ExitProcess@4 : PROC
extern __write : PROC

public _main


.data
dzielnik dw	2

znaki	db	12 dup (?)

.code

wyswietl32 PROC
	push	ebp							; standardowy prolog
	mov		ebp, esp
	push	ebx
	push	esi

	mov		eax, [ebp+8]				; arg1
	mov		esi, 10						; indeks w tablicy 'znaki'
	mov		ebx, 10						; dzielnik równy 10
konwersja:
	mov		edx, 0						; zerowanie starszej czesci dzielnej
	div		ebx							; dzielenie przez 10, reszta w EDX,
										; iloraz w EAX
	add		dl, 30H						; zamiana reszty z dzielenia na kod
										; ASCII
	mov		znaki [esi], dl				; zapisanie cyfry w kodzie ASCII
	dec		esi							; zmniejszenie indeksu
	cmp		eax, 0						; sprawdzenie czy iloraz = 0
	jne		konwersja					; skok, gdy iloraz niezerowy
										; wypelnienie pozostalych bajtow spacjami i wpisanie
										; znakow nowego wiersza
wypeln:
	or		esi, esi
	jz		wyswietl					; skok, gdy ESI = 0
	mov		byte PTR znaki [esi], 20H	; kod spacji
	dec		esi							; zmniejszenie indeksu
	jmp		wypeln
wyswietl:
	mov		byte PTR znaki [0], 0AH		; kod nowego wiersza
	mov		byte PTR znaki [11], 0AH	; kod nowego wiersza
										; wyswietlenie cyfr na ekranie
	push	dword PTR 12				; liczba wyswietlanych znaków
	push	dword PTR OFFSET znaki		; adres wysw. obszaru
	push	dword PTR 1					; numer urzadzenia (ekran ma numer 1)
	call	__write						; wyswietlenie liczby na ekranie
	add		esp, 12						; usuniecie parametrow ze stosu

	pop		esi
	pop		ebx
	pop		ebp							; standardowy epilog
	ret
wyswietl32 ENDP



_main PROC
	
	;mov		dx, 2
	;mov		ax, 0FF20h
	;mov		bx, 4
	;div		ebx
	;div		dzielnik

	push	dword ptr 8AF6h
	call	wyswietl32
	;pop
	add		esp, 4


	; zakonczenie programu
	push	0
	call	_ExitProcess@4

_main ENDP

end