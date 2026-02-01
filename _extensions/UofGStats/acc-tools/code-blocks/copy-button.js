/* This code is to ensure clipboard copy icons are always visible */

document.addEventListener("DOMContentLoaded", function() {
  // Ensure clipboard icons show
  document.querySelectorAll(".code-copy-button").forEach(function(btn){
    const icon = btn.querySelector("i.bi");
    if(icon && icon.innerHTML.trim() === "") {
      icon.classList.add("bi-clipboard");
    }
  });
});

// Tabbing to panels doesnt work on all browsers. But adding an empty href="" can help
// this is done by default in Quarto websites just not books, for some unknown reason
// Quarto 1.7.32

document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll(".panel-tabset:not(.unstyled) .nav-link").forEach(function(tab){
    if (!tab.hasAttribute("href")) {
      tab.setAttribute("href", "");
    }
  });
});

