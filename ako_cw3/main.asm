.686
.model	flat

extern _ExitProcess@4 : PROC
extern __write : PROC
extern __read : PROC

public _main


.data
dzielnik	dw	2

znaki		db	12 dup (?)

dekoder		db '0123456789ABCDEF'

obszar		db 12 dup (?)

dziesiec	dd 10 ; mnoznik
.code

wczytaj_do_EAX_hex PROC

										; wczytywanie liczby szesnastkowej z klawiatury – liczba po
										; konwersji na postac binarna zostaje wpisana do rejestru EAX
										; po wprowadzeniu ostatniej cyfry nalezy nacisnac klawisz
										; Enter
	push	ebx
	push	ecx
	push	edx
	push	esi
	push	edi
	push	ebp

										; rezerwacja 12 bajtow na stosie przeznaczonych na tymczasowe przechowywanie cyfr szesnastkowych wyswirtlanej liczby
	
	sub		esp, 12						; rezerwacja poprzez zmniejszenei ESP
	mov		esi, esp					; adres zarezerwowanego obszaru pamieci

	push	dword PTR 10				; max ilosc znakow wczytywanej liczby
	push	esi							; adres obszaru pamieci
	push	dword PTR 0					; nr urzadzenia (0 dla klawiatury)
	call	__read						; odczytywanie znakow z klawiatury
	
	add		esp, 10						; usuniecie parametrow ze stosu

	mov		eax, 0						; dotychczas uzyskany wynik

pocz_konw:
	mov		dl, [esi]					; pobranie kolejnego bajtu
	inc		esi							; inkrementacja indeksu
	cmp		dl, 10						; sprawdzenie czy nacisnieto enter
	je		gotowe						; skok do konca podprogramu
	
										; sprawdzamy czy wprowadzony znak jest cyfra 0..9
	cmp		dl, '0'
	jb		pocz_konw					; inny znak jest ignorowany
	cmp		dl, '9'
	ja		sprawdzaj_dalej
	sub		dl, '0'						; zamiana kodu ASCII na wartosc cyfry
dopisz:
	shl		eax, 4						; przesuniecie logiczne w lewo o 4 bity
	or		al, dl						; dopisanie utworzonego kodu 4-bitowego
										; na 4 ostatnie bity rejestru EAX
	jmp		pocz_konw					; skok na poczatek petli konwersji
										; sprawdzenie czy wprowadzony znak jest cyfra A, B, ..., F
sprawdzaj_dalej:
	cmp		dl, 'A'
	jb		pocz_konw					; inny znak jest ignorowany
	cmp		dl, 'F'
	ja		sprawdzaj_dalej2
	sub		dl, 'A' - 10				; wyznaczenie kodu binarnego
	jmp		dopisz
										; sprawdzenie czy wprowadzony znak jest cyfra a, b, ..., f
sprawdzaj_dalej2:
	cmp		dl, 'a'
	jb		pocz_konw					; inny znak jest ignorowany
	cmp		dl, 'f'
	ja		pocz_konw					; inny znak jest ignorowany
	sub		dl, 'a' - 10
	jmp		dopisz
gotowe:
										; zwolnienie zarezerwowanego obszaru pamieci
	add		esp, 12

	pop		ebp
	pop		edi
	pop		esi
	pop		edx
	pop		ecx
	pop		ebx
	ret
wczytaj_do_EAX_hex ENDP

wyswietl_EAX_hex PROC
										; wyswietlanie zawartosci rejestru EAX
										; w postaci liczby szesnastkowej
	pusha								; przechowanie rejestrow

										; rezerwacja 12 bajtow na stosie (poprzez zmniejszenie
										; rejestru ESP) przeznaczonych na tymczasowe przechowanie
										; cyfr szesnastkowych wyswietlanej liczby
	sub		esp, 12
	mov		edi, esp					; adres zarezerwowanego obszaru
										; pamieci
										; przygotowanie konwersji
	mov		ecx, 8						; liczba obiegow petli konwersji
	mov		esi, 1						; indeks poczatkowy uzywany przy
										; zapisie cyfr
										; petla konwersji
