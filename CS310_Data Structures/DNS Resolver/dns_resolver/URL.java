package dns_resolver;

/**
 * A URL Object is a representation of the URL that we have been giving. 
 * It knows how to compare URLs!
 *
 * Note: The templates for some methods have been provided, but you should consider which additional
 * methods to add to this class.
 * 
 * @author Jaime Valero Solesio
 *
 */
public class URL implements Comparable<URL> {

	String url;
	public URL(String url) {
		this.url = url;
	}

	/**
	 * Compares to URL objects
	 * @param URL we want to compare
	 * @return Integer with the result of the comparison
	 */
	@Override
	public int compareTo(URL obj) {
		return (obj.toString()).compareTo(url);
	}

	/**
	 * Converts a URL object to a String
	 * @return The URL as a string
	 */
	@Override
	public String toString() {
		return url;
	}
	/**
	 * Overrides hashCode method
	 * @return The hashcode as an integer
	 */
	@Override
	public int hashCode() {
		return url.hashCode();
	}
	/**
	 * Checks if a passed object is the same as our original object
	 * @param Another Object
	 * @return True/False Depending on the result
	 */
	@Override
	public boolean equals(Object obj) {
		return url.equals(obj);
	}

}
