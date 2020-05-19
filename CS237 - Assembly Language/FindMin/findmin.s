*----------------------------------------------------------------------
* Programmer: Jaime Valero Solesio
* Class Account: cssc0394
* Assignment or Title: Findmin (Part of Assignment #4)
* Filename: findmin.s
* Date completed:  12/10/2018
*----------------------------------------------------------------------
* Problem statement: For this program you will be creating two .s files
* You will be building a subroutine in the findmin.s file and prog4.s file which will be your main.
* Your findmin.s subroutine will recursively find the minimum value of an array of values.
* Input: No user input (Array & Count will be passed as arguments)
* Output: Minimum Value of an Array of Numbers
* Error conditions tested: None
* Included files: prog4.s
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

	ORG $6000

findmin:

	link	A6,#0			* Stack
	movem.l	D1-D2/A1,-(SP)
	move.w	12(A6),D1		* Count
	move.l	8(A6),A1		* Array => A0

	clr.w	D2			* Clear 
	clr.w	D3			* Clear
	cmpi.w	#1,D1			* If count is one we reached our base case, exit recursive function
	beq	base
	adda.l	#2,A1			* Point to next element in the array
	subi.w	#1,D1			* Decrement our count
	move.w	D1,-(SP)	
	move.l	A1,-(SP)
	jsr 	findmin			* Call our recursive function
	adda.l	#6,SP
	move.w	D0,D2
	suba.l	#2,A1			* Point to previous element of the array
	move.w	(A1),D3			* Vals[0]
	cmp.w	D2,D3
	blt	newmin			* If minrest < 0 vals[0] we set a new minimum
	bra	teardwn
newmin:	clr.w	D0
	move.w	D3,D0
	bra	teardwn
	
base:	clr.w	D0	
	move.w	(A1),D0
teardwn:				* Fix Stack
	movem.l	(SP)+,D1-D2/A1
	unlk	A6
	rts



end

