package tester;


import data_structures.LinkedList;
import data_structures.HashListI;

/** 
 * @author Rob Edwards
 * 
 * This code is designed to help you test your Linked List code. It will create a generic linked list,
 * add some elements, and remove some elements. It is designed to work with a linked list program
 * called LinkedList.java that is in the data_structures package. 
 * 
 * You should confirm that this tests all the edge cases for your linked list. Remember the five situations
 * we discussed in class? Does this code test all of them, or should other methods be added?
 * 
 * Does this code test all methods in ListI?
 *
 * Remember, that per the instructions, your LinkedList code should not print any extra information - just 
 * what is printed by this tester.
 * 
 */
public class Tester {

	static LinkedList<Integer> llist = null;

	/**
	 * @param args
	 * The main method. In this case, we don't accept any arguments. We create a new linked list object
	 * and fill it with Integers.
	 */
	public static void main(String[] args) {

		boolean error = false;
		try {
			llist = new LinkedList<Integer>();
			
			// add n elements to the list
			int n = 25;
			for (int i=1; i<=n; i++)
				llist.add(i);

			if (llist.size() != n) {
				System.err.println("We added " + n + " elements to the start of the list, but the size reported was " + llist.size());
				error = true;
			}

			// check the list with the iterator. If n = 25, this should print
			// 25 24 23 22 21 ... 5 4 3 2 1
			
			llist.remove(19);
			System.out.println("Removed 19");
			System.out.println("Using the iterator to print from 25-1");
			for (Integer i : llist)
				System.out.print(i + " ");
			System.out.println(llist.size());

			

			// the size should be 0
			if (llist.size() != 0) {
				System.err.println("We removed everything from the list, but the size is still " + llist.size());
				error = true;
			}

			// now test the add last methods
			for (int i=1; i<=n; i++)
				llist.add(i);

			if (llist.size() != n) {
				System.err.println("We added " + n + " things to the list, but the size is " + llist.size());
				error = true;
			}
			// iterate through and print out the results
			// these should be in the opposite order from before.
			System.out.println("Using the iterator to print from 1-25");
			for (Integer i : llist)
				System.out.print(i + " ");
			System.out.println();

			// and remove last
			for (int i=n; i>0; i--) {
				int removed = llist.remove(i);
				if (removed != i) {
					System.err.println("Remove last returned " + removed + " but expected " + i);
					error = true;
				}
			}

			// add some things
			for (int i=1; i<=n; i++)
				llist.add(i);

			// now make the list empty
			llist.makeEmpty();

			// is the size 0?
			if (llist.size() != 0) {
				System.err.println("We made the list empty, but the size is still " + llist.size());
				error = true;
			}
			
			// now add one thing to the list
			llist.add(n+1);

			// this should be the only thing in the list
			for (int i : llist)
				if (i != (n+1)) {
					System.err.println("There should be only one thing in the list, but we got " + i);
					error = true;
				}
			
			// make empty again
			llist.makeEmpty();

			// now play at adding/removing
			llist.add(n+2);
			llist.remove(n+2);
			llist.add(n+3);

			// this should be the only thing in the list
			for (int i : llist)
				if (i != (n+3)) {
					System.err.println("There should be only one thing in the list, but we got " + i);
					error = true;
				
				}
			llist.makeEmpty();
		}
		catch (Exception e) {
			System.err.println("Your linked list code threw an exception. You need to fix this." +
					" Take a look at this stack trace to see what is wrong:");
			e.printStackTrace();
			System.exit(-1);
		}
		if (error)
			System.out.println("FAIL. There were one or more errors while running the code");
		else
			System.out.println("SUCCESS. All the tests ran");
	}
}
