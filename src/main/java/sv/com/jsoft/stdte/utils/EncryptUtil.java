package sv.com.jsoft.stdte.utils;

import org.apache.commons.lang3.RandomStringUtils;

public class EncryptUtil {

    public static String encrypt(String toEncrypt){
        return toEncrypt; //Base64.getEncoder().encodeToString(Aes.encrypt(toEncrypt).getBytes());
    }

    public static String decrypt(String toEncrypt){
        return toEncrypt; //Aes.decrypt(new String(Base64.getDecoder().decode(toEncrypt)));
    }

    public static String generateRandomPassword(int value){
        return RandomStringUtils.randomAlphanumeric(value);
    }
}
