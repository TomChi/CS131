import java.util.concurrent.atomic.AtomicIntegerArray;


public class BetterSorry implements State {
	    private AtomicIntegerArray value;
	    private byte maxval;

	    BetterSorry(byte[] v) {  
	    	int[] integers = new int[v.length];
	    	for(int i = 0; i < v.length; i++){
	    		integers[i] = v[i];
	    	}
	    	value = new AtomicIntegerArray(integers);
	    	maxval = 127;
	    	}

	    BetterSorry(byte[] v, byte m) { 
	    	int[] integers = new int[v.length];
	    	for(int i = 0; i < v.length; i++){
	    		integers[i] = v[i];
	    	}
	    	value = new AtomicIntegerArray(integers);
	    	maxval = m;
	    	
	    	}

	    public int size() { return value.length(); }

	    public byte[] current() {
	    	byte[] bytes = new byte[size()];
	    	for (int i = 0; i < size(); i++){
	    		bytes[i] = (byte)value.get(i);		
	    	}
	    	return bytes;
	    }

	    public boolean swap(int i, int j) {
		if (value.get(i) <= 0 || value.get(j) >= maxval) {
		    return false;
		}
		value.getAndDecrement(i);
		value.getAndIncrement(j);
		return true;
	    }
}
