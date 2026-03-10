/*Problem 1 Part 1:Group members 
-> Kurudunje Deekshith Shetty - ks2378
-> Yahya Sheikh - ys62
*/
import java.io.*;
import java.util.*;
import java.math.*;
import java.security.*;

public class SimpleCracker
{
    public static void main(String[] args)
    {
        Map<String, String> a = loadpass("common-passwords.txt");
        if (a.isEmpty())
        {
            System.out.println("Error: Common passwords list is empty or file not found.");
            return;
        }
        crackpass("shadow-simple", a);
    }

    private static Map<String, String> loadpass(String b)
    {
        Map<String, String> c = new HashMap<>();
        try (BufferedReader d = new BufferedReader(new FileReader(b)))
        {
            String e;
            while ((e = d.readLine()) != null)
            {
                c.put(e.trim(), "");
            }
        }
        catch (IOException f)
        {
            System.err.println("Error : Cannot read the password file: " + f.getMessage());
        }
        return c;
    }
    private static void crackpass(String g, Map<String, String> a)
    {
        try (BufferedReader h = new BufferedReader(new FileReader(g)))
        {
            String i;
            while ((i = h.readLine()) != null)
            {
                String[] j = i.split(":");
                if (j.length == 3) {
                    String k = j[0];
                    String l = j[1];
                    String m = j[2];

                    for (String n : a.keySet())
                    {
                        if (genhash(l, n).equals(m))
                        {
                            System.out.println(k + ":" + n);
                            break;
                        }
                    }
                }
                else
                {
                    System.err.println(" Error: Wrong entry in the shadow file: " + i);
                }
            }
        }
        catch (IOException o)
        {
            System.err.println("Error : Cannot read the shadow file: " + o.getMessage());
        }
    }

    private static String genhash(String p, String q)
    {
        String r = p + q;
        try{
            MessageDigest s = MessageDigest.getInstance("MD5");
            byte[] t = s.digest(r.getBytes());
            BigInteger u = new BigInteger(1, t);
            return String.format("%0" + (t.length << 1) + "X", u);
        }
        catch (NoSuchAlgorithmException v)
        {
            throw new RuntimeException("Not a MD5 algorithm", v);
        }
    }
}
