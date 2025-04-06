<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="com.aryan.DatabaseConnection" %>
<%
  HttpSession sessionUser = request.getSession(false);
  if (sessionUser == null || sessionUser.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
  }
  String username = (String) sessionUser.getAttribute("username");
  String name = "", email = "", mobile_number = "", bio = "", profilePicture = "images/default-profile.png";
  try (Connection conn = DatabaseConnection.getConnection();
       PreparedStatement ps = conn.prepareStatement("SELECT name, email, mobile_number, bio, profile_picture FROM users WHERE username=?")) {
    ps.setString(1, username);
    ResultSet rs = ps.executeQuery();
    if (rs.next()) {
      name = rs.getString("name");
      email = rs.getString("email");
      mobile_number = rs.getString("mobile_number");
      bio = rs.getString("bio");
      profilePicture = (rs.getString("profile_picture") != null) ? rs.getString("profile_picture") : profilePicture;
    }
  } catch (Exception e) {
    e.printStackTrace();
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Profile Page</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
  <style>
    .profile-container {
      width: 100%;
      max-width: 500px;
      background: white;
      border-radius: 10px;
      padding: 30px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      text-align: center;
      margin: auto;
    }
    .profile-picture {
      position: relative;
      width: 120px;
      height: 120px;
      border-radius: 50%;
      overflow: hidden;
      border: 4px solid #e74c3c;
      margin: 0 auto 20px;
    }
    .profile-picture img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    .upload-icon {
      position: absolute;
      bottom: 5px;
      left: 50%;
      transform: translateX(-50%);
      background: #e74c3c;
      color: white;
      border-radius: 50%;
      width: 30px;
      height: 30px;
      display: flex;
      justify-content: center;
      align-items: center;
      cursor: pointer;
      border: 2px solid white;
    }
    .upload-icon input {
      position: absolute;
      opacity: 0;
      width: 100%;
      height: 100%;
      cursor: pointer;
    }
  </style>
</head>
<body>
<div class="profile-container">
  <div class="profile-picture">
    <img src="<%= profilePicture %>" id="profileImage" alt="Profile">
    <div class="upload-icon" onclick="document.getElementById('profileUpload').click();">
      <input type="file" id="profileUpload" name="profileImage" accept="image/*" style="display: none;">
      <i class="bi bi-plus-lg"></i>
    </div>
  </div>
  <form action="ProfileServlet" method="post" enctype="multipart/form-data">
    <input type="text" class="form-control mb-3" name="name" value="<%= name %>" placeholder="Full Name" required>
    <input type="email" class="form-control mb-3" name="email" value="<%= email %>" placeholder="Email" required>
    <input type="text" class="form-control mb-3" name="mobile_number" value="<%= mobile_number %>" placeholder="Mobile Number">
    <textarea class="form-control mb-3" name="bio" placeholder="Bio"><%= bio %></textarea>
    <button type="submit" class="btn btn-danger w-100">Update</button>
  </form>
</div>
<script>
  document.getElementById("profileUpload").addEventListener("change", function(event) {
    let file = event.target.files[0];
    if (file) {
      let reader = new FileReader();
      reader.onload = function(e) {
        document.getElementById("profileImage").src = e.target.result;
      }
      reader.readAsDataURL(file);
    }
  });
</script>
</body>
</html>
