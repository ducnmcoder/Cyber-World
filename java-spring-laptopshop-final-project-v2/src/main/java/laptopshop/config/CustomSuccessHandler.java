package laptopshop.config;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import laptopshop.domain.User;
import laptopshop.security.CustomOAuth2User;
import laptopshop.service.UserService;

public class CustomSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private UserService userService;

    protected String determineTargetUrl(final Authentication authentication) {

        Map<String, String> roleTargetUrlMap = new HashMap<>();
        roleTargetUrlMap.put("ROLE_USER", "/");
        roleTargetUrlMap.put("ROLE_ADMIN", "/admin/user");
        roleTargetUrlMap.put("ROLE_OWNER", "/admin");
        roleTargetUrlMap.put("ROLE_STAFF", "/staff");

        // First, try matching from Spring Security authorities
        final Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        for (final GrantedAuthority grantedAuthority : authorities) {
            String authorityName = grantedAuthority.getAuthority();
            if (roleTargetUrlMap.containsKey(authorityName)) {
                return roleTargetUrlMap.get(authorityName);
            }
        }

        // For OAuth2 login: authorities won't match ROLE_* directly,
        // so look up the user's role from the database instead.
        if (authentication.getPrincipal() instanceof CustomOAuth2User) {
            CustomOAuth2User oAuth2User = (CustomOAuth2User) authentication.getPrincipal();
            String email = oAuth2User.getEmail();
            if (email != null) {
                User user = userService.getUserByEmail(email);
                if (user != null && user.getRole() != null) {
                    String roleName = "ROLE_" + user.getRole().getName();
                    if (roleTargetUrlMap.containsKey(roleName)) {
                        return roleTargetUrlMap.get(roleName);
                    }
                }
            }
        }

        // Default fallback: redirect to home page
        return "/";
    }

    protected void clearAuthenticationAttributes(HttpServletRequest request, Authentication authentication) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return;
        }
        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);

        // Determine email based on authentication type
        String email;
        if (authentication.getPrincipal() instanceof CustomOAuth2User) {
            // OAuth2 login: get email from OAuth2 user attributes
            CustomOAuth2User oAuth2User = (CustomOAuth2User) authentication.getPrincipal();
            email = oAuth2User.getEmail();
        } else {
            // Form login: authentication.getName() returns the email (username)
            email = authentication.getName();
        }

        // query user
        User user = this.userService.getUserByEmail(email);
        if (user != null) {
            session.setAttribute("user", user);
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("avatar", user.getAvatar());
            session.setAttribute("id", user.getId());
            session.setAttribute("email", user.getEmail());
            int sum = user.getCart() == null ? 0 : user.getCart().getSum();
            session.setAttribute("sum", sum);
        }
    }

    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {

        String targetUrl = determineTargetUrl(authentication);

        if (response.isCommitted()) {
            return;
        }

        redirectStrategy.sendRedirect(request, response, targetUrl);
        clearAuthenticationAttributes(request, authentication);
    }

}
