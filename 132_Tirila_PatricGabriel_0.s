.data
	cerinta: .space 4
	n: .space 4
	legatura: .space 4
	k: .space 4
	i: .space 4
	j: .space 4
	nrLegaturi: .space 400
	matrix: .space 40000
	matrix2: .space 40000
	matrix3: .space 40000
	indexLinie: .space 4
	indexColoana: .space 4
	formatScanf: .asciz "%ld"
	formatPrintf: .asciz "%ld\n"
	helper: .long 0
	path: .long 0
	formatPrintf2: .asciz "%ld "
.text

afisare_matrice:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %edi
	pushl %ebx
	pushl %esp
	
	xorl %ecx, %ecx
	movl 12(%ebp), %edi
	movl 8(%ebp), %edx
	
	while_afisare_matrice:
		cmp %edx, %ecx
		jge exit_afisare_matrice
			
		pushl %edx
		movl %edx, %ebx
		xorl %edx, %edx
		movl %ecx, %eax
		mull %ebx
		popl %edx
			
		movl $0, %ebx
		while_afisare_numar:
			cmp %edx, %ebx
			jge exit_afisare_numar
				
			addl %ebx, %eax
				
			pushl %ecx
			pushl %eax
			pushl %edx
			
			pushl (%edi, %eax, 4)
			pushl 16(%ebp)                           				
			call printf
			popl %eax
			popl %eax
			
			popl %edx
			popl %eax
				
			pushl %eax
			pushl %edx
			
			pushl $0
			call fflush
			popl %eax
			
			popl %edx
			popl %eax
			popl %ecx
				
			subl %ebx, %eax
				
			inc %ebx
			jmp while_afisare_numar
		exit_afisare_numar:
			
		inc %ecx
		jmp while_afisare_matrice
	exit_afisare_matrice:
	
	popl %esp
	popl %ebx
	popl %edi
	
	popl %ebp
	ret

matrix_mult:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %esi
	pushl %edi
	pushl %esp
	pushl %ebx
	
	movl 8(%ebp), %esi
	movl 12(%ebp), %edi
	movl 16(%ebp), %ecx
	movl 20(%ebp), %eax
	subl $4, %esp
	movl %eax, -4(%ebp)
	xorl %eax, %eax
	subl $4, %esp
	
			
	while_inmultire1:
		cmp n, %eax						
		jge exit_inmultire1
			
			xorl %edx, %edx
			while_inmultire2:
				cmp -4(%ebp), %edx					
				jge exit_inmultire2	
			
				pushl %eax
				pushl %edx
				xorl %edx, %edx
				movl -4(%ebp), %ebx				
				mull %ebx
				popl %edx
				addl %edx, %eax
						
				movl $0, %ebx
				movl %ebx, (%ecx, %eax, 4)
				
				popl %eax
				
				while_inmultire3:
					cmp -4(%ebp), %ebx				
					jge exit_inmultire3
				
					pushl %ecx
					
					pushl %eax
					pushl %edx
					pushl %ebx
					
					xorl %edx, %edx
					movl -4(%ebp), %ebx				
					mull %ebx
					popl %ebx
					addl %ebx, %eax
					pushl %ebx
					
					movl (%esi, %eax, 4), %ecx
					popl %ebx
					popl %edx
					popl %eax
					
					pushl %ebx
					pushl %eax
					pushl %edx
					
					xorl %edx, %edx
					movl %ebx, %eax
					movl -4(%ebp), %ebx		
					mull %ebx
					
					popl %edx
					addl %edx, %eax
					pushl %edx
					
					xorl %edx, %edx
					movl (%edi, %eax, 4), %ebx
					movl %ecx, %eax
					mull %ebx

					movl %eax, -8(%ebp)

					popl %edx
					popl %eax
					popl %ebx
					popl %ecx
					
					pushl %edx
					pushl %ebx
					pushl %eax
					
					pushl %edx
					xorl %edx, %edx
					movl -4(%ebp), %ebx
					mull %ebx
					
					popl %edx
					addl %edx, %eax
					movl (%ecx, %eax, 4), %ebx
					
					addl -8(%ebp), %ebx					
					
					movl %ebx, (%ecx, %eax, 4)
					
					popl %eax
					popl %ebx
					popl %edx
					
					inc %ebx
					jmp while_inmultire3
				exit_inmultire3:
				
				inc %edx
				jmp while_inmultire2
			exit_inmultire2:
		
		inc %eax
		jmp while_inmultire1
	exit_inmultire1:
	
	addl $8, %esp
	
	popl %ebx
	popl %esp
	popl %edi
	popl %esi
	
	popl %ebp
	ret
	
.global main

