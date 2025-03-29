<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  HttpSession sessionUser = request.getSession(false);
  String fullName = (sessionUser != null) ? (String) sessionUser.getAttribute("fullName") : null;

  if (fullName == null) {
    response.sendRedirect("login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>LMS Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

  <style>
    body {
      display: flex;
      height: 100vh;
      overflow: hidden;
      background-color: #f8f9fa;
    }
    .sidebar {
      width: 250px;
      background-color: #343a40;
      color: white;
      height: 100vh;
      padding: 20px;
      position: fixed;
      left: 0;
      top: 0;
    }
    .sidebar .logo {
      display: flex;
      align-items: center;
      gap: 10px;
      font-size: 22px;
      font-weight: bold;
      margin-bottom: 20px;
    }
    .sidebar .logo img {
      width: 40px;
      height: 40px;
    }
    .sidebar .menu {
      list-style: none;
      padding: 0;
    }
    .sidebar .menu li {
      margin-bottom: 15px;
    }
    .sidebar .menu li a {
      color: white;
      text-decoration: none;
      display: flex;
      align-items: center;
      gap: 10px;
      font-size: 16px;
      padding: 10px;
      border-radius: 5px;
      transition: 0.3s;
    }
    .sidebar .menu li a:hover {
      background-color: #495057;
    }
    .content {
      margin-left: 250px;
      width: calc(100% - 250px);
      padding: 20px;
    }
    .navbar {
      background-color: white;
      padding: 15px 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
    }
    .profile-section {
      display: flex;
      align-items: center;
      gap: 15px;
    }
    .profile-section img {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      border: 2px solid #e74c3c;
    }
    .profile-section .username {
      font-weight: bold;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
      .content {
        margin-left: 0; /* Remove fixed margin for small screens */
        width: 100%;
      }
    }

    @media (max-width: 576px) {
      .navbar {
        flex-direction: column; /* Stack navbar content */
        text-align: center;
      }
      .profile-section {
        justify-content: center;
        margin-top: 5px;
      }
    }
  </style>
</head>
<body>

<!-- Sidebar Menu (Desktop) -->
<div class="sidebar d-md-block d-none">
  <div class="logo">
    <img src="images/logo.png" alt="Logo">
    <span>STABForge</span>
  </div>
  <ul class="menu">
    <li><a href="#"><i class="bi bi-house-door"></i> Dashboard</a></li>
    <li><a href="#"><i class="bi bi-journal-bookmark"></i> Courses</a></li>
    <li><a href="#"><i class="bi bi-bar-chart"></i> Progress</a></li>
    <li><a href="profile.jsp"><i class="bi bi-person"></i> Profile</a></li>
    <li><a href="#"><i class="bi bi-gear"></i> Settings</a></li>
    <li><a href="logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
  </ul>
</div>

<!-- Mobile Sidebar Toggle -->
<button class="btn btn-dark d-md-none position-fixed top-0 start-0 m-3" type="button" data-bs-toggle="offcanvas" data-bs-target="#mobileSidebar">
  <i class="bi bi-list"></i>
</button>

<!-- Mobile Sidebar -->
<div class="offcanvas offcanvas-start d-md-none" tabindex="-1" id="mobileSidebar">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title">Menu</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
  </div>
  <div class="offcanvas-body">
    <ul class="menu">
      <li><a href="#"><i class="bi bi-house-door"></i> Dashboard</a></li>
      <li><a href="#"><i class="bi bi-journal-bookmark"></i> Courses</a></li>
      <li><a href="#"><i class="bi bi-bar-chart"></i> Progress</a></li>
      <li><a href="profile.jsp"><i class="bi bi-person"></i> Profile</a></li>
      <li><a href="#"><i class="bi bi-gear"></i> Settings</a></li>
      <li><a href="logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
    </ul>
  </div>
</div>

<!-- Main Content -->
<div class="content">
  <!-- Navbar -->
  <div class="navbar d-flex justify-content-between align-items-center p-3 shadow-sm">
    <span class="company-name">Welcome to STABForge Learning Platform</span>
    <div class="profile-section d-flex align-items-center gap-2">
      <span class="username"><%= fullName %></span>
      <img src="images/profile.png" alt="Profile" class="rounded-circle border border-danger" width="40" height="40">
    </div>
  </div>

  <!-- Dashboard Content -->
  <div class="container mt-4">
    <div class="row">
      <div class="col-lg-8 col-md-10 mx-auto text-center">
        <h2>Dashboard Overview</h2>
        <p>Welcome to your LMS dashboard. Manage courses, students, and reports from here.</p>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
