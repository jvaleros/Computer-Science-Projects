/**	@author: Jaime Valero Solesio
 *  Program: Assignment #2
 *  Class: CS 310
 *  CS Account: cssc0363
 *  Instructor: Prof. Edwards
 * 	Date: 09 April 2019
 * 
 */
package data_structures;

import java.util.Iterator;
import java.util.NoSuchElementException;

import data_structures.Hash.HashElement;
import data_structures.LinkedList.IteratorHelper;
import data_structures.LinkedList.Node;

/**
 * The linked list for our hash will only implement the
 * methods in the HashListI interface, a reduced set of
 * methods compared to the linked list from Assignment 1.
 * 
 * @author:Jaime Valero Solesio
 *
 */
public class LinkedList<E> implements HashListI<E> {

	class Node<E>{
		Node<E> next;
		E data;

		public Node(E obj)
		{
			data = obj;
			next = null;
		}
	}

	private Node<E> head;
	private int currentSize;

	public LinkedList(){
		head = null;
		currentSize = 0;
	}

	/**
	 * Adds object to our list 
	 * @param: E
	 */
	public void add(E obj) 
	{
		Node<E> newNode = new Node<E>(obj);
		newNode.next = head;
		head = newNode;
		currentSize++;
	}
	/**
	 * Removes object from our list 
	 * @param: E
	 * @return: E 
	 */
	public E remove(E obj) {
		Node<E> current = head, previous = null;
		while(current != null) 
		{
			if (((Comparable<E>)current.data).compareTo(obj) == 0)
			{
				if (head == current)
					head = head.next;
				if (current.next != null)
					previous.next = current.next;
				currentSize--;
			}
		}
		return obj;
	}
	/**
	 * Makes the list empty
	 */
	public void makeEmpty()
	{
		head = null;
		currentSize = 0;
	}
	/**
	 * Returns whether the list is empty or not
	 @return: True if the list is empty 
	 */
	public boolean isEmpty() 
	{
		return (head == null);
	}
	/**
	 * Returns the list size
	 @return: An int with the list size 
	 */
	public int size() 
	{
		return currentSize;
	}
	/**
	 * Checks if the list contains a given Object
	 * @param The object to check for
	 * @return True/False Depending if the object was found
	 */
	public boolean contains(E obj) 
	{
		Node<E> tmp  = head;
		while (tmp != null)
		{
			if (((Comparable<E>)tmp.data).compareTo(obj) == 0) 
			{
				return true;
			}
			tmp = tmp.next;
		}
		return false;
	}

	public Iterator<E> iterator() {
		// Iterates through the different nodes
		return new IteratorHelper();
	}

	class IteratorHelper  implements Iterator<E>{
		// Overrides iterator methods
		Node<E> index;
		public IteratorHelper(){
			index = head;
		}

		public boolean hasNext(){
			return  index != null;
		}

		public  E next(){
			if (! hasNext())
				throw new NoSuchElementException();
			E tmp = index.data;
			index = index.next;
			return tmp;
		}
	}
}
