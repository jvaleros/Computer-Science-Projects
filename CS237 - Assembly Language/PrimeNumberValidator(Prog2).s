*----------------------------------------------------------------------
* Programmer: Jaime Valero Solesio
* Class Account: cssc0394
* Assignment or Title: Program 2 (Prime Number Validator)
* Filename: prog2.s
* Date completed:  11/19/2018
*----------------------------------------------------------------------
* Problem statement: 
* Input: Valid Base 10 number (3-5 Characters) - The program will check these conditions
* Output: The number & if it is prime or not
* Error conditions tested: Valid Base 10 Number, Length
* Included files: prog2.s
* Method and/or pseudocode: 
*		Prompt ->  Validation
*		 	   |        |	
*		        Length     Number
*	               /    \      /   \
*		    Invalid   Valid    Invalid
*		      /  	\/	   \
*		Reprompt    Check Prime   Reprompt	|| We will first check length
*	   (Error Length) 	/ \	  (Error Number)
*		   /	       /   \	   	\
*	     Restart	   Prime   Not Prime    Restart
*			     /	     \
*	  The number XXX is prime    The number XXX is not prime
*	
*	ninput	 - input
*	length	 - check Length
*	iLength  - Invalid length promps the user again
*	goodlgt	 - Convert ascii and prepare to check numbers
*	charval	 - Checks ascii chars to check if they are valid base 10 numbers
*	notval   - Invalid characters, reprompts the user to enter a number
*	goodchr  - Loop through input until it ends
*	chkprim	 - Checks if the number is prime or not
*	isPrime	 - The number is prime, we prepare the lineout to print our result
*	nPrime   - The number is not prime, we prepare the lineout to print our result
*	mvnum    - Move the digits to output
*	mvchar	 - Move the characters to output
*	clriter  - Clear the D2, to use as an iterator
*	clsout	 - Terminate Strings	
*
* References: Riggins Course Reader, Class notes
*----------------------------------------------------------------------
*
        ORG     $0
        DC.L    $3000           * Stack pointer value after a reset
        DC.L    start           * Program counter value after a reset
        ORG     $3000           * Start at location 3000 Hex
*
*----------------------------------------------------------------------
*
#minclude /home/cs/faculty/cs237/bsvc/macros/iomacs.s
#minclude /home/cs/faculty/cs237/bsvc/macros/evtmacs.s
*
*----------------------------------------------------------------------
*
* Register use
*	D1 - First Number
*	D2 - Iterator (Divisor)
*	D3 - Input in 2's Complement
*	D5 - Length of Input (Only altered after Stripping)
*	D6 - Iterator (Originally contains the input length)
*	D7 - Stores half of the input (+1)
*	A0 - Points to number
*	A1 - Points to number
*	A2 - Point to strout	(The first buffer)
*	A3 - Point to outstream (The second buffer)
*----------------------------------------------------------------------
*
start:  initIO                  * Initialize (required for I/O)
	setEVT			* Error handling routines
*	initF			* For floating point macros only	

	lineout header
ninput:	lineout prompt
	
	
	linein	buff
	move.l	D0,D5		* Move Input Length into D5 & D6
	move.l	D0,D6
length:	cmp.l	#3,D5		* Check Input to be between 3 & 5 characters
	blt	iLength
	cmp.l	#5,D5
	bgt	iLength
	bra	goodlgt
iLength: lineout notlgt		* Invalid length Reprompt
	bra ninput
goodlgt:			* Valid length prepare 2's comp from ascii, Start iterator (D2) to #1
	lea	buff,A1		* Save the 2 comp num to D1 and D3 (D1 will be altered when we divide)
	cvta2	buff,D5
	move.l	D0,D1
	move.l	#1,D2
	move.l	D1,D3
	clr.l	D0

charval:cmpi.b	#'0',(A1)	* Check valid base #10 number character
	blt	notval
	cmpi.b	#'9',(A1)
	bgt	notval
	bra	goodch

notval:	lineout notnum		* Invalid character, not a number, reprompt
	bra ninput

goodch:	adda.l	#1,A1		* Valid character, check next character unless it is the last character
	subi.l	#1,D6			
	cmpi.l	#0,D6		* When D6 reaches 0 there is no more characters to check
	beq	chkprim		* Input is valid, we will if it is prime
	bra	charval

chkprim:addi.l	#1,D2
	move.l	D3,D1
	cmp.w	#1,D3		* The number one is not considered prime
	beq	nPrime		* Exit the loop into the not prime section
	clr.l	D7
	move.l	D3,D7
	divu	D2,D1
	divu	#2,D7		* We only need to divide halfway through the input to know if it is prime
	addi.l	#1,D7		* We add one to half the input to avoid exception with the #2
	cmp.w	D2,D7		* If we reach this point it means the numbers is prime
	beq	isPrime		* It is prime we exit the loop
	swap	D1		* Move the rest portion of division to the word portion of memory
	clr.l	D7
	tst.w 	D1		* Check if D1 is #0
	bne	chkprim		* It is not #0, Reiterate
	bra	nPrime		* It is not prime, exit the loop into not prime sextion	
isPrime:lea	buff,A0		* Prepare memory and output buffers
	stripp	buff,D5
	move.l	D0,D5
	lea	strout,A2
	lea	outstr,A3
	clr.l	D1
	clr.l	D2
	move.l	#9,D1		* Number of times we need to iterate through nextstr
	bra	mvnum

nPrime:	lea	buff,A0
	stripp	buff,D5
	move.l	D0,D5
	lea	strout,A2
	lea	outstr,A3
	clr.l	D0
	clr.l	D1
	clr.l	D2
	move.l	#10,D0		* Pointer to correct memory address
	adda	D0,A3
	move.l	#13,D1		* Number of times we need to iterate through endbuff

mvnum:	cmp.l	D2,D5		
	ble	clriter
	move.b	(A0)+,(A2)+
	addi.l	#1,D2
	bra	mvnum
	clr.b	(A0)+		* Null terminate
	clr.b	(A1)+

clriter:clr.l	D2
	
mvchar:cmp.l	D2,D1		* Move characters at the end of the sentence
	ble	clsout
	move.b	(A3)+,(A2)+
	addi.l	#1,D2
	bra	mvchar
	
clsout:	clr.b	(A3)+	    	* Null terminators
	clr.b	(A2)+
	
	lineout	answer

        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations

header:	dc.b	'Program #2, Jaime Valero Solesio, cssc0394',0
prompt:	dc.b	'Enter a 3-5 digit number:',0	
notnum:	dc.b	'Not a number',0
notlgt:	dc.b	'Incorrect input length',0
buff:	ds.b	80
answer:	dc.b	'The number '
strout:	ds.b	80
outstr:	dc.b	' is prime',0
	dc.b	' is not prime',0
	
        end
