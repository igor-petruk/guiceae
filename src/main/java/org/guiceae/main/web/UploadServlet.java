package org.guiceae.main.web;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;

import javax.inject.Singleton;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.Response;
import java.io.IOException;
import java.net.URI;
import java.sql.Blob;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * User: Igor Petruk
 * Date: 27.06.12
 * Time: 1:43
 */
@Singleton
public class UploadServlet extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
        Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
        resp.getWriter().println(Arrays.toString(blobs.keySet().toArray()));
        List<BlobKey> blobKeys = blobs.get("photos");
        
        int i = 0;
        for (BlobKey key:blobKeys){
            resp.getWriter().print(i+": "+key.getKeyString());
            resp.getWriter().print("<br/>");
            i++;    
        }
        
        if (blobKeys != null) {
            resp.getWriter().println(Arrays.toString(blobKeys.toArray()));
        }
    }
}
