import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kabuda.entity.User;
import com.kabuda.entity.domain.Response;
import org.apache.commons.lang3.StringUtils;
import org.junit.Test;

import java.util.Calendar;

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

    @Test
    public void testDate(){
        System.out.println(Calendar.getInstance().getTime().toString());
    }

    @Test
    public void testStringUtils(){

    }
}
