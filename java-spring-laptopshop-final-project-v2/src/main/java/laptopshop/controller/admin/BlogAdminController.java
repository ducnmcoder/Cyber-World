package laptopshop.controller.admin;

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

import laptopshop.domain.Blog;
import laptopshop.service.BlogService;
import laptopshop.service.UploadService;

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
        Page<Blog> blogsPage = this.blogService.fetchLatestBlogs(pageable);
        List<Blog> blogs = blogsPage.getContent();

        model.addAttribute("blogs", blogs);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", blogsPage.getTotalPages());
        return "admin/blog/show";
    }

    @GetMapping("/admin/blog/create")
    public String getCreateBlogPage(Model model) {
        Blog blog = new Blog();
        blog.setCategory("BLOG");
        model.addAttribute("newBlog", blog);
        return "admin/blog/create";
    }

    @PostMapping("/admin/blog/create")
    public String handleCreateBlog(@ModelAttribute("newBlog") Blog blog,
            @RequestParam(value = "blogFile", required = false) MultipartFile file, @RequestParam(value = "imageUrl", required = false) String imageUrl,
            @RequestParam(value = "videoFile", required = false) MultipartFile videoFile) {
        
        blog.setCategory("BLOG");
        
        if (file != null && !file.isEmpty()) {
            String image = this.uploadService.handleSaveUploadFile(file, "blog");
            blog.setImage(image);
        } else if (imageUrl != null && !imageUrl.trim().isEmpty()) {
            blog.setImage(imageUrl.trim());
        }

        if ("VIDEO".equals(blog.getType()) && videoFile != null && !videoFile.isEmpty()) {
            String videoName = this.uploadService.handleSaveUploadFile(videoFile, "blog");
            blog.setVideoUrl("/images/blog/" + videoName);
        }

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
            @RequestParam(value = "blogFile", required = false) MultipartFile file, @RequestParam(value = "imageUrl", required = false) String imageUrl,
            @RequestParam(value = "videoFile", required = false) MultipartFile videoFile) {
        Optional<Blog> blogOptional = this.blogService.fetchBlogById(blog.getId());
        if (blogOptional.isPresent()) {
            Blog currentBlog = blogOptional.get();
            if (file != null && !file.isEmpty()) {
                String image = this.uploadService.handleSaveUploadFile(file, "blog");
                currentBlog.setImage(image);
            } else if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                currentBlog.setImage(imageUrl.trim());
            }
            if ("VIDEO".equals(blog.getType()) && videoFile != null && !videoFile.isEmpty()) {
                String videoName = this.uploadService.handleSaveUploadFile(videoFile, "blog");
                currentBlog.setVideoUrl("/images/blog/" + videoName);
            } else if (blog.getVideoUrl() != null && !blog.getVideoUrl().isEmpty()) {
                currentBlog.setVideoUrl(blog.getVideoUrl());
            }
            currentBlog.setTitle(blog.getTitle());
            currentBlog.setContent(blog.getContent());
            currentBlog.setType(blog.getType());
            currentBlog.setCategory("BLOG");
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

    // NEWS ENDPOINTS
    @GetMapping("/admin/news")
    public String getNewsList(Model model,
            @RequestParam("page") Optional<String> pageOptional) {

        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            }
        } catch (Exception e) {
            // page = 1
        }

        Pageable pageable = PageRequest.of(page - 1, 10, org.springframework.data.domain.Sort.by("createdAt").descending());
        Page<Blog> blogsPage = this.blogService.fetchLatestNews(pageable);
        List<Blog> blogs = blogsPage.getContent();

        model.addAttribute("blogs", blogs);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", blogsPage.getTotalPages());
        return "admin/news/show";
    }

    @GetMapping("/admin/news/create")
    public String getCreateNewsPage(Model model) {
        Blog blog = new Blog();
        blog.setCategory("NEWS");
        model.addAttribute("newBlog", blog);
        return "admin/news/create";
    }

    @PostMapping("/admin/news/create")
    public String handleCreateNews(@ModelAttribute("newBlog") Blog blog,
            @RequestParam(value = "blogFile", required = false) MultipartFile file, @RequestParam(value = "imageUrl", required = false) String imageUrl,
            @RequestParam(value = "videoFile", required = false) MultipartFile videoFile) {
        
        blog.setCategory("NEWS");
        
        if (file != null && !file.isEmpty()) {
            String image = this.uploadService.handleSaveUploadFile(file, "blog");
            blog.setImage(image);
        } else if (imageUrl != null && !imageUrl.trim().isEmpty()) {
            blog.setImage(imageUrl.trim());
        }

        if ("VIDEO".equals(blog.getType()) && videoFile != null && !videoFile.isEmpty()) {
            String videoName = this.uploadService.handleSaveUploadFile(videoFile, "blog");
            blog.setVideoUrl("/images/blog/" + videoName);
        }

        this.blogService.handleSaveBlog(blog);
        return "redirect:/admin/news";
    }

    @GetMapping("/admin/news/{id}")
    public String getNewsDetail(Model model, @PathVariable long id) {
        Optional<Blog> blogOptional = this.blogService.fetchBlogById(id);
        if (blogOptional.isPresent()) {
            model.addAttribute("blog", blogOptional.get());
            model.addAttribute("id", id);
        }
        return "admin/news/detail";
    }

    @GetMapping("/admin/news/update/{id}")
    public String getUpdateNewsPage(Model model, @PathVariable long id) {
        Optional<Blog> currentBlog = this.blogService.fetchBlogById(id);
        if (currentBlog.isPresent()) {
            model.addAttribute("newBlog", currentBlog.get());
        }
        return "admin/news/update";
    }

    @PostMapping("/admin/news/update")
    public String handleUpdateNews(@ModelAttribute("newBlog") Blog blog,
            @RequestParam(value = "blogFile", required = false) MultipartFile file, @RequestParam(value = "imageUrl", required = false) String imageUrl,
            @RequestParam(value = "videoFile", required = false) MultipartFile videoFile) {
        Optional<Blog> blogOptional = this.blogService.fetchBlogById(blog.getId());
        if (blogOptional.isPresent()) {
            Blog currentBlog = blogOptional.get();
            if (file != null && !file.isEmpty()) {
                String image = this.uploadService.handleSaveUploadFile(file, "blog");
                currentBlog.setImage(image);
            } else if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                currentBlog.setImage(imageUrl.trim());
            }
            if ("VIDEO".equals(blog.getType()) && videoFile != null && !videoFile.isEmpty()) {
                String videoName = this.uploadService.handleSaveUploadFile(videoFile, "blog");
                currentBlog.setVideoUrl("/images/blog/" + videoName);
            } else if (blog.getVideoUrl() != null && !blog.getVideoUrl().isEmpty()) {
                currentBlog.setVideoUrl(blog.getVideoUrl());
            }
            currentBlog.setTitle(blog.getTitle());
            currentBlog.setContent(blog.getContent());
            currentBlog.setType(blog.getType());
            currentBlog.setCategory("NEWS");
            this.blogService.handleSaveBlog(currentBlog);
        }
        return "redirect:/admin/news";
    }

    @GetMapping("/admin/news/delete/{id}")
    public String getDeleteNewsPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newBlog", new Blog());
        return "admin/news/delete";
    }

    @PostMapping("/admin/news/delete")
    public String postDeleteNews(@ModelAttribute("newBlog") Blog blog) {
        this.blogService.deleteBlogById(blog.getId());
        return "redirect:/admin/news";
    }

}
