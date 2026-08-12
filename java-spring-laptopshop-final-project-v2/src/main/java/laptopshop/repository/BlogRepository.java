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
}
