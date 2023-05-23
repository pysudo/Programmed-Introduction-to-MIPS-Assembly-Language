        .data
miles:
        .asciiz "Enter the number of miles traveled: "
fuel:
        .asciiz "Enter the gallons of gasoline consumed: "
mileage:
        .asciiz "Your mileage is "
unit:
        .asciiz " miles per gallon\n\n"
point:
        .asciiz "."


        .text
main:
        li    $v0, 4            # Prompt the user for the miles traveled.
        la    $a0, miles
        syscall

        li    $v0, 5            # Get user miles traveled.
        syscall

        beq   $v0, $zero, end   # If user enters 0 miles, end program.
        move  $t1, $v0          # Copy miles traveled.

        ori   $t0, $zero, 100 
        multu $t1, $t0          # Multiply input value of miles by 100.
        mflo  $t3

        li    $v0, 4            # Prompt the user for the fuel consumed.
        la    $a0, fuel 
        syscall

        li    $v0, 5            # Get user fuel consumed.
        syscall

        divu  $t3, $v0          # Miles/gallon = miles traveled / gallon consumed.
        mflo  $t1
        nop
        nop

        divu  $t1, $t0          # As answer is 100 times too large.
        mflo  $t2
        mfhi  $t3

        li    $v0, 4            # Print inital result body.
        la    $a0, mileage
        syscall

        li    $v0, 1            # Print mileage.
        move  $a0, $t2          # Copy computed floored mileage to argument. 
        syscall

        li    $v0, 4            # Print the decimal point.
        la    $a0, point 
        syscall


        li    $v0, 1            # Print hundredths of the mileage.
        move  $a0, $t3          # Copy hundredths of the mileage to argument. 
        syscall

        li    $v0, 4            # Print the unit.
        la    $a0, unit 
        syscall

        j     main              # Ask anothe prompt.
        nop                     # Branch delay.

end:
        li    $v0, 10           # End program.
        syscall

