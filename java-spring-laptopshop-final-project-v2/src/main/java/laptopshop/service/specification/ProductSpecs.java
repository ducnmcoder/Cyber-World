package laptopshop.service.specification;

import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import laptopshop.domain.Product;
import laptopshop.domain.Product_;
import jakarta.persistence.criteria.Predicate;
import java.util.ArrayList;

public class ProductSpecs {
    public static Specification<Product> nameLike(String name) {
        return (root, query, criteriaBuilder) -> {
            String likePattern = "%" + name + "%";
            return criteriaBuilder.or(
                criteriaBuilder.like(root.get("name"), likePattern),
                criteriaBuilder.like(root.get("shortDesc"), likePattern),
                criteriaBuilder.like(root.get("detailDesc"), likePattern),
                criteriaBuilder.like(root.get("color"), likePattern),
                criteriaBuilder.like(root.get("target"), likePattern)
            );
        };
    }

    // case 1
    public static Specification<Product> minPrice(double price) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.ge(root.get("price"), price);
    }

    // case 2
    public static Specification<Product> maxPrice(double price) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.le(root.get("price"), price);
    }

    // case3
    public static Specification<Product> matchFactory(String factory) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Product_.FACTORY), factory);
    }

    // case4
    public static Specification<Product> matchListFactory(List<String> factory) {
        if (factory.contains("all")) return (root, query, cb) -> cb.conjunction();
        return (root, query, criteriaBuilder) -> criteriaBuilder.in(root.get(Product_.FACTORY)).value(factory);
    }

    // case4
    public static Specification<Product> matchListTarget(List<String> targets) {
        if (targets.contains("all")) return (root, query, cb) -> cb.conjunction();
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
        return (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();
            jakarta.persistence.criteria.Join<Object, Object> specJoin = root.join("specification", jakarta.persistence.criteria.JoinType.LEFT);
            for (String c : cpu) {
                if (c.equals("all")) continue;
                
                if (c.equals("Apple M1 Series")) {
                    predicates.add(criteriaBuilder.or(criteriaBuilder.like(specJoin.get("cpuTechnology"), "Apple M1%"), criteriaBuilder.like(root.get("cpu"), "Apple M1%")));
                } else if (c.equals("Apple M2 Series")) {
                    predicates.add(criteriaBuilder.or(criteriaBuilder.like(specJoin.get("cpuTechnology"), "Apple M2%"), criteriaBuilder.like(root.get("cpu"), "Apple M2%")));
                } else if (c.equals("Apple M3 Series")) {
                    predicates.add(criteriaBuilder.or(criteriaBuilder.like(specJoin.get("cpuTechnology"), "Apple M3%"), criteriaBuilder.like(root.get("cpu"), "Apple M3%")));
                } else if (c.equals("Apple M4 Series")) {
                    predicates.add(criteriaBuilder.or(criteriaBuilder.like(specJoin.get("cpuTechnology"), "Apple M4%"), criteriaBuilder.like(root.get("cpu"), "Apple M4%")));
                } else if (c.equals("Apple M5 Series")) {
                    predicates.add(criteriaBuilder.or(criteriaBuilder.like(specJoin.get("cpuTechnology"), "Apple M5%"), criteriaBuilder.like(root.get("cpu"), "Apple M5%")));
                } else {
                    predicates.add(criteriaBuilder.or(criteriaBuilder.like(specJoin.get("cpuTechnology"), "%" + c + "%"), criteriaBuilder.like(root.get("cpu"), "%" + c + "%")));
                }
            }
            if (predicates.isEmpty()) return criteriaBuilder.conjunction();
            return criteriaBuilder.or(predicates.toArray(new Predicate[0]));
        };
    }

    public static Specification<Product> matchListRam(List<String> ram) {
        return (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();
            jakarta.persistence.criteria.Join<Object, Object> specJoin = root.join("specification", jakarta.persistence.criteria.JoinType.LEFT);
            for (String r : ram) {
                if (r.equals("all")) continue;
                if (r.equals("8GB")) {
                    predicates.add(criteriaBuilder.and(
                        criteriaBuilder.or(
                            criteriaBuilder.like(specJoin.get("ramCapacity"), "%8GB%"),
                            criteriaBuilder.like(root.get("ram"), "%8GB%")
                        ),
                        criteriaBuilder.notLike(specJoin.get("ramCapacity"), "%128GB%"),
                        criteriaBuilder.notLike(root.get("ram"), "%128GB%")
                    ));
                } else {
                    predicates.add(criteriaBuilder.or(
                        criteriaBuilder.like(specJoin.get("ramCapacity"), "%" + r + "%"),
                        criteriaBuilder.like(root.get("ram"), "%" + r + "%")
                    ));
                }
            }
            if (predicates.isEmpty()) return criteriaBuilder.conjunction();
            return criteriaBuilder.or(predicates.toArray(new Predicate[0]));
        };
    }

    public static Specification<Product> matchListStorage(List<String> storage) {
        return (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();
            jakarta.persistence.criteria.Join<Object, Object> specJoin = root.join("specification", jakarta.persistence.criteria.JoinType.LEFT);
            for (String s : storage) {
                if (s.equals("all")) continue;
                predicates.add(criteriaBuilder.or(
                    criteriaBuilder.like(specJoin.get("storageCapacity"), "%" + s + "%"),
                    criteriaBuilder.like(root.get("storage"), "%" + s + "%")
                ));
            }
            if (predicates.isEmpty()) return criteriaBuilder.conjunction();
            return criteriaBuilder.or(predicates.toArray(new Predicate[0]));
        };
    }

    public static Specification<Product> matchListColor(List<String> color) {
        return (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();
            for (String c : color) {
                if (c.equals("all")) continue;
                predicates.add(criteriaBuilder.like(criteriaBuilder.lower(root.get(Product_.COLOR)), "%" + c.toLowerCase() + "%"));
            }
            if (predicates.isEmpty()) return criteriaBuilder.conjunction();
            return criteriaBuilder.or(predicates.toArray(new Predicate[0]));
        };
    }

    public static Specification<Product> matchListScreen(List<String> screen) {
        return (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();
            for (String s : screen) {
                if (s.equals("all")) continue;

                if (s.equals(">= 14 inch") || s.equals("<= 14 inch")) {
                    predicates.add(criteriaBuilder.lessThanOrEqualTo(root.get(Product_.SCREEN_SIZE), "14.9"));
                } else if (s.equals("15 - >= 16 inch") || s.equals("15 - 16 inch")) {
                    predicates.add(criteriaBuilder.between(root.get(Product_.SCREEN_SIZE), "15.0", "16.9"));
                } else if (s.equals("17 - >= 18 inch") || s.equals("17 - >=18 inch") || s.equals("17 - 18 inch")) {
                    predicates.add(criteriaBuilder.between(root.get(Product_.SCREEN_SIZE), "17.0", "18.9"));
                } else {
                    predicates.add(criteriaBuilder.equal(root.get(Product_.SCREEN_SIZE), s));
                }
            }
            if (predicates.isEmpty()) return criteriaBuilder.conjunction();
            return criteriaBuilder.or(predicates.toArray(new Predicate[0]));
        };
    }

    public static Specification<Product> matchListGpu(List<String> gpu) {
        return (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();
            jakarta.persistence.criteria.Join<Object, Object> specJoin = root.join("specification", jakarta.persistence.criteria.JoinType.LEFT);
            for (String g : gpu) {
                if (g.equals("all")) continue;
                predicates.add(criteriaBuilder.like(criteriaBuilder.lower(specJoin.get("gpuModel")), "%" + g.toLowerCase() + "%"));
            }
            if (predicates.isEmpty()) return criteriaBuilder.conjunction();
            return criteriaBuilder.or(predicates.toArray(new Predicate[0]));
        };
    }

    public static Specification<Product> matchListHz(List<String> hz) {
        return (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();
            jakarta.persistence.criteria.Join<Object, Object> specJoin = root.join("specification", jakarta.persistence.criteria.JoinType.LEFT);
            for (String h : hz) {
                if (h.equals("all")) continue;
                predicates.add(criteriaBuilder.like(criteriaBuilder.lower(specJoin.get("screenRefreshRate")), "%" + h.toLowerCase() + "%"));
            }
            if (predicates.isEmpty()) return criteriaBuilder.conjunction();
            return criteriaBuilder.or(predicates.toArray(new Predicate[0]));
        };
    }

    public static Specification<Product> matchListSecurity(List<String> security) {
        return (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();
            jakarta.persistence.criteria.Join<Object, Object> specJoin = root.join("specification", jakarta.persistence.criteria.JoinType.LEFT);
            for (String sec : security) {
                if (sec.equals("all")) continue;
                predicates.add(criteriaBuilder.like(criteriaBuilder.lower(specJoin.get("security")), "%" + sec.toLowerCase() + "%"));
            }
            if (predicates.isEmpty()) return criteriaBuilder.conjunction();
            return criteriaBuilder.or(predicates.toArray(new Predicate[0]));
        };
    }

    public static Specification<Product> matchPrice(double min, double max) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.and(
                criteriaBuilder.ge(root.get("originalPrice"), min),
                criteriaBuilder.le(root.get("originalPrice"), max));
    }

    // case6
    public static Specification<Product> matchMultiplePrice(double min, double max) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.between(
                root.get("price"), min, max);
    }

}
