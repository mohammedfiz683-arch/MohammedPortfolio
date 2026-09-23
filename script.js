document.addEventListener('DOMContentLoaded', () => {
    // Portfolio filtering logic
    const filterBtns = document.querySelectorAll('.filter-btn');
    const workItems = document.querySelectorAll('.bento-card, .grid-card');

    if (filterBtns.length > 0 && workItems.length > 0) {
        filterBtns.forEach(btn => {
            btn.addEventListener('click', () => {
                // Remove active class from all buttons
                filterBtns.forEach(b => b.classList.remove('active'));
                // Add active class to clicked button
                btn.classList.add('active');

                const filterValue = btn.getAttribute('data-filter');

                workItems.forEach(item => {
                    const categories = (item.getAttribute('data-category') || '').split(' ');
                    if (filterValue === 'all' || categories.includes(filterValue)) {
                        item.style.display = 'flex';
                    } else {
                        item.style.display = 'none';
                    }
                });
            });
        });
    }

    // Contact Form handling
    const contactForm = document.getElementById('contact-form');
    if (contactForm) {
        contactForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const btn = contactForm.querySelector('button[type="submit"]');
            const originalText = btn.innerHTML;
            
            btn.innerHTML = 'SENT! ✔';
            btn.classList.remove('primary');
            btn.classList.add('bg-green');
            btn.style.color = 'var(--neutral-black)';
            
            setTimeout(() => {
                contactForm.reset();
                btn.innerHTML = originalText;
                btn.classList.add('primary');
                btn.classList.remove('bg-green');
                btn.style.color = 'var(--bg-white)';
            }, 3000);
        });
    }
});
