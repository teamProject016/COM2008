import java.net.*;
import java.security.*;

class AccessTest {
  public static void main(String[] args) {
    SocketPermission sp = new SocketPermission(
    "my.host.name:6000", "connect");
    try {
      AccessController.checkPermission(sp);
      System.out.println("OK to open socket");
    }
    catch (AccessControlException ace) {
      ace.printStackTrace();
    }
  }
}
