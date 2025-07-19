// Theme switcher functionality
document.addEventListener('DOMContentLoaded', function() {
  // Get the current theme from localStorage or default to 'light'
  const currentTheme = localStorage.getItem('theme') || 'light';
  
  // Set the initial theme
  document.documentElement.setAttribute('data-theme', currentTheme);
  
  // Add click event listeners to theme buttons
  document.addEventListener('click', function(e) {
    if (e.target.matches('[data-set-theme]')) {
      e.preventDefault();
      const theme = e.target.getAttribute('data-set-theme');
      
      // Set the theme
      document.documentElement.setAttribute('data-theme', theme);
      localStorage.setItem('theme', theme);
      
      // Update active state
      document.querySelectorAll('[data-set-theme]').forEach(btn => {
        btn.classList.remove('active');
      });
      e.target.classList.add('active');
    }
  });
  
  // Set active state for current theme
  const activeButton = document.querySelector(`[data-set-theme="${currentTheme}"]`);
  if (activeButton) {
    activeButton.classList.add('active');
  }
}); 