package laptopshop.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import laptopshop.domain.Blog;

import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.Query;

public interface BlogRepository extends JpaRepository<Blog, Long> {
    Page<Blog> findAll(Pageable pageable);
    
    @Query("SELECT b FROM Blog b WHERE b.type = :type OR (b.type IS NULL AND :type = 'ARTICLE')")
    Page<Blog> findBlogsByType(@Param("type") String type, Pageable pageable);

    @Query("SELECT b FROM Blog b WHERE b.category = 'NEWS'")
    Page<Blog> findLatestNews(Pageable pageable);
    
    @Query("SELECT b FROM Blog b WHERE b.category = 'BLOG' OR b.category IS NULL")
    Page<Blog> findLatestBlogs(Pageable pageable);

    @Query("SELECT b FROM Blog b WHERE (b.category = :category OR (b.category IS NULL AND :category = 'BLOG')) AND (b.type = :type OR (b.type IS NULL AND :type = 'ARTICLE'))")
    Page<Blog> findBlogsByCategoryAndType(@Param("category") String category, @Param("type") String type, Pageable pageable);

    @Query("SELECT b FROM Blog b WHERE (b.category = :category OR (b.category IS NULL AND :category = 'BLOG')) AND (b.videoUrl IS NULL OR b.videoUrl = '')")
    Page<Blog> findBlogsByCategoryAndNoVideo(@Param("category") String category, Pageable pageable);

    @Query("SELECT b FROM Blog b WHERE (b.category = :category OR (b.category IS NULL AND :category = 'BLOG')) AND (b.videoUrl IS NOT NULL AND b.videoUrl != '')")
    Page<Blog> findBlogsByCategoryAndHasVideo(@Param("category") String category, Pageable pageable);
}
