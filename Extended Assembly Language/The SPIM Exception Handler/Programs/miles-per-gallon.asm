        .data
miles:
        .asciiz "Enter the number of miles traveled: "
fuel:
        .asciiz "Enter the gallons of gasoline consumed: "
mileage:
        .asciiz "Your mileage is "
unit:
        .asciiz " miles per gallon\n\n"


        .text
main:
        li    $v0, 4            # Prompt the user for the miles traveled.
        la    $a0, miles
        syscall

        li    $v0, 5            # Get user miles traveled.
        syscall

        beq   $v0, $zero, end   # If user enters 0 miles, end program.
        move  $t0, $v0          # Copy miles traveled.

        li    $v0, 4            # Prompt the user for the fuel consumed.
        la    $a0, fuel 
        syscall

        li    $v0, 5            # Get user fuel consumed.
        syscall

        divu  $t0, $v0          # Miles/gallon = miles traveled / gallon consumed.
        mflo  $t1

        li    $v0, 4            # Print inital result body.
        la    $a0, mileage
        syscall

        li    $v0, 1            # Print mileage.
        move  $a0, $t1          # Copy computed mileage to argument. 
        syscall

        li    $v0, 4            # Print the unit.
        la    $a0, unit 
        syscall

        j     main              # Ask anothe prompt.
        nop                     # Branch delay.

end:
        li    $v0, 10           # End program.
        syscall