main:
	pushl $cerinta
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $n
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	movl $0, %ecx
	while_citire_nr_legaturi:
		cmpl n, %ecx
		jge exit_citire_nr_legaturi
		
		lea nrLegaturi, %edi
		xorl %edx, %edx
		movl $4, %eax
		movl %ecx, %ebx
		mull %ebx
		addl %eax, %edi
		
		pushl %ecx
		pushl %edi
		pushl $formatScanf
		call scanf
		popl %ebx
		popl %ebx
		popl %ecx
		
		inc %ecx
		jmp while_citire_nr_legaturi
	exit_citire_nr_legaturi:
	
	xorl %ecx, %ecx
	lea matrix, %edi
	while_citire_linie: 
		cmpl n, %ecx
		jge exit_citire_linie
		
		xorl %edx, %edx
		movl n, %eax
		movl %ecx, %ebx
		mull %ebx
		movl %eax, indexLinie
		
		lea nrLegaturi, %esi
		movl (%esi, %ecx, 4), %ebx
		
		xorl %eax, %eax
		while_gasire_legatura:
			cmpl %ebx, %eax
			jge exit_gasire_legatura
			
			pushl %eax
			pushl %ecx
			pushl %edx
			pushl $legatura
			pushl $formatScanf
			call scanf
			popl %edx
			popl %edx
			popl %edx
			popl %ecx
			popl %eax
			
			xorl %edx, %edx
			while_citire_coloana:
				cmpl n, %edx
				jge exit_citire_coloana
				
				addl indexLinie, %edx
				pushl %eax
				movl $1, %eax
				cmpl (%edi, %edx, 4), %eax
				jne dnd
				
				popl %eax
				subl indexLinie, %edx
				incl %edx
				jmp while_citire_coloana
				
				dnd:
				popl %eax
				subl indexLinie, %edx
				
				cmpl legatura, %edx
				jne cont1
				
				addl indexLinie, %edx
				pushl %eax
				movl $1, %eax
				movl %eax, (%edi, %edx, 4)
				popl %eax
				jmp cont2
				
				cont1:
				
				addl indexLinie, %edx
				pushl %eax
				movl $0, %eax
				movl %eax, (%edi, %edx, 4)
				popl %eax
				
				cont2:
				subl indexLinie, %edx
				
				cont3: 
				incl %edx
				jmp while_citire_coloana
			exit_citire_coloana:
			
			incl %eax
			jmp while_gasire_legatura
		exit_gasire_legatura:
		
		incl %ecx
		jmp while_citire_linie
	exit_citire_linie:
	
	movl cerinta, %ecx
	cmpl $1, %ecx
	jne et_cerinta2
	
	pushl %eax
	pushl %ecx
	pushl %edx
	
	pushl $formatPrintf2
	pushl $matrix
	pushl n
	call afisare_matrice
	popl %ebx
	popl %ebx
	popl %ebx
	
	popl %edx
	popl %ecx
	popl %eax
	
	jmp exit

	et_cerinta2:
	
	lea matrix, %esi
	lea matrix2, %edi
	xorl %ecx, %ecx
	xorl %ebx, %ebx
	
	while_copiere:
		cmpl n, %ecx
		jge exit_copiere
		
		pushl %ebx
		xorl %edx, %edx
		movl %ecx, %eax
		movl n, %ebx
		mull %ebx
		popl %ebx
		addl %ebx, %eax
				
		movl (%esi, %eax, 4), %edx
		movl %edx, (%edi, %eax, 4)
		
		cmpl n, %ebx
		jge schimba_linie
		
		incl %ebx
		jmp continua
		
		schimba_linie:
			xorl %ebx, %ebx
			incl %ecx

		continua:
		jmp while_copiere
	exit_copiere:
	
	pushl $k
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $i
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $j
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	xorl %ecx, %ecx
	while_inmultire:
		movl k, %edx
		decl %edx
		cmpl %edx, %ecx
		jge exit_inmultire
		
		pushl %ecx
		
		xorl %edx, %edx
		movl %ecx, %eax
		movl $2, %ebx
		divl %ebx
		
		pushl %eax
		pushl %ecx
		pushl %edx
		
		cmpl $0, %edx
		jne second_path
		
		first_path:
			movl $1, path
			pushl n
			pushl $matrix3
			pushl $matrix2
			pushl $matrix
			call matrix_mult
			popl %ebx
			popl %ebx
			popl %ebx
			popl %ebx
			jmp jump_over_second_path

		second_path:
			movl $2, path
			pushl n
			pushl $matrix2
			pushl $matrix3
			pushl $matrix
			call matrix_mult
			popl %ebx
			popl %ebx
			popl %ebx
			popl %ebx	
		
		jump_over_second_path:
		
		popl %edx
		popl %ecx
		popl %eax

		popl %ecx
		
		incl %ecx
		jmp while_inmultire
	exit_inmultire:
	
	movl path, %ecx	
	cmpl $0, %ecx
	jne not_0
	
	lea matrix, %edi
	
	jmp exit_path_if
	
	not_0:
		cmpl $1, %ecx
		jne path_2
		
		lea matrix3, %edi
		jmp exit_path_if
		
	path_2:
		lea matrix2, %edi
		
	exit_path_if:
	
	xorl %ecx, %ecx	
	
	movl j, %ecx
	xorl %edx, %edx	
	movl i, %eax
	movl n, %ebx
	mull %ebx
	addl %ecx, %eax
	
	pushl (%edi, %eax, 4)
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx
	

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
