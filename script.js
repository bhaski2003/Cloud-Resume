document.addEventListener('DOMContentLoaded', (event) => {
    // Set the last updated date in the update bar and footer
    const lastUpdatedDate = new Date().toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    });

    // Update bar
    const lastUpdatedBar = document.getElementById('last-updated');
    if (lastUpdatedBar) {
        lastUpdatedBar.textContent = `Last updated: ${lastUpdatedDate}`;
    }

    // Footer
    const lastUpdatedFooter = document.getElementById('last-updated-footer');
    if (lastUpdatedFooter) {
        lastUpdatedFooter.textContent = `Last Updated: ${lastUpdatedDate}`;
    }

    // Theme toggle functionality
    const themeToggle = document.getElementById('theme-toggle');
    const body = document.body;

    themeToggle.addEventListener('click', () => {
        body.classList.toggle('dark-theme');
        localStorage.setItem('theme', body.classList.contains('dark-theme') ? 'dark' : 'light');
    });

    // Check for saved theme preference or prefer-color-scheme
    const savedTheme = localStorage.getItem('theme');
    const prefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;

    if (savedTheme === 'dark' || (!savedTheme && prefersDark)) {
        body.classList.add('dark-theme');
    }
});
