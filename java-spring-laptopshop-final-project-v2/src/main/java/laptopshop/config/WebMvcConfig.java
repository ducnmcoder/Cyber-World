package laptopshop.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

@Configuration
@EnableWebMvc
public class WebMvcConfig implements WebMvcConfigurer, ApplicationContextAware {

    private ApplicationContext applicationContext;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) {
        this.applicationContext = applicationContext;
    }

    @Bean
    public ViewResolver viewResolver() {
        final InternalResourceViewResolver bean = new InternalResourceViewResolver();
        bean.setViewClass(JstlView.class);
        bean.setPrefix("/WEB-INF/view/");
        bean.setSuffix(".jsp");
        bean.setOrder(2); // Lower priority than Thymeleaf
        return bean;
    }

    @Bean
    public org.thymeleaf.spring6.SpringTemplateEngine templateEngine(org.thymeleaf.spring6.templateresolver.SpringResourceTemplateResolver templateResolver) {
        org.thymeleaf.spring6.SpringTemplateEngine templateEngine = new org.thymeleaf.spring6.SpringTemplateEngine();
        templateEngine.setTemplateResolver(templateResolver);
        templateEngine.setEnableSpringELCompiler(true);
        return templateEngine;
    }

    @Bean
    public org.thymeleaf.spring6.templateresolver.SpringResourceTemplateResolver templateResolver() {
        org.thymeleaf.spring6.templateresolver.SpringResourceTemplateResolver templateResolver = new org.thymeleaf.spring6.templateresolver.SpringResourceTemplateResolver();
        templateResolver.setApplicationContext(this.applicationContext);
        templateResolver.setPrefix("classpath:/templates/");
        templateResolver.setSuffix(".html");
        templateResolver.setTemplateMode(org.thymeleaf.templatemode.TemplateMode.HTML);
        templateResolver.setCacheable(false);
        return templateResolver;
    }

    @Bean
    public ViewResolver thymeleafViewResolver(org.thymeleaf.spring6.SpringTemplateEngine templateEngine) {
        org.thymeleaf.spring6.view.ThymeleafViewResolver viewResolver = new org.thymeleaf.spring6.view.ThymeleafViewResolver();
        viewResolver.setTemplateEngine(templateEngine);
        viewResolver.setCharacterEncoding("UTF-8");
        viewResolver.setOrder(1); // Higher priority
        viewResolver.setViewNames(new String[]{"thymeleaf/*"}); // Only handle views prefixed with thymeleaf/
        return viewResolver;
    }

    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.viewResolver(viewResolver());
        
        // Ensure ThymeleafViewResolver is registered from the bean
        registry.viewResolver(applicationContext.getBean("thymeleafViewResolver", org.thymeleaf.spring6.view.ThymeleafViewResolver.class));
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/css/**").addResourceLocations("/resources/css/", "classpath:/static/css/");
        registry.addResourceHandler("/js/**").addResourceLocations("/resources/js/", "classpath:/static/js/");
        registry.addResourceHandler("/images/**").addResourceLocations("/resources/images/", "classpath:/static/images/");
        registry.addResourceHandler("/client/**").addResourceLocations("/resources/client/", "classpath:/static/client/");
    }

}
