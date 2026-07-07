package vn.hoidanit.laptopshop.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import vn.hoidanit.laptopshop.domain.Role;
import vn.hoidanit.laptopshop.repository.RoleRepository;

@Component
public class RoleInitializer implements CommandLineRunner {

    private final RoleRepository roleRepository;

    public RoleInitializer(RoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }

    @Override
    public void run(String... args) throws Exception {
        if (roleRepository.findByName("OWNER") == null) {
            Role ownerRole = new Role();
            ownerRole.setName("OWNER");
            ownerRole.setDescription("Owner role");
            roleRepository.save(ownerRole);
        }
        if (roleRepository.findByName("STAFF") == null) {
            Role staffRole = new Role();
            staffRole.setName("STAFF");
            staffRole.setDescription("Staff role");
            roleRepository.save(staffRole);
        }
    }
}
