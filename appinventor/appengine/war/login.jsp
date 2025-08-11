<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.google.appinventor.server.util.UriBuilder" %>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>

<%
  String error = StringEscapeUtils.escapeHtml4(request.getParameter("error"));
  String useGoogleLabel = (String) request.getAttribute("useGoogleLabel");
  String locale = StringEscapeUtils.escapeHtml4(request.getParameter("locale"));
  String redirect = StringEscapeUtils.escapeHtml4(request.getParameter("redirect"));
  String repo = StringEscapeUtils.escapeHtml4((String) request.getAttribute("repo"));
  String autoload = StringEscapeUtils.escapeHtml4((String) request.getAttribute("autoload"));
  String galleryId = StringEscapeUtils.escapeHtml4((String) request.getAttribute("galleryId"));
  String newGalleryId = StringEscapeUtils.escapeHtml4(request.getParameter("ng"));
  if (locale == null) { locale = "en"; }
%>

<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8" />
  <title>OneMake Login</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background: linear-gradient(135deg, #4a90e2, #007aff);
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
      margin: 0;
    }
    .login-container {
      background: #fff;
      padding: 2rem;
      border-radius: 12px;
      box-shadow: 0 8px 24px rgba(0,0,0,0.2);
      width: 100%;
      max-width: 400px;
    }
    .login-container h1 {
      text-align: center;
      color: #333;
    }
    .login-container form {
      margin-top: 1rem;
    }
    .form-group {
      margin-bottom: 1.2rem;
    }
    label {
      display: block;
      margin-bottom: 0.3rem;
      color: #555;
    }
    input[type="text"], input[type="password"] {
      width: 100%;
      padding: 0.6rem;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 1rem;
    }
    input[type="submit"] {
      width: 100%;
      padding: 0.8rem;
      background-color: #007aff;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 1.1rem;
      cursor: pointer;
    }
    input[type="submit"]:hover {
      background-color: #005ecb;
    }
    .error {
      color: red;
      text-align: center;
      margin-bottom: 1rem;
    }
    .footer-links {
      text-align: center;
      margin-top: 1rem;
    }
    .footer-links a {
      margin: 0 0.5rem;
      color: #007aff;
      text-decoration: none;
      font-size: 0.9rem;
    }
  </style>
</head>
<body>
  <div class="login-container">
   <div style="text-align: center; margin-bottom: 1rem;">
      <img src="/static/images/onemake_logo.jpg" alt="ロゴ" style="max-width: 150px; height: auto;" />
    </div>
    <h1>ログイン</h1>

    <% if (error != null) { %>
      <div class="error"><b><%= error %></b></div>
    <% } %>

    <form method="POST" action="/login">
      <div class="form-group">
        <label for="email">メールアドレス</label>
        <input type="text" name="email" id="email" />
      </div>
      <div class="form-group">
        <label for="password">パスワード</label>
        <input type="password" name="password" id="password" />
      </div>

      <% if (locale != null && !locale.equals("")) { %>
        <input type="hidden" name="locale" value="<%= locale %>" />
      <% } %>
      <% if (repo != null && !repo.equals("")) { %>
        <input type="hidden" name="repo" value="<%= repo %>" />
      <% } %>
      <% if (autoload != null && !autoload.equals("")) { %>
        <input type="hidden" name="autoload" value="<%= autoload %>" />
      <% } %>
      <% if (galleryId != null && !galleryId.equals("")) { %>
        <input type="hidden" name="galleryId" value="<%= galleryId %>" />
      <% } %>
      <% if (newGalleryId != null && !newGalleryId.equals("")) { %>
        <input type="hidden" name="ng" value="<%= newGalleryId %>" />
      <% } %>
      <% if (redirect != null && !redirect.equals("")) { %>
        <input type="hidden" name="redirect" value="<%= redirect %>" />
      <% } %>

      <input type="submit" value="ログイン" />
    </form>
  </div>
</body>
</html>
