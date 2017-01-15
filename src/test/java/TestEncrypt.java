import com.kabuda.util.Encrypt;
import org.junit.Test;

public class TestEncrypt {

    @Test
    public void test() {
        String strText = "123456";
        String result = Encrypt.SHA256(strText);
        System.out.println(result);
    }
}
