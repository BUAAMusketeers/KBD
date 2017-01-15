import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kabuda.entity.Response;
import com.kabuda.entity.User;
import org.junit.Test;

public class TestGson {

    @Test
    public void test(){
        User user = new User();
        user.setId(12);
        user.setPhoneNumber("232132131");
        user.setSex(0);
        Response<User> response = new Response<User>(1000, "success", user);
        Gson gson = new GsonBuilder().create();
        String result = gson.toJson(response);
        System.out.println(result);
    }
}
