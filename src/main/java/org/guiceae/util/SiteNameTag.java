package org.guiceae.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.net.URL;

public class SiteNameTag extends SimpleTagSupport {
    @Override
    public void doTag() throws JspException {
        HttpServletRequest request = ((HttpServletRequest)((PageContext)getJspContext()).getRequest()) ;
        try{
            String siteUrl = new URL(request.getRequestURL().toString()).getAuthority();
            JspWriter out = getJspContext().getOut();
            out.print("http://" + siteUrl + "/");
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
