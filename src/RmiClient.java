import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.naming.Context;

public class RmiClient {

    public static void main(String[] args) throws RemoteException, NotBoundException, NamingException {
        String host = "localhost";
        if (args.length > 0)
            host = args[0];
        Context ctx = new InitialContext();
        ctx.lookup("rmi://"+host+":1099/Services");
    }
}