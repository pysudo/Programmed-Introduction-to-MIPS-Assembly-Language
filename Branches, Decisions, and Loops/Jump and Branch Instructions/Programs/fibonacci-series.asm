    .text
main:
    ori   $2, $0, 1     # Initialize the current term to 1.
    ori   $1, $0, 0     # Initialize the previous term to 0.
    ori   $7, $0, 2     # Counter to correspond the initial 2 terms in the series.
    ori   $8, $0, 100   # Initialize the maximum terms of the series to be computed.

loop:
    beq   $7, $8  exit  # Branch out after 100 terms of the series is computed.
    sll   $0, $0, 0

    or    $3, $0, $2    # Make a copy of the current term.

    addu  $2, $1, $2    # Store the next term of the fibonacci series in $2.

    or    $1, $0, $3    # Update the previous term.
    addi  $7, $7, 1     # Increment the counter by 1.

    j     loop          # Compute the next term in the series.
    sll   $0, $0, 0

exit:
    sll   $0, $0, 0
