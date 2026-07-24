package laptopshop.tools;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class BcryptGen {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String rawPassword = "123";
        String encodedPassword = encoder.encode(rawPassword);
        System.out.println("Encoded password for '123': " + encodedPassword);
        
        // You can verify it matches
        boolean matches = encoder.matches("123", encodedPassword);
        System.out.println("Matches '123'? " + matches);
    }
}