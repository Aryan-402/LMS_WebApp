<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sign Up</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

  <style>
    body {
      background-color: #f8f9fa;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .signup-container {
      width: 90%;
      max-width: 900px;
      background: white;
      border-radius: 15px;
      box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
      overflow: hidden;
      display: flex;
      flex-wrap: wrap;
    }
    .left-section {
      flex: 1;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 0;
    }
    .left-section img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    .right-section {
      flex: 1;
      padding: 40px;
    }
    .form-control {
      border-radius: 10px;
      padding-right: 45px; /* Space for the eye icon */
    }
    .password-container {
      position: relative;
    }
    .toggle-password {
      position: absolute;
      right: 10px;
      top: 50%;
      transform: translateY(-50%);
      cursor: pointer;
      font-size: 18px;
      color: #6c757d;
      transition: color 0.3s ease-in-out;
    }
    .toggle-password:hover {
      color: #333;
    }
    .btn-custom {
      background-color: #e74c3c;
      color: white;
      border-radius: 10px;
      padding: 12px;
      font-size: 16px;
    }
    .btn-custom:hover {
      background-color: #c0392b;
    }
    .error-message {
      color: red;
      font-size: 14px;
      font-weight: bold;
    }
    @media (max-width: 768px) {
      .signup-container {
        flex-direction: column;
      }
      .left-section {
        height: 250px;
      }
    }
  </style>
</head>
<body>
<div class="signup-container">
  <div class="left-section">
    <img src="images/loginPage.png" alt="Illustration">
  </div>
  <div class="right-section text-center">
    <h2>Welcome!</h2>
    <p>Create your account below</p>

    <%-- Display error message from Servlet --%>
    <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
    <% if (errorMessage != null) { %>
    <p class="error-message"><%= errorMessage %></p>
    <% } %>

    <form action="signup" method="post">
      <input type="text" class="form-control mb-3" name="name" placeholder="Full Name" required>
      <input type="text" class="form-control mb-3" name="username" placeholder="Username" required>
      <input type="email" class="form-control mb-3" name="email" placeholder="Email" required>

      <!-- Password Field with Animated Eye Icon -->
      <div class="password-container mb-3">
        <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
        <i class="bi bi-eye-slash toggle-password" onclick="togglePassword('password', this)"></i>
      </div>

      <!-- Confirm Password Field with Animated Eye Icon -->
      <div class="password-container mb-3">
        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required>
        <i class="bi bi-eye-slash toggle-password" onclick="togglePassword('confirmPassword', this)"></i>
      </div>

      <button type="submit" class="btn btn-custom w-100">Sign Up</button>
    </form>

    <p class="mt-3">Already a member? <a href="login.jsp" class="text-decoration-none">Login here</a></p>
  </div>
</div>

<!-- Inline JavaScript for Password Toggle -->
<script>
  function togglePassword(fieldId, icon) {
    var passwordField = document.getElementById(fieldId);
    if (passwordField.type === "password") {
      passwordField.type = "text";
      icon.classList.remove("bi-eye-slash");
      icon.classList.add("bi-eye");
    } else {
      passwordField.type = "password";
      icon.classList.remove("bi-eye");
      icon.classList.add("bi-eye-slash");
    }
  }
</script>

</body>
</html>
