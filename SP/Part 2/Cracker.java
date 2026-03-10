/* Problem 1 Part 2 : Group Members
->Kurudunje Deekshith Shetty - ks2378
->Yahya Sheikh - ys62
*/
import java.io.*;
import java.util.*;

public class Cracker
{
    public static void main(String[] args)
    {
        Map<String, String> shadow = readshadow("shadow");
        Map<String, String> common = readcommon("common-passwords.txt");

        if (shadow.isEmpty()||common.isEmpty())
        {
            System.out.println("File is empty");
            return;
        }
        crack(shadow, common);
    }

    private static Map<String, String> readshadow(String fileName)
    {
        Map<String, String> shadow = new HashMap<>();
        try (BufferedReader b = new BufferedReader(new FileReader(fileName)))
        {
            String line;
            while ((line = b.readLine())!=null)
            {
                String[] hashsplit = line.split(":");
                shadow.put(hashsplit[0], hashsplit[1]);
            }
        } catch (IOException e)
        {
            e.printStackTrace();
        }
        return shadow;
    }

    private static Map<String, String> readcommon(String fileName)
    {
        Map<String, String> common = new HashMap<>();
        try (BufferedReader b = new BufferedReader(new FileReader(fileName)))
        {
            String password;
            while ((password = b.readLine())!=null)
            {
                common.put(password, null);
            }
        } catch (IOException e)
        {
            e.printStackTrace();
        }
        return common;
    }

    private static void crack(Map<String, String> shadow, Map<String, String> common)
    {
        for (Map.Entry<String, String> entry : shadow.entrySet())
        {
            String username = entry.getKey();
            String shadowentry = entry.getValue();

            String[] hashsplit = shadowentry.split("\\$");
            String salt = hashsplit[2];

            for (Map.Entry<String, String> commonPassEntry : common.entrySet())
            {
                String commonPass = commonPassEntry.getKey();
                if(commonPass.length()<16){
                String hashedPass = MD5Shadow.crypt(commonPass, salt);
                if (hashedPass.equals(hashsplit[3]))
                {
                    System.out.println(username + ":" + commonPass);
                    break; 
                }
            } 
            }
        }
    }
}
