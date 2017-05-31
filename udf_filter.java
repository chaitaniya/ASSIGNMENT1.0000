import java.io.IOException;

import org.apache.pig.FilterFunc;
import org.apache.pig.data.Tuple;

public class udf_filter extends FilterFunc {
    @Override
    public Boolean exec(Tuple input) throws IOException {
        try {
           String obj = input.get(0).toString();
            String per = input.get(1).toString();
            
            double a=Double.parseDouble(obj);
            double b=Double.parseDouble(per);
            
            double res = b/a;
            
            if(res>=0.8)
            {
            	return true;
            }
            else
            {
            	return false;
            }
            
        } catch (Exception ee) {
            throw ee;
        }
    }

	
} 