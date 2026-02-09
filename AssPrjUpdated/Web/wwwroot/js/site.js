// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.

let passwordField = document.getElementById("Password");
let eyeButton = document.getElementById("eye-icon");
eyeButton?.addEventListener("click", () => {
    if (passwordField.type == "password") {
      passwordField.type = "text";
      eyeButton.classList.remove("fa-eye");
      eyeButton.classList.add("fa-eye-slash");
    } else {
      passwordField.type = "password";
      eyeButton.classList.add("fa-eye");
      eyeButton.classList.remove("fa-eye-slash");
    }
  });