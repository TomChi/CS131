import java.util.concurrent.locks.ReentrantLock;
public class BetterSafe implements State {
    private byte[] value;
    private byte maxval;
    private ReentrantLock safe_lock;
    BetterSafe(byte[] v) { value = v; maxval = 127; safe_lock = new ReentrantLock(); }

    BetterSafe(byte[] v, byte m) { value = v; maxval = m; safe_lock = new ReentrantLock();}

    public int size() { return value.length; }

    public byte[] current() { return value; }

    public boolean swap(int i, int j) {
    safe_lock.lock();
	if (value[i] <= 0 || value[j] >= maxval) {
		safe_lock.unlock();
	    return false;
	}
	value[i]--;
	value[j]++;
	safe_lock.unlock();
	return true;
    }
}
