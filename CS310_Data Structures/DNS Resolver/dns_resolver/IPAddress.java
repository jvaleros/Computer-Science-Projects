package dns_resolver;

/**
 * The IPAddress is using iIPv4 and has dotted-decimal notation, with the network, two subnets, 
 * and host separated by periods. For example, the IP address 130.191.226.146 has 
 * a network of 130, a subnet of 191, the second subnet is 226, and the host address is 146.
 * 
 * Your IPAddress class should accept a string of dotted-decimal IPAddresses in the constructor
 * and separate them into the components. 
 *
 * Note: The templates for some methods have been provided, but you should consider which additional
 * methods to add to this class.
 * 
 * @see <a href="https://en.wikipedia.org/wiki/IP_address#IPv4_addresses">Wikipedia IPv4 addresses</a>
 * @author Jaime Valero Solesio
 *
 */

public class IPAddress implements Comparable<IPAddress> {

	int network;
	int subnet;
	int subnet2;
	int host;
	String ip;

	/**
	 * The constructor for the IPAddress class
	 * @param ip the dotted-decimal IP address
	 */
	public IPAddress(String ip) {
		this.ip = ip;
		String data[] = ip.split("\\.");
		network = Integer.parseInt(data[0]);
		subnet = Integer.parseInt(data[1]);
		subnet2 = Integer.parseInt(data[2]);
		host = Integer.parseInt(data[3]);
	}

	/**
	 * Overrides hashCode
	 * @return An integer with the result of hashCode
	 */
	@Override
	public int hashCode() {
		return ip.hashCode();
	}

	/**
	 * Checks if a passed object is the same as our original object
	 * @param Another Object
	 * @return True/False Depending on the result
	 */
	@Override
	public boolean equals(Object obj) {
		return ip.equals(obj);
	}

	/**
	 * Overrides toString
	 * @return A string representation of the IPAddress object
	 */
	@Override
	public String toString() {

		return ip;
	}

	/**
	 * Overrides compareTo
	 * @param The IP we want to compare to our original ip
	 * @return An integer with the result of the comparative
	 */
	@Override
	public int compareTo(IPAddress ip) {
		return (ip.toString()).compareTo(this.ip);
	}

}
