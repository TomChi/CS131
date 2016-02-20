import java.util.concurrent.atomic.AtomicIntegerArray;

class GetNSet implements State {
    private AtomicIntegerArray value;
    private byte maxval;

    GetNSet(byte[] v) {  
    	int[] integers = new int[v.length];
    	for(int i = 0; i < v.length; i++){
    		integers[i] = v[i];
    	}
    	value = new AtomicIntegerArray(integers);
    	maxval = 127;
    	}

    GetNSet(byte[] v, byte m) { 
    	int[] integers = new int[v.length];
    	for(int i = 0; i < v.length; i++){
    		integers[i] = v[i];
    	}
    	value = new AtomicIntegerArray(integers);
    	maxval = m;
    	}

    public int size() { return value.length(); }

    public byte[] current() {
    	byte[] bytes = new byte[value.length()];
    	for (int i = 0; i < value.length(); i++){
    		bytes[i] = (byte)value.get(i);		
    	}
    	return bytes;
    }

    public boolean swap(int i, int j) {
	if (value.get(i) <= 0 || value.get(j) >= maxval) {
	    return false;
	}
	int v1 = value.get(i) - 1;
	value.set(i, v1);
	int v2 = value.get(j) + 1;
	value.set(j, v2);
	return true;
    }
    
}

