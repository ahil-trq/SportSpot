document.querySelectorAll('[data-price]').forEach((input) => {
    input.addEventListener('change', () => {
        const target = document.querySelector('[data-price-total]');
        const basePrice = Number(target?.dataset.basePrice || 0);
        const total = [...document.querySelectorAll('[data-price]:checked')].reduce((sum, item) => sum + Number(item.dataset.price), basePrice);
        if (target) target.textContent = total.toFixed(2).replace('.', ',') + ' EUR';
    });
});