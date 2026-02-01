// code-toggle.js

// Global tab switching
function switchAllTabs(lang) {
  document.querySelectorAll(".panel-tabset").forEach(function(tabset){
    tabset.querySelectorAll(".nav-link").forEach(function(link){
      if(link.textContent.trim().toLowerCase() === lang.toLowerCase()){
        link.click();
      }
    });
  });
}

// Keypress support
document.addEventListener("keydown", function(event){
  const key = event.key.toLowerCase();
  if(key === "p") switchAllTabs("python");
  if(key === "r") switchAllTabs("r");
});

// Code to hide button at extreme zoom (400% plus) but keep for screen-readers
function updateToggleVisibility() {
  const toggle = document.getElementById('global-toggle');
  if (!toggle) return;

  const zoom = window.devicePixelRatio || 1;

  if (zoom >= 3) { // 300% zoom threshold
    toggle.classList.add('hidden-zoom');

    // Update ARIA to tell screen reader users what to do
    toggle.setAttribute('aria-label',
      'The global toggle is hidden. Use the R and P keys to switch all code tabs.');
  } else {
    toggle.classList.remove('hidden-zoom');
    toggle.setAttribute('aria-label', 'Global code switcher');
  }
}

// Run on load and resize
window.addEventListener('resize', updateToggleVisibility);
window.addEventListener('load', updateToggleVisibility);
