package vn.hoidanit.laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import vn.hoidanit.laptopshop.domain.Blog;
import vn.hoidanit.laptopshop.service.BlogService;
import vn.hoidanit.laptopshop.service.UploadService;

@Controller
public class BlogAdminController {

    private final BlogService blogService;
    private final UploadService uploadService;

    public BlogAdminController(BlogService blogService, UploadService uploadService) {
        this.blogService = blogService;
        this.uploadService = uploadService;
    }

    @GetMapping("/admin/blog")
    public String getBlogList(Model model,
            @RequestParam("page") Optional<String> pageOptional) {

        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            }
        } catch (Exception e) {
            // page = 1
        }

        Pageable pageable = PageRequest.of(page - 1, 10);
        Page<Blog> blogsPage = this.blogService.fetchAllBlogs(pageable);
        List<Blog> blogs = blogsPage.getContent();

        model.addAttribute("blogs", blogs);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", blogsPage.getTotalPages());
        return "admin/blog/show";
    }

    @GetMapping("/admin/blog/create")
    public String getCreateBlogPage(Model model) {
        model.addAttribute("newBlog", new Blog());
        return "admin/blog/create";
    }

    @PostMapping("/admin/blog/create")
    public String handleCreateBlog(@ModelAttribute("newBlog") Blog blog,
            @RequestParam("blogFile") MultipartFile file) {
        String image = this.uploadService.handleSaveUploadFile(file, "blog");
        blog.setImage(image);
        this.blogService.handleSaveBlog(blog);
        return "redirect:/admin/blog";
    }

    @GetMapping("/admin/blog/{id}")
    public String getBlogDetail(Model model, @PathVariable long id) {
        Optional<Blog> blogOptional = this.blogService.fetchBlogById(id);
        if (blogOptional.isPresent()) {
            model.addAttribute("blog", blogOptional.get());
            model.addAttribute("id", id);
        }
        return "admin/blog/detail";
    }

    @GetMapping("/admin/blog/update/{id}")
    public String getUpdateBlogPage(Model model, @PathVariable long id) {
        Optional<Blog> currentBlog = this.blogService.fetchBlogById(id);
        if (currentBlog.isPresent()) {
            model.addAttribute("newBlog", currentBlog.get());
        }
        return "admin/blog/update";
    }

    @PostMapping("/admin/blog/update")
    public String handleUpdateBlog(@ModelAttribute("newBlog") Blog blog,
            @RequestParam("blogFile") MultipartFile file) {
        Optional<Blog> blogOptional = this.blogService.fetchBlogById(blog.getId());
        if (blogOptional.isPresent()) {
            Blog currentBlog = blogOptional.get();
            if (!file.isEmpty()) {
                String image = this.uploadService.handleSaveUploadFile(file, "blog");
                currentBlog.setImage(image);
            }
            currentBlog.setTitle(blog.getTitle());
            currentBlog.setContent(blog.getContent());
            this.blogService.handleSaveBlog(currentBlog);
        }
        return "redirect:/admin/blog";
    }

    @GetMapping("/admin/blog/delete/{id}")
    public String getDeleteBlogPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newBlog", new Blog());
        return "admin/blog/delete";
    }

    @PostMapping("/admin/blog/delete")
    public String postDeleteBlog(@ModelAttribute("newBlog") Blog blog) {
        this.blogService.deleteBlogById(blog.getId());
        return "redirect:/admin/blog";
    }

}
