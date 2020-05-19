*----------------------------------------------------------------------
* Programmer: Jaime Valero Solesio
* Class Account: cssc0394
* Assignment or Title: Assignment #4
* Filename: prog4.s
* Date completed:  12/10/2018
*----------------------------------------------------------------------
* Problem statement: For this program you will be creating two .s files
* You will be building a subroutine in the findmin.s file and prog4.s file which will be your main.
* Your findmin.s subroutine will recursively find the minimum value of an array of values.
* Input: None 
* Output: Minimum Value of an Array of Numbers
* Error conditions tested: None
* Included files: findmin.s
* Method and/or pseudocode: 
*	int findmin(int* vals, int count)
*	{
*		if(count == 1)
*			{
*				return vals[0];
*			}
*		else
*			{
*				int minrest = findmin(vals+1,count-1);
*				if (minrest < vals[0])
*				{
*				return minrest
*				}
*				else
*				{
*					return vals[0]
*				}
*			}
*	}
* References: TA (Nicholas), Riggins Reader (pg 192,193)
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
start: 
findmin:	EQU	$6000
	initIO                  * Initialize (required for I/O)
	setEVT			* Error handling routines
*	initF			* For floating point macros only	

	lineout prompt
	move.w	#5,-(SP)
	pea	nums
	jsr	findmin		* Call the recursive function findmin
	adda.l	#6,SP		* Allocate space for the Stack
	
	ext.l	D0		* Convert minimum to a long so I can cvt2a
	cvt2a	buffer,#6
	stripp	buffer,#6
	lea	buffer,A2
	adda.l	D0,A2
	clr.b	(A2)
	lineout	expmin
	lineout	answer

        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations

	prompt:	dc.b	'Program #4, Jaime Valero Solesio, cssc0394',0
	nums:	dc.w	556
		dc.w	834
		dc.w	321
		dc.w	4579
		dc.w	2096
	expmin:	dc.b	'Minimum number is: 321',0
	answer:	dc.b	'Found Minimum number is: '
	buffer:	ds.b	80 
        end
