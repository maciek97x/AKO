.686
.model flat

public przestaw

.code

przestaw PROC stdcall, list_ptr:dword, count:dword
	push	ebx						; przechowanie zawartosci rejestru EBX
	mov		ebx, list_ptr			; adres tablicy tabl
	mov		ecx, count				; liczba elementow tablicy
	dec		ecx
									; wpisanie kolejnego elementu tablicy do rejestru EAX
ptl:
	mov		eax, [ebx]
									; porownanie elementu tablicy wpisanego do EAX z nastepnym
	cmp		eax, [ebx+4]
	jle		gotowe					; skok, gdy nie ma przestawiania
									; zamiana sasiednich elementow tablicy
	mov		edx, [ebx+4]
	mov		[ebx], edx
	mov		[ebx+4], eax
gotowe:
	add		ebx, 4					; wyznaczenie adresu kolejnego elementu
	loop	ptl						; organizacja petli
	pop		ebx						; odtworzenie zawartosci rejestrow
	ret		8						; powrot do programu glownego
przestaw ENDP
END