package vn.hoidanit.laptopshop.domain;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;
import java.time.LocalDateTime;

@StaticMetamodel(Blog.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class Blog_ {

	
	/**
	 * @see vn.hoidanit.laptopshop.domain.Blog#image
	 **/
	public static volatile SingularAttribute<Blog, String> image;
	
	/**
	 * @see vn.hoidanit.laptopshop.domain.Blog#createdAt
	 **/
	public static volatile SingularAttribute<Blog, LocalDateTime> createdAt;
	
	/**
	 * @see vn.hoidanit.laptopshop.domain.Blog#id
	 **/
	public static volatile SingularAttribute<Blog, Long> id;
	
	/**
	 * @see vn.hoidanit.laptopshop.domain.Blog#title
	 **/
	public static volatile SingularAttribute<Blog, String> title;
	
	/**
	 * @see vn.hoidanit.laptopshop.domain.Blog
	 **/
	public static volatile EntityType<Blog> class_;
	
	/**
	 * @see vn.hoidanit.laptopshop.domain.Blog#content
	 **/
	public static volatile SingularAttribute<Blog, String> content;
	
	/**
	 * @see vn.hoidanit.laptopshop.domain.Blog#updatedAt
	 **/
	public static volatile SingularAttribute<Blog, LocalDateTime> updatedAt;

	public static final String IMAGE = "image";
	public static final String CREATED_AT = "createdAt";
	public static final String ID = "id";
	public static final String TITLE = "title";
	public static final String CONTENT = "content";
	public static final String UPDATED_AT = "updatedAt";

}

