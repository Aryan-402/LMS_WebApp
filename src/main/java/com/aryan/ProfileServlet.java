package com.aryan;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String mobileNumber = request.getParameter("mobile_number");
        String bio = request.getParameter("bio");
        Part filePart = request.getPart("profileImage");

        // Define dynamic upload directory based on Tomcat's webapps folder
        String uploadPath = getServletContext().getRealPath("uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String fileName = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
            fileName = "uploads/" + fileName;  // Store relative path in database
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            // Keep old profile picture if no new image is uploaded
            if (fileName == null) {
                try (PreparedStatement psCheck = conn.prepareStatement("SELECT profile_picture FROM users WHERE username=?")) {
                    psCheck.setString(1, username);
                    ResultSet rs = psCheck.executeQuery();
                    if (rs.next()) {
                        fileName = rs.getString("profile_picture");
                    }
                }
            }

            try (PreparedStatement ps = conn.prepareStatement("UPDATE users SET name=?, email=?, mobile_number=?, bio=?, profile_picture=? WHERE username=?")) {
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, mobileNumber);
                ps.setString(4, bio);
                ps.setString(5, fileName); // Keep old image if no new one
                ps.setString(6, username);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("profile.jsp");
    }
}
