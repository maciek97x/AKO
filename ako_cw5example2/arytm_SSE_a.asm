; Program przykladowy ilustrujacy operacje SSE procesora
; Ponizszy podprogram jest przystosowany do wywolywania
; z poziomu jezyka C (program arytmc_SSE.c)
.686
.XMM								; zezwolenie na asemblacje rozkazow grupy SSE
.model flat

public _dodaj_SSE, _pierwiastek_SSE, _odwrotnosc_SSE

.code
_dodaj_SSE PROC
	push	ebp
	mov		ebp, esp
	push	ebx
	push	esi
	push	edi
	mov		esi, [ebp+8]			; adres pierwszej tablicy
	mov		edi, [ebp+12]			; adres drugiej tablicy
	mov		ebx, [ebp+16]			; adres tablicy wynikowej
	; ladowanie do rejestru xmm5 czterech liczb zmiennoprzecin-
	; kowych 32-bitowych - liczby zostaja pobrane z tablicy,
	; ktorej adres poczatkowy podany jest w rejestrze ESI
	; interpretacja mnemonika "movups" :
	; mov - operacja przeslania,
	; u - unaligned (adres obszaru nie jest podzielny przez 16),
	; p - packed (do rejestru ladowane sa od razu cztery liczby),
	; s - short (inaczej float, liczby zmiennoprzecinkowe
	; 32-bitowe)
	movups	xmm5, [esi]
	movups	xmm6, [edi]
	; sumowanie czterech liczb zmiennoprzecinkowych zawartych
	; w rejestrach xmm5 i xmm6
	addps	xmm5, xmm6
 
	; zapisanie wyniku sumowania w tablicy w pamieci
	movups	[ebx], xmm5
	pop		edi
	pop		esi
	pop		ebx
	pop		ebp
	ret
_dodaj_SSE ENDP
;=========================================================
_pierwiastek_SSE PROC
	push	ebp
	mov		ebp, esp
	push	ebx
	push	esi
	mov		esi, [ebp+8]			; adres pierwszej tablicy
	mov		ebx, [ebp+12]			; adres tablicy wynikowej
	; ladowanie do rejestru xmm5 czterech liczb zmiennoprzecin-
	; kowych 32-bitowych - liczby zostaja pobrane z tablicy,
	; ktorej adres poczatkowy podany jest w rejestrze ESI
	; mnemonik "movups": zob. komentarz podany w funkcji dodaj_SSE
	movups	xmm6, [esi]
	; obliczanie pierwiastka z czterech liczb zmiennoprzecinkowych
	; znajdujacych sie w rejestrze xmm6
	; - wynik wpisywany jest do xmm5
	sqrtps	xmm5, xmm6

	; zapisanie wyniku pierwiastkowania w tablicy w pamieci
	movups	[ebx], xmm5
	pop		esi
	pop		ebx
	pop		ebp
	ret
_pierwiastek_SSE ENDP
;=========================================================
; rozkaz RCPPS wykonuje obliczenia na 12-bitowej mantysie
; (a nie na typowej 24-bitowej) - obliczenia wykonywane sa
; szybciej, ale sa mniej dokladne
_odwrotnosc_SSE PROC
	push	ebp
	mov		ebp, esp
	push	ebx
	push	esi
	mov		esi, [ebp+8]			; adres pierwszej tablicy
	mov		ebx, [ebp+12]			; adres tablicy wynikowej
	; ladowanie do rejestru xmm5 czterech liczb zmiennoprzecin-
	; kowych 32-bitowych - liczby zostaja pobrane z tablicy,
	; ktorej adres poczatkowy podany jest w rejestrze ESI
	; mnemonik "movups": zob. komentarz podany w funkcji dodaj_SSE
	movups	xmm6, [esi]
	; obliczanie odwrotnosci czterech liczb zmiennoprzecinkowych
	; znajdujacych sie w rejestrze xmm6
	; - wynik wpisywany jest do xmm5
	rcpps	xmm5, xmm6

	; zapisanie wyniku odwracania w tablicy w pamieci
	movups	[ebx], xmm5
	pop		esi
	pop		ebx
	pop		ebp
	ret
_odwrotnosc_SSE ENDP
END