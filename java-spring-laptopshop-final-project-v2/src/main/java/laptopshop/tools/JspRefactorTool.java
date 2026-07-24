package laptopshop.tools;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Stream;

public class JspRefactorTool {
    
    public static void main(String[] args) {
        // Refactor images in JSP files
        refactorImages();
        System.out.println("Image refactoring completed.");
    }

    private static void refactorImages() {
        Path baseDir = Paths.get("../../src/main/webapp/WEB-INF/view");
        Pattern pattern = Pattern.compile("src=\"/images/product/\\$\\{([^}]+)\\.image}\"");

        try (Stream<Path> paths = Files.walk(baseDir)) {
            paths.filter(Files::isRegularFile)
                 .filter(p -> p.toString().endsWith(".jsp"))
                 .forEach(p -> {
                     try {
                         String content = Files.readString(p);
                         if (p.toString().contains("detail.jsp") && !p.toString().contains("order")) {
                             return; // Skip product detail.jsp as per original script
                         }
                         
                         Matcher matcher = pattern.matcher(content);
                         String newContent = matcher.replaceAll("src=\"\\$\\{$1.firstImage}\"");
                         
                         if (!newContent.equals(content)) {
                             Files.writeString(p, newContent);
                             System.out.println("Updated: " + p);
                         }
                     } catch (IOException e) {
                         System.err.println("Error processing file: " + p);
                     }
                 });
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
