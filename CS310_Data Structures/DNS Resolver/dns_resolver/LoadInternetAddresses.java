package dns_resolver;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

import data_structures.Hash;
import data_structures.HashI;
import exceptions.FileFormatException;


/**
 * The LoadInternetAddresses class should take a filename as a string, uses BufferedReader
 * to read the file, split the lines into URLs and IPAddresses, and create the appropriate
 * objects. It should add those objects to a hash, and finally, after reading the whole file
 * it should return the instance of the hash.
 * 
 * If there is an error with the file format, you should throw a new FileFormatException error
 * with an appropriate message.
 *  
 * @author Jaime Valero Solesio
 *
 */
public class LoadInternetAddresses {

	Hash<URL, IPAddress> address;
	/**
	 * Constructor, creates a HashElement
	 *  Key - URL	Value - IPAddress 
	 */
	public LoadInternetAddresses() {
		address = new Hash<URL, IPAddress>(2);
	}

/**
 * Loads addresses from file
 * @param filename
 * @throws FileFormatException
 * @throws IOException
 */
	public HashI<URL, IPAddress> load_addresses(String filename) throws FileFormatException, IOException {

		try
		{
			/**
			 * Reads formatted file input & sorts into the appropriate URL & IPAddress objects
			 * It then adds this objects as a Hash element
			 */
			BufferedReader reader = new BufferedReader(new FileReader(filename));
			String line;
			String[] values;
			while((line = reader.readLine())!=null)	
			{
				values = line.split("\t");
				IPAddress ip = new IPAddress(values[0]);
				URL url = new URL(values[1]);
				address.add(url,ip);
				
			}
			reader.close();
		}

		catch(IOException e) {
			System.out.println("Could not find the file " + filename +" Error seems to be here: "+ e.toString());
		}

		return address;
	}
}
