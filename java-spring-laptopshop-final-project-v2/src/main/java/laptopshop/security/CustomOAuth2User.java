package laptopshop.security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.io.Serializable;
import java.util.List;

public class CustomOAuth2User implements OAuth2User, Serializable {

    private static final long serialVersionUID = 1L;

    private Map<String, Object> attributes;
    private List<SimpleGrantedAuthority> authorities;
    private String name;
    private String email;
    private String clientName;

    public CustomOAuth2User(OAuth2User oauth2User, String clientName) {
        this.attributes = new HashMap<>(oauth2User.getAttributes());
        this.authorities = new ArrayList<>();
        for (GrantedAuthority auth : oauth2User.getAuthorities()) {
            this.authorities.add(new SimpleGrantedAuthority(auth.getAuthority()));
        }
        
        this.name = oauth2User.getAttribute("name");
        this.email = oauth2User.getAttribute("email");
        this.clientName = clientName;

        if (this.email == null && "Facebook".equalsIgnoreCase(this.clientName)) {
            String id = oauth2User.getAttribute("id");
            if (id != null) {
                this.email = "facebook_" + id + "@facebook.local";
            }
        }
    }

    @Override
    public Map<String, Object> getAttributes() {
        return attributes;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getClientName() {
        return clientName;
    }
}

