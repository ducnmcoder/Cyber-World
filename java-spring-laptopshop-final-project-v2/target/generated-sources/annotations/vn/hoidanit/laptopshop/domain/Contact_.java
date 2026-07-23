package vn.hoidanit.laptopshop.domain;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;
import java.time.LocalDateTime;

@StaticMetamodel(Contact.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class Contact_ {

	
	/**
	 * @see vn.hoidanit.laptopshop.domain.Contact#createdAt
	 **/
	public static volatile SingularAttribute<Contact, LocalDateTime> createdAt;
	
	/**
	 * @see vn.hoidanit.laptopshop.domain.Contact#subject
	 **/
	public static volatile SingularAttribute<Contact, String> subject;
	
	/**
	 * @see vn.hoidanit.laptopshop.domain.Contact#fullName
	 **/
	public static volatile SingularAttribute<Contact, String> fullName;
	
	/**
	 * @see vn.hoidanit.laptopshop.domain.Contact#id
	 **/
	public static volatile SingularAttribute<Contact, Long> id;
	
	/**
	 * @see vn.hoidanit.laptopshop.domain.Contact#message
	 **/
	public static volatile SingularAttribute<Contact, String> message;
	
	/**
	 * @see vn.hoidanit.laptopshop.domain.Contact
	 **/
	public static volatile EntityType<Contact> class_;
	
	/**
	 * @see vn.hoidanit.laptopshop.domain.Contact#email
	 **/
	public static volatile SingularAttribute<Contact, String> email;
	
	/**
	 * @see vn.hoidanit.laptopshop.domain.Contact#status
	 **/
	public static volatile SingularAttribute<Contact, String> status;

	public static final String CREATED_AT = "createdAt";
	public static final String SUBJECT = "subject";
	public static final String FULL_NAME = "fullName";
	public static final String ID = "id";
	public static final String MESSAGE = "message";
	public static final String EMAIL = "email";
	public static final String STATUS = "status";

}

