
package data_structures;

import java.util.Iterator;

import data_structures.LinkedList.IteratorHelper;

/** The methods in the Hash data structure are defined
 * by the HashI interface. The Hash consists of an array of Linked Lists,
 * the Linked Lists are defined by the HashListI interface.
 * 
 * 	@author: Jaime Valero Solesio
 *  Program: Assignment #2
 *  Class: CS 310
 *  CS Account: cssc0363
 *  Instructor: Prof. Edwards
 * 	Date: 09 April 2019
 *
 * @param <K> The key for entries in the hash
 * @param <V> The value for entries in the hash
 */

public class Hash<K, V> implements HashI<K,V> {

	/**
	 * HashElement Object Constructor
	 */
	class  HashElement<K, V> implements Comparable<HashElement<K,V>>{
		K key;
		V value;

		public HashElement(K key , V value) {
			this.key = key;
			this.value = value;
		}

		public  int compareTo(HashElement<K,V> o) {
			return (((Comparable<K>)this.key).compareTo(o.key));
		}
	}

	LinkedList<HashElement<K,V>>[] harray;
	int numElements;
	int size;
	double maxLoadFactor;

	/**
	 * Initializes our Dictionary with an array of LinkedLists
	 * @param size of the table
	 */
	public Hash(int size) {
		this.size = size;
		harray = (LinkedList<HashElement<K,V>> []) new LinkedList [size];
		for(int i = 0; i < size;i++){
			harray[i] = new LinkedList<HashElement<K,V>>();
		}
		maxLoadFactor = 0.75;
		numElements = 0;

	}
	/**
	 * Adds new elements to our HashTable
	 * @param <K> Key, <V> Value
	 * @return True or False if the value was added or not
	 */
	public boolean add(K key, V value) {
		// Do we need to resize?
		if (loadFactor() > maxLoadFactor){
			int newSize = size;
			resize(size * 2);
		}

		HashElement<K,V> newhe = new HashElement<K,V>(key, value);
		int hashval = key.hashCode();
		hashval = hashval & 0x7fffffff;   //(7 f's)
		hashval = hashval % size;
		harray[hashval].add(newhe);
		numElements++;
		return true;
	}
	/**
	 * Removes a given key from our Hash table
	 * @param <K> The key we want to remove
	 * @return True or False if the key was deleted
	 */
	public boolean remove(K key) {
		int hashval = key.hashCode();
		hashval = hashval & 0x7fffffff;   //(7 f's)
		hashval = hashval % size;
		for(HashElement<K,V> myhash : harray[hashval]) 
		{
			if(((Comparable<K>)key).compareTo(myhash.key)==0)
				harray[hashval].remove(myhash);
			return true;
		}
		return false;
	}
	/**
	 * Changes the value of a given key
	 * @param <K> & <V> A key and the new value we want our key to have
	 * @return True/False if the value was changed
	 */
	public boolean changeValue(K key, V value) {
		int hashval = key.hashCode() & 0x7fffffff % size;
		if (remove(key)) 
		{
			add(key,value);
			return true;
		}
		return false;
	}
	/**
	 * Is a given key contained in our table
	 * @param <K> The key we want to look for
	 * @return true if the table contains a given key
	 */
	public boolean contains(K key) {
		int hashval = key.hashCode();
		hashval = hashval & 0x7fffffff;   //(7 f's)
		hashval = hashval % size;
		for(HashElement<K,V> myhash : harray[hashval]) 
		{
			if(((Comparable<K>)key).compareTo(myhash.key)==0)
				return true;
		}
		return false;
	}
	/**
	 * Gets the value attached to a given key
	 * @param A key
	 * @return The V object attached to a given key
	 */
	public V getValue(K key) {
		int hashval = key.hashCode() & 0x7FFFFFFF % size;
		for(HashElement<K,V> newhe : harray[hashval]) {
			if(((Comparable<K>)key).compareTo(newhe.key)==0)
				return newhe.value;
		}
		return null;
	}
	/**
	 * @return the size of the table 
	 */
	public int size() {
		return size;
	}
	/**
	 * @return true/false if the table is empty or not
	 */
	public boolean isEmpty() {
		if (harray == null)
			return true;
		return false;
		//		return (harray == null);
	}
	/**
	 * Makes our table empty
	 */
	public void makeEmpty() {
		harray = null;
		numElements = 0;
	}
	/**
	 * @return The current loadFactor
	 */
	public double loadFactor() {
		return maxLoadFactor/size;
	}
	/**
	 * @return double LoadFactor (Getter)
	 */
	public double getMaxLoadFactor() {
		return this.maxLoadFactor;
	}
	/**
	 * Setter for the loadFator
	 * @param (double) The new loadfactor
	 */
	public void setMaxLoadFActor(double loadfactor) {
		maxLoadFactor = loadfactor;
	}
	/**
	 * Resizes the HashTable
	 * @param An int with the new size of our table
	 */
	public void resize(int newSize) {
		LinkedList<HashElement<K,V>>[] newarray;
		newarray = (LinkedList<HashElement<K,V>> []) new LinkedList [newSize];
		for (int i = 0 ; i < newSize ; i++)
		{
			newarray[i] = new LinkedList<HashElement<K,V>>();
		}
		for (K key:this) {
			V val = getValue(key);
			HashElement<K,V> newhe = new HashElement<K,V>(key,val);
			int hashval = (key.hashCode() &0x7fffffff) % newSize;
			newarray[hashval].add(newhe);
		}
		harray = newarray;
		size = newSize;
	}
	/**
	 * Key Iterator - in Inverse order
	 */
	public Iterator<K> iterator(){
		return new IteratorHelper();
	}
	class IteratorHelper<T> implements Iterator<T>{
		T[] keys;
		int position;
		public IteratorHelper() {
			keys = (T[]) new Object[numElements];
			int p = 0;
			for (int i = 0 ; i < size ; i++) {
				LinkedList<HashElement<K,V>> list = harray[i];

				for (HashElement<K,V> h : list)
					keys[p++] = (T) h.key;
			}
			position = 0;
		}
		public boolean hasNext() {
			return position < keys.length;
		}

		public T next() {
			if (!hasNext()) 
				return null;
			return keys[position++];
		}
	}
}
