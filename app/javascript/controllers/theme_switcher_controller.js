import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Theme switcher controller connected")
    // Get the current theme from localStorage or default to 'light'
    const currentTheme = localStorage.getItem('theme') || 'light'
    
    // Set the initial theme
    document.documentElement.setAttribute('data-theme', currentTheme)
    
    // Set active state for current theme
    this.setActiveTheme(currentTheme)
  }

  setTheme(event) {
    console.log("setTheme called", event.currentTarget.getAttribute('data-set-theme'))
    event.preventDefault()
    const theme = event.currentTarget.getAttribute('data-set-theme')
    
    // Set the theme
    document.documentElement.setAttribute('data-theme', theme)
    localStorage.setItem('theme', theme)
    
    // Update active state
    this.setActiveTheme(theme)
  }

  setActiveTheme(theme) {
    // Remove active class from all theme buttons
    document.querySelectorAll('[data-set-theme]').forEach(btn => {
      btn.classList.remove('active')
    })
    
    // Add active class to current theme button
    const activeButton = document.querySelector(`[data-set-theme="${theme}"]`)
    if (activeButton) {
      activeButton.classList.add('active')
    }
  }
} 