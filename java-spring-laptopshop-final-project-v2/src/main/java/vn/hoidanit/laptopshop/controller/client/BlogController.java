package vn.hoidanit.laptopshop.controller.client;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import vn.hoidanit.laptopshop.domain.Blog;
import vn.hoidanit.laptopshop.service.BlogService;

@Controller
public class BlogController {

    private final BlogService blogService;

    public BlogController(BlogService blogService) {
        this.blogService = blogService;
    }

    @GetMapping("/blogs")
    public String getBlogListPage(Model model,
            @RequestParam("page") Optional<String> pageOptional) {

        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            }
        } catch (Exception e) {
            // page = 1
        }

        Pageable pageable = PageRequest.of(page - 1, 6, Sort.by(Sort.Direction.DESC, "createdAt"));
        Page<Blog> blogsPage = this.blogService.fetchAllBlogs(pageable);
        List<Blog> blogs = blogsPage.getContent();

        model.addAttribute("blogs", blogs);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", blogsPage.getTotalPages());
        return "client/blog/show";
    }

    @GetMapping("/blog/{id}")
    public String getBlogDetailPage(Model model, @PathVariable long id) {
        Optional<Blog> blogOptional = this.blogService.fetchBlogById(id);
        if (blogOptional.isPresent()) {
            model.addAttribute("blog", blogOptional.get());
        }
        return "client/blog/detail";
    }

}
