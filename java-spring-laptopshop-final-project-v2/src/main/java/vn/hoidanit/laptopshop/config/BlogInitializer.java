package vn.hoidanit.laptopshop.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import vn.hoidanit.laptopshop.domain.Blog;
import vn.hoidanit.laptopshop.repository.BlogRepository;

@Component
@Order(2)
public class BlogInitializer implements CommandLineRunner {

    private final BlogRepository blogRepository;

    public BlogInitializer(BlogRepository blogRepository) {
        this.blogRepository = blogRepository;
    }

    @Override
    public void run(String... args) throws Exception {
        if (blogRepository.count() == 0) {
            Blog blog1 = new Blog();
            blog1.setTitle("Top 10 Laptops for Students in 2024");
            blog1.setContent(
                    "Choosing the right laptop for college can be overwhelming with so many options available. "
                            + "In this guide, we break down the top 10 laptops that offer the best balance of performance, "
                            + "portability, and price for students. From lightweight ultrabooks perfect for note-taking to "
                            + "powerful machines that can handle engineering software, we have got you covered. "
                            + "Key factors to consider include battery life (aim for 8+ hours), weight (under 1.5kg is ideal), "
                            + "and a comfortable keyboard for long typing sessions. Our top picks include the MacBook Air M3, "
                            + "Dell XPS 13, Lenovo ThinkPad X1 Carbon, and ASUS ZenBook 14. Each offers excellent build quality "
                            + "and reliable performance for everyday academic tasks.");
            blog1.setImage("blog-default.jpg");
            blogRepository.save(blog1);

            Blog blog2 = new Blog();
            blog2.setTitle("Gaming Laptop vs Desktop: Which Should You Choose?");
            blog2.setContent(
                    "The eternal debate between gaming laptops and desktops continues in 2024. "
                            + "Gaming laptops have made incredible strides in performance, with the latest RTX 40-series "
                            + "mobile GPUs delivering near-desktop performance. However, desktops still offer better "
                            + "value for money, easier upgradability, and superior cooling. If you travel frequently or "
                            + "have limited space, a gaming laptop is the clear winner. But if you want the absolute best "
                            + "performance and plan to upgrade components over time, a desktop is the way to go. "
                            + "Consider your budget carefully — a $1500 desktop will outperform a $1500 laptop in most cases. "
                            + "We also explore hybrid setups where you pair a gaming desktop with a lightweight laptop for "
                            + "portability.");
            blog2.setImage("blog-default.jpg");
            blogRepository.save(blog2);

            Blog blog3 = new Blog();
            blog3.setTitle("Essential Laptop Maintenance Tips");
            blog3.setContent(
                    "Your laptop is a significant investment, and proper maintenance can extend its lifespan by years. "
                            + "Start with regular cleaning — use compressed air to blow out dust from vents and keyboard. "
                            + "Keep your operating system and drivers updated for optimal performance and security. "
                            + "Manage your battery health by avoiding constant 100% charging; try to keep it between 20-80%. "
                            + "Install reliable antivirus software and perform regular scans. Back up your data regularly "
                            + "using cloud services or external drives. Defragment your HDD (skip this for SSDs) and "
                            + "uninstall programs you no longer use. Finally, invest in a quality laptop bag or sleeve "
                            + "to protect your device during transport. Following these simple tips will keep your laptop "
                            + "running smoothly for years to come.");
            blog3.setImage("blog-default.jpg");
            blogRepository.save(blog3);

            Blog blog4 = new Blog();
            blog4.setTitle("Understanding Laptop Specifications: A Beginner's Guide");
            blog4.setContent(
                    "Shopping for a laptop can be confusing when you are faced with a wall of technical specifications. "
                            + "Let us break down the key specs you need to understand. The CPU (processor) is the brain of "
                            + "your laptop — Intel Core i5/i7 or AMD Ryzen 5/7 are great choices for most users. RAM (memory) "
                            + "determines how many tasks you can run simultaneously — 8GB is minimum, 16GB is recommended. "
                            + "Storage comes in two types: SSD (fast, recommended) and HDD (slow, cheap). For display, "
                            + "look for at least Full HD (1920x1080) resolution. GPU matters mainly for gaming and creative "
                            + "work — integrated graphics are fine for everyday use. Battery capacity is measured in Wh "
                            + "(watt-hours) — higher is better. Understanding these basics will help you make an informed "
                            + "purchase decision.");
            blog4.setImage("blog-default.jpg");
            blogRepository.save(blog4);

            Blog blog5 = new Blog();
            blog5.setTitle("The Rise of AI-Powered Laptops in 2024");
            blog5.setContent(
                    "Artificial Intelligence is transforming the laptop industry in unprecedented ways. "
                            + "The latest generation of laptops features dedicated NPUs (Neural Processing Units) that "
                            + "enable on-device AI capabilities. Intel's Meteor Lake and AMD's Ryzen 8000 series both "
                            + "include integrated AI accelerators. These NPUs power features like intelligent noise "
                            + "cancellation during video calls, AI-enhanced photo and video editing, smart battery "
                            + "optimization, and predictive performance tuning. Microsoft's Copilot integration in "
                            + "Windows 11 further leverages these AI capabilities for productivity tasks. Apple's M3 "
                            + "chip also includes a powerful Neural Engine. As AI becomes more integrated into our daily "
                            + "workflows, having dedicated AI hardware in your laptop will become increasingly important.");
            blog5.setImage("blog-default.jpg");
            blogRepository.save(blog5);

            Blog blog6 = new Blog();
            blog6.setTitle("Best Laptop Accessories You Need in 2024");
            blog6.setContent(
                    "The right accessories can dramatically improve your laptop experience. "
                            + "A good external monitor (27-inch, 4K) can boost productivity by giving you more screen space. "
                            + "A mechanical keyboard provides a superior typing experience for long work sessions. "
                            + "An ergonomic mouse reduces wrist strain compared to trackpads. A USB-C hub or docking station "
                            + "expands your connectivity options with multiple ports. Noise-canceling headphones are essential "
                            + "for focused work in noisy environments. A laptop stand improves ergonomics by raising the "
                            + "screen to eye level. An external SSD provides fast, portable backup storage. "
                            + "Finally, a quality webcam upgrade from the built-in camera makes a huge difference for "
                            + "video conferencing. Investing in these accessories will transform your laptop into a "
                            + "complete workstation.");
            blog6.setImage("blog-default.jpg");
            blogRepository.save(blog6);
        }
    }
}
