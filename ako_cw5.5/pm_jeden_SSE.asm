.686
.XMM
.model flat

public _pm_jeden

.data
	jedynki		dd -1.0, -1.0, -1.0, -1.0
.code

_pm_jeden proc
	push	ebp
	mov		ebp, esp
	push	esi

	mov		esi, [ebp+8]

	movups	xmm5, [esi]
	movups	xmm6, jedynki

	addsubps	xmm5, xmm6
 
	; zapisanie wyniku w pamieci
	movups	[esi], xmm5

	pop		esi
	pop		ebp
	ret
_pm_jeden endp
end