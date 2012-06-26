package org.guiceae.util;

import javax.inject.Singleton;
import javax.servlet.*;
import java.io.IOException;

@Singleton
public class EncodingFilter implements Filter{
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        chain.doFilter(request,response);
    }

    @Override
    public void destroy() {
    }
}
