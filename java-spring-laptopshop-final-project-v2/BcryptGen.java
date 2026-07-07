public class BcryptGen {
    public static void main(String[] args) throws Exception {
        // Since we don't want to figure out classpath, let's just use a known hash.
        // Wait, I can just write a quick script that uses the JARs in the project if I know where they are, 
        // or just use a well known one. Let's use a very well known one: 
        // $2a$12$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIvi is actually NOT valid (it was made up).
        // Let's use $2a$10$wT8zG... no. 
        // Let's just write a script and run it using maven:
    }
}
