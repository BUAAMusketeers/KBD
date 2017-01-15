import com.kabuda.util.Encrypt;
import org.junit.Test;

public class TestEncrypt {

    @Test
    public void test() {
        String strText = "123456";
        String resualt = Encrypt.SHA256(strText);
        System.out.println(resualt);
    }
}
