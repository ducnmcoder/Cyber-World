package vn.hoidanit.laptopshop.service;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Blog;
import vn.hoidanit.laptopshop.repository.BlogRepository;

@Service
public class BlogService {

    private final BlogRepository blogRepository;

    public BlogService(BlogRepository blogRepository) {
        this.blogRepository = blogRepository;
    }

    public Blog handleSaveBlog(Blog blog) {
        return this.blogRepository.save(blog);
    }

    public Page<Blog> fetchAllBlogs(Pageable pageable) {
        return this.blogRepository.findAll(pageable);
    }

    public Optional<Blog> fetchBlogById(long id) {
        return this.blogRepository.findById(id);
    }

    public void deleteBlogById(long id) {
        this.blogRepository.deleteById(id);
    }

    public long countBlogs() {
        return this.blogRepository.count();
    }

}
