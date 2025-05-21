.data
    PromptForPlaintext:
        .asciz  "Please enter the plaintext: "
        lenPromptForPlaintext = .-PromptForPlaintext

    PromptForShiftValue:
        .asciz  "Please enter the shift value: "
        lenPromptForShiftValue = .-PromptForShiftValue

    Newline:
        .asciz  "\n"

    ShiftValue:
        .int    0
.bss
    .comm   buffer, 102     # Buffer to read in plaintext/output ciphertext
    .comm   intBuffer, 4    # Buffer to read in shift value
                            # (assumes value is 3 digits or less)

.text

    .globl _start

    .type PrintFunction, @function
    .type ReadFromStdin, @function
    .type GetStringLength, @function
    .type AtoI, @function
    .type CaesarCipher, @function


    PrintFunction:
        pushl %ebp              # store the current value of EBP on the stack
        movl %esp, %ebp         # Make EBP point to top of stack

        # Write syscall
        movl $4, %eax           # syscall number for write()
        movl $1, %ebx           # file descriptor for stdout
        movl 8(%ebp), %ecx      # Address of string to write
        movl 12(%ebp), %edx     # number of bytes to write
        int $0x80

        movl %ebp, %esp         # Restore the old value of ESP
        popl %ebp               # Restore the old value of EBP
        ret                     # return

    ReadFromStdin:
        pushl %ebp              # store the current value of EBP on the stack
        movl %esp, %ebp         # Make EBP point to top of stack

        # Read syscall
        movl $3, %eax
        movl $0, %ebx
        movl 8(%ebp), %ecx      # address of buffer to write input to
        movl 12(%ebp), %edx     # number of bytes to write
        int  $0x80

        movl %ebp, %esp         # Restore the old value of ESP
        popl %ebp               # Restore the old value of EBP
        ret                     # return


    GetStringLength:

        # Strings which are read through stdin will end with a newline character. (0xa)
        # So look through the string until we find the newline and keep a count
        pushl %ebp              # store the current value of EBP on the stack
        movl %esp, %ebp         # Make EBP point to top of stack

        movl 8(%ebp), %esi      # Store the address of the source string in esi
        xor %edx, %edx          # edx = 0

        Count:
			inc %edx            # increment edx
            lodsb               # load the first character into eax
            cmp $0xa, %eax  	# compare the newline character vs eax
            jnz Count           # If eax != newline, loop back

        dec %edx                # the loop adds an extra one onto edx
        movl %edx, %eax          # return value

        movl %ebp, %esp         # Restore the old value of ESP
        popl %ebp               # Restore the old value of EBP
        ret                     # return


    
    AtoI:
    
    #
    # Input is always read in as a string. 
    # This function converts a string to an integer.
    pushl %ebp              # store the current value of EBP on the stack
    movl %esp, %ebp         # Make EBP point to top of stack

    movl 8(%ebp), %esi      # Store the address of the source string in esi
    xorl %eax, %eax         # Initialize the result to 0
    xorl %ecx, %ecx         # Initialize the current digit to 0

    .loop:
        movb (%esi), %cl        # Load the next character from the string
        cmpb $0xa, %cl          # Check if it's a newline
        je .done                # If it is, we're done

        subb $'0', %cl          # Convert ASCII to integer by subtracting '0'
        imull $10, %eax         # Multiply the current result by 10
        addl %ecx, %eax         # Add the new digit

        incl %esi               # Move to the next character
        jmp .loop               # Continue the loop

    .done:
        movl %ebp, %esp         # Restore the old value of ESP
        popl %ebp               # Restore the old value of EBP
        ret                     # Return with the result



    CaesarCipher:

    #
    # Fill in code for CaesarCipher Function here

    pushl %ebp              # Store the current value of EBP on the stack
    movl %esp, %ebp         # Make EBP point to top of stack

    movl 8(%ebp), %esi      # Get the address of the plaintext : buffer
    movl 12(%ebp), %edx     # Get the shift value - %edx

    xor %ecx, %ecx          # Clear %ecx to use it as a temp register

    .caesar_loop:
        movb (%esi), %al        # Load the next character from plaintext
        cmpb $0xa, %al          # Check if it's a newline
        je .caesar_done         # If it is, jump to done

        cmpb $'A', %al          # Check if the character is uppercase
        jb .caesar_skip         # If less than 'A', skip
        cmpb $'Z', %al          # Check if greater than 'Z'
        jbe .caesar_uppercase   # If within 'A' to 'Z', process as uppercase

        cmpb $'a', %al          # Check if the character is lowercase
        jb .caesar_skip         # If less than 'a', skip
        cmpb $'z', %al          # Check if greater than 'z'
        jbe .caesar_lowercase   # If within 'a' to 'z', process as lowercase

    .caesar_skip:
        incl %esi               # Move to the next character
        jmp .caesar_loop

    .caesar_uppercase:
        subb $'A', %al          # Normalize 'A' to 0
        addb %dl, %al           # Add the shift value
        cmpb $26, %al           # Check if overflow
        jl .caesar_upper_no_wrap
        subb $26, %al           # Apply wrap-around if necessary
    .caesar_upper_no_wrap:
        addb $'A', %al          # Convert back to ASCII
        movb %al, (%esi)        # Store the result back in the buffer
        incl %esi               # Move to the next character
        jmp .caesar_loop

    .caesar_lowercase:
        subb $'a', %al          # Normalize 'a' to 0
        addb %dl, %al           # Add the shift value
        cmpb $26, %al           # Check if overflow
        jl .caesar_lower_no_wrap
        subb $26, %al           # Apply wrap-around if necessary
    .caesar_lower_no_wrap:
        addb $'a', %al          # Convert back to ASCII
        movb %al, (%esi)        # Store the result back in the buffer
        incl %esi               # Move to the next character
        jmp .caesar_loop

    .caesar_done:
        movl %ebp, %esp         # Restore the stack pointer
        popl %ebp               # Restore the base pointer
        ret                     # Return

    _start:

        # Print prompt for plaintext
        pushl   $lenPromptForPlaintext
        pushl   $PromptForPlaintext
        call    PrintFunction
        addl    $8, %esp

        # Read the plaintext from stdin
        pushl   $102
        pushl   $buffer
        call    ReadFromStdin
        addl    $8, %esp

        # Print newline
        pushl   $1
        pushl   $Newline
        call    PrintFunction
        addl    $8, %esp


        # Get input string and adjust the stack pointer back after
        pushl   $lenPromptForShiftValue
        pushl   $PromptForShiftValue
        call    PrintFunction
        addl    $8, %esp

        # Read the shift value from stdin
        pushl   $4
        pushl   $intBuffer
        call    ReadFromStdin
        addl    $8, %esp

        # Print newline
        pushl   $1
        pushl   $Newline
        call    PrintFunction
        addl    $8, %esp



        # Convert the shift value from a string to an integer.
        pushl $intBuffer
        call AtoI
        addl $4, %esp
        movl %eax, ShiftValue

        # Perform the Caesar cipher
        pushl ShiftValue
        pushl $buffer
        call CaesarCipher
        addl $8, %esp


        # Get the size of the ciphertext
        # The ciphertext must be referenced by the 'buffer' label
        pushl   $buffer
        call    GetStringLength
        addl    $4, %esp

        # Print the ciphertext
        pushl   %eax
        pushl   $buffer
        call    PrintFunction
        addl    $8, %esp

        # Print newline
        pushl   $1
        pushl   $Newline
        call    PrintFunction
        addl    $8, %esp

        # Exit the program
        Exit:
            movl    $1, %eax
            movl    $0, %ebx
            int     $0x80