ptl3hex:
										; przesuniecie cykliczne (obrot) rejestru EAX o 4 bity w lewo
										; w szczegolnosci, w pierwszym obiegu petli bity nr 31 - 28
										; rejestru EAX zostana przesuniete na pozycje 3 - 0
	rol		eax, 4
										; wyodrebnienie 4 najmlodszych bitow i odczytanie z tablicy
										; 'dekoder' odpowiadajacej im cyfry w zapisie szesnastkowym
	mov		ebx, eax					; kopiowanie EAX do EBX
	and		ebx, 0000000FH				; zerowanie bitow 31 - 4 rej.EBX
	mov		dl, dekoder[ebx]			; pobranie cyfry z tablicy
										; przeslanie cyfry do obszaru roboczego
	mov		[edi][esi], dl
	inc		esi							; inkrementacja modyfikatora
	loop	ptl3hex						; sterowanie petla

										; wpisanie znaku nowego wiersza przed i po cyfrach
	mov		byte PTR [edi][0], 10
	mov		byte PTR [edi][9], 10
										; wyswietlenie przygotowanych cyfr
	push	10							; 8 cyfr + 2 znaki nowego wiersza
	push	edi							; adres obszaru roboczego
	push	1							; nr urzadzenia (tu: ekran)
	call	__write						; wyswietlenie
										; usuniecie ze stosu 24 bajtow, w tym 12 bajtow zapisanych
										; przez 3 rozkazy push przed rozkazem call
										; i 12 bajtow zarezerwowanych na poczatku podprogramu
	add		esp, 24

	popa								; odtworzenie rejestrow
	ret									; powrot z podprogramu
wyswietl_EAX_hex ENDP

wyswietl_EAX PROC
	push	ebp							; standardowy prolog
	mov		ebp, esp
	push	ecx
	push	ebx
	push	eax
	push	esi

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
	pop		eax
	pop		ebx
	pop		ecx
	pop		ebp							; standardowy epilog
	ret
wyswietl_EAX ENDP

wczytaj_do_EAX PROC
	push	ebp							; standardowy prolog
	mov		ebp, esp
	push	ebx
	push	ecx
	
										; max ilosc znakow wczytywanej liczby
	push	dword PTR 12
	push	dword PTR OFFSET obszar		; adres obszaru pamieci
	push	dword PTR 0					; numer urzadzenia (0 dla klawiatury)
	call	__read						; odczytywanie znakow z klawiatury
										
	add		esp, 12						; usuniecie parametrow ze stosu
										; biezaca wartosc przeksztalcanej liczby przechowywana jest
										; w rejestrze EAX; przyjmujemy 0 jako wartosc poczatkowa
	mov		eax, 0
	mov		ebx, OFFSET obszar			; adres obszaru ze znakami
pobieraj_znaki:
	mov		cl, [ebx]					; pobranie kolejnej cyfry w kodzie
										; ASCII
	inc		ebx							; zwiekszenie indeksu
	cmp		cl,10						; sprawdzenie czy nacisnieto Enter
	je		byl_enter					; skok, gdy nacisnieto Enter
	sub		cl, 30H						; zamiana kodu ASCII na wartosc cyfry
	movzx	ecx, cl						; przechowanie wartosci cyfry w
										; rejestrze ECX
										; mnozenie wczesniej obliczonej wartosci razy 10
	mul		dword PTR dziesiec
	add		eax, ecx					; dodanie ostatnio odczytanej cyfry
	jmp		pobieraj_znaki				; skok na poczatek petli
byl_enter:
										; wartosc binarna wprowadzonej liczby znajduje sie teraz w
										; rejestrze EAX
	pop	ecx
	pop	ebx
	pop ebp
	ret
wczytaj_do_EAX ENDP

_main PROC
	
	;mov		dx, 2
	;mov		ax, 0FF20h
	;mov		bx, 4
	;div		ebx
	;div		dzielnik

	;push	dword ptr 8AF6h
	;call	wyswietl32
	;pop
	;add		esp, 4

	;call	wczytaj_do_EAX_hex

	; ciag
	;mov		ecx, 50
	;mov		ebx, 1
	;mov		eax, 1
;ptl:
	;call	wyswietl_EAX
	;add		eax, ebx
	;inc		ebx
	;dec		ecx
	;cmp		ecx, 0
	;jne		ptl

	call	wczytaj_do_EAX
	call	wyswietl_EAX
	call	wyswietl_EAX_hex

	;call	wczytaj_do_EAX_hex
	;call	wyswietl_EAX
	;call	wyswietl_EAX_hex
	
	; zakonczenie programu
	push	0
	call	_ExitProcess@4

_main ENDP

end