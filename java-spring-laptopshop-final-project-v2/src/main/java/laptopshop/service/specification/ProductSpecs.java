package laptopshop.service.specification;

import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import laptopshop.domain.Product;
import laptopshop.domain.Product_;
import jakarta.persistence.criteria.Predicate;
import java.util.ArrayList;

public class ProductSpecs {
    public static Specification<Product> nameLike(String name) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.like(root.get(Product_.NAME), "%" + name + "%");
    }

    // case 1
    public static Specification<Product> minPrice(double price) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.ge(root.get(Product_.PRICE), price);
    }

    // case 2
    public static Specification<Product> maxPrice(double price) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.le(root.get(Product_.PRICE), price);
    }

    // case3
    public static Specification<Product> matchFactory(String factory) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Product_.FACTORY), factory);
    }

    // case4
    public static Specification<Product> matchListFactory(List<String> factory) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.in(root.get(Product_.FACTORY)).value(factory);
    }

    // case4
    public static Specification<Product> matchListTarget(List<String> targets) {
        return (root, query, criteriaBuilder) -> {
            List<jakarta.persistence.criteria.Predicate> predicates = new java.util.ArrayList<>();
            for (String target : targets) {
                predicates.add(criteriaBuilder.like(root.get(Product_.TARGET), "%" + target + "%"));
            }
            return criteriaBuilder.or(predicates.toArray(new jakarta.persistence.criteria.Predicate[0]));
        };
    }

    // case5
    public static Specification<Product> matchListCpu(List<String> cpu) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.in(root.get(Product_.CPU)).value(cpu);
    }

    public static Specification<Product> matchListRam(List<String> ram) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.in(root.get(Product_.RAM)).value(ram);
    }

    public static Specification<Product> matchListStorage(List<String> storage) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.in(root.get(Product_.STORAGE)).value(storage);
    }

    public static Specification<Product> matchListScreen(List<String> screen) {
        return (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();
            for (String s : screen) {
                if (s.equals("Dưới 14 inch") || s.equals("Under 14 inch")) {
                    predicates.add(criteriaBuilder.lessThan(root.get(Product_.SCREEN_SIZE), "14.0"));
                } else if (s.equals("Từ 14 - 15 inch") || s.equals("14 - 15 inch")) {
                    predicates.add(criteriaBuilder.between(root.get(Product_.SCREEN_SIZE), "14.0", "15.0"));
                } else if (s.equals("Từ 15 - 17 inch") || s.equals("15 - 17 inch")) {
                    predicates.add(criteriaBuilder.between(root.get(Product_.SCREEN_SIZE), "15.0", "17.0"));
                } else if (s.equals("Trên 17 inch") || s.equals("Over 17 inch")) {
                    predicates.add(criteriaBuilder.greaterThan(root.get(Product_.SCREEN_SIZE), "17.0"));
                } else {
                    predicates.add(criteriaBuilder.equal(root.get(Product_.SCREEN_SIZE), s));
                }
            }
            return criteriaBuilder.or(predicates.toArray(new Predicate[0]));
        };
    }

    public static Specification<Product> matchListGpu(List<String> gpu) {
        return (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();
            for (String g : gpu) {
                predicates.add(criteriaBuilder.like(criteriaBuilder.lower(root.get("detailDesc")), "%" + g.toLowerCase() + "%"));
            }
            return criteriaBuilder.or(predicates.toArray(new Predicate[0]));
        };
    }

    public static Specification<Product> matchListHz(List<String> hz) {
        return (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();
            for (String h : hz) {
                predicates.add(criteriaBuilder.like(criteriaBuilder.lower(root.get("detailDesc")), "%" + h.toLowerCase() + "%"));
            }
            return criteriaBuilder.or(predicates.toArray(new Predicate[0]));
        };
    }

    public static Specification<Product> matchListSecurity(List<String> security) {
        return (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();
            for (String sec : security) {
                predicates.add(criteriaBuilder.like(criteriaBuilder.lower(root.get("detailDesc")), "%" + sec.toLowerCase() + "%"));
            }
            return criteriaBuilder.or(predicates.toArray(new Predicate[0]));
        };
    }

    public static Specification<Product> matchPrice(double min, double max) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.and(
                criteriaBuilder.gt(root.get(Product_.PRICE), min),
                criteriaBuilder.le(root.get(Product_.PRICE), max));
    }

    // case6
    public static Specification<Product> matchMultiplePrice(double min, double max) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.between(
                root.get(Product_.PRICE), min, max);
    }

}
