*----------------------------------------------------------------------
* Programmer: Jaime Valero Solesio
* Class Account: cssc0394
* Assignment or Title: Assignment #1
* Filename: prog1.s
* Date completed:  10/20/2018
*----------------------------------------------------------------------
* Problem statement: 
* Input: Date in MM/DD/YYYY format
* Output: Formatted Date
* Error conditions tested: No Input Checking (Expecting Correct Format)
* Included files: 
* Method and/or pseudocode: 
* Prompt User	(print & read)
* Input is XXXXXXXXXX -->Connect to Month Retrieval(Prepare result, Calculate)--> Display Answer(Print)


* References: 
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
*
*----------------------------------------------------------------------
*
start:  initIO				* Initialize (required for I/O)
	setEVT					* Error handling routines
*	initF					* For floating point macros only	


	lineout title	
	lineout prompt
	
	linein	datein			* Input
	lea	datein,A0
	
	cvta2	datein,#2		* ASCII Months to 2's Comp
	
	move.l	D0,D1
	sub.l	#1,D1			* Month Index
	
	move.l	D1,D2
	
	muls	#11,D1		
	muls	#4,D2			* Month Length
	lea	month,A1			* Assigning month a memory address
	adda	D1,A1			* Pointer to Month address

	
	move.b	(A1)+,res		* Moving each byte of the Month Name
	move.b	(A1)+,res+1
	move.b	(A1)+,res+2
	move.b	(A1)+,res+3
	move.b	(A1)+,res+4
	move.b	(A1)+,res+5
	move.b	(A1)+,res+6
	move.b	(A1)+,res+7
	move.b	(A1)+,res+8
	move.b	(A1)+,res+9
	move.b	(A1)+,res+10
	move.b	(A1)+,res+11
	
	clr.b	(A1)+			* Null Terminate Months
	
	lea	res,A4				* Loading the Month name into an Address Reg
	lea	days,A2				* Load length of Month name into an Address Reg
	adda.l	D2,A2			* USE LONG
	adda.l	(A2),A4
	
	
	stripp	datein+3,#2		* Removing leading Zeros from the days
	move.b	datein+3,(A4)+	* Moving Days
	move.b	datein+4,(A4)
	suba.w	#1,A4
	adda.l	D0,A4			* Moving pointer to the correct address
	
	
	move.b	#',',(A4)+		* Moving Formated year
	move.b	#' ',(A4)+
	move.b	datein+6,(A4)+
	move.b	datein+7,(A4)+
	move.b	datein+8,(A4)+
	move.b	datein+9,(A4)+
	move.b	#'.',(A4)+
	
	clr.b	(A4)+			* Null Terminator
	
	lineout	answer			* Output, Contains formatted date
    


        break               * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations

datein: ds.b	80
prompt:	dc.b	'Enter the date in MM/DD/YYYY format',0
title:	dc.b	'Program 1, Jaime Valero Solesio, cssc0394',0
	
month:	dc.b	'January ',0,0,0
	dc.b	'February ',0,0
	dc.b	'March ',0,0,0,0,0
	dc.b	'April ',0,0,0,0,0
	dc.b	'May ',0,0,0,0,0,0,0
	dc.b	'June ',0,0,0,0,0,0
	dc.b	'July ',0,0,0,0,0,0
	dc.b	'August ',0,0,0,0
	dc.b	'September ',0
	dc.b	'October ',0,0,0
	dc.b	'November ',0,0
	dc.b	'December ',0,0
days:	dc.l 	8
	dc.l 	9
	dc.l 	6
	dc.l 	6
	dc.l 	4
	dc.l 	5
	dc.l	5
	dc.l 	7
	dc.l	10
	dc.l	8
	dc.l	9
	dc.l	9
	
answer:	dc.b	'The date entered is '

	
res:	ds.b	80
tot:	ds.b	80
        end
