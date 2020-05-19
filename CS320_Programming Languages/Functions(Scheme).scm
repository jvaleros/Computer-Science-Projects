; p6.scm
; Program #6
; This program provides some functions to manipulate data constained
; in lists in Scheme
; CS 320
; December 9 2019
; @author Jaime Valero Solesio cssc0518
; Edit this file to add your documentation and function definitions.
; Leave the rest of this file unchanged.
; To run this file, you would start scheme at edoras command line prompt:
; scheme --load p6.scm, where the file is in the current directory
; and then in scheme type the load command (from the '%' prompt):
;(load "p6.scm")
;
; Defined LISTS for use with testing your functions.
(DEFINE list0 (LIST 'j 'k 'l 'm 'n 'o 'j) )
(DEFINE list1 (LIST 'a 'b 'c 'd 'e 'f 'g) )
(DEFINE list2 (LIST 's 't 'u 'v 'w 'x 'y 'z) )
(DEFINE list3 (LIST 'j 'k 'l 'm 'l 'k 'j) )
(DEFINE list4 (LIST 'n 'o 'p 'q 'q 'p 'o 'n) )
(DEFINE list5 '((a b) c (d e d) c (a b)) )
(DEFINE list6 '((h i) (j k) l (m n)) ) 
(DEFINE list7 '(f (a b) c (d e d) (b a) f) )
;
; Here is a typical function definition from Sebesta Ch. 15
(DEFINE (adder lis)
  (COND
    ((NULL? lis) 0)
	(ELSE (+ (CAR lis) (adder (CDR lis))))
))
; The above five lines are the sort of definition you would need to add to
; this file if asked to define an ADDER function.
; Uncomment and complete the following four definitions. At least have ODDS
; so the program can be tested.

(DEFINE (odds lst)
  (COND
    ((NOT(LIST? lst)) (ERROR "USAGE: (odds {list}"))
    ((NULL? lst) '())
    ((NULL? (CDR lst) ) CAR lst)
        (ELSE (CONS (CAR  lst) (odds (CDDR lst))))
))

; Odds returns the characters at even position in our list.
; To do this it recurses through the odd positions of the list

(DEFINE (evenrev lst)
  (COND
   ((NOT(LIST? lst)) (ERROR "USAGE: (evenrev {list}"))
   ((NULL? lst) '())
   ((NULL? (CDR lst)) '())
   (ELSE( APPEND (evenrev (CDDR lst)) (list (CADR lst))))

))

; Evenrev, similar to odd returns a list with the even characters 
; in the list.  These characters appear in inverse order.
; Recursive function.

(DEFINE (reverse-helper lst)
 (COND
  ((NOT(LIST? lst)) (ERROR "USAGE: (reverse-helper {list}"))
  ((NULL? lst) '())
  (ELSE( APPEND (reverse-helper (CDR lst)) (list (CAR lst))))
))

; This is my own reverse function that I use to help myself in 
; Palindrome. Similar logic is implemented in evenrev

(DEFINE (penultimate lst)
  (COND
   ((NOT(LIST? lst)) (ERROR "USAGE: (penultimate {list}"))
   ((NULL? lst) '())
   ((NULL? (CDR lst)) '())
   ((NULL? (CDDR lst)) (list(CAR lst)) )
  (ELSE (penultimate(CDR lst)) )
))

; Finds the penultimate item in a list by recursing through the 
; list

(DEFINE (palindrome lst)
 (COND
  ((NOT(LIST? lst)) (ERROR "USAGE: (palindrome {list}"))  
  ((NULL? lst) #t)
  ((NULL? (CDR lst)) #t)
  ((EQUAL? (CAR lst) (CAR (reverse-helper lst)))(palindrome (CDR (reverse-helper (CDR lst)))))
  (ELSE #f)
))

; Recursively checks whether a list is a palindrome or not, returns #t or #f as a result.

