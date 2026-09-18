document.querySelectorAll('[data-price]').forEach((input) => {
    input.addEventListener('change', () => {
        const target = document.querySelector('[data-price-total]');
        const basePrice = Number(target?.dataset.basePrice || 0);
        const total = [...document.querySelectorAll('[data-price]:checked')].reduce((sum, item) => sum + Number(item.dataset.price), basePrice);
        if (target) target.textContent = total.toFixed(2).replace('.', ',') + ' EUR';
    });
});

const resourceForm = document.querySelector('#resource-selection-form');
if (resourceForm) {
    const resourceInputs = [...resourceForm.querySelectorAll('[data-map-resource]')];
    const mapFacilities = [...resourceForm.querySelectorAll('.interactive-map .facility[data-anlage]')];
    const areaFilter = resourceForm.dataset.areaFilter || '';
    const maxPrice = Number(resourceForm.dataset.maxPrice || 0);

    const updateResourceSelection = (anlage) => {
        const input = resourceInputs.find((item) => item.dataset.mapResource === anlage);
        if (!input) return;
        input.checked = true;
        resourceInputs.forEach((item) => item.closest('[data-resource-card]')?.classList.toggle('is-selected', item === input));
        mapFacilities.forEach((facility) => facility.classList.toggle('is-selected', facility.dataset.anlage === anlage));
    };

    mapFacilities.forEach((facility) => {
        const outsideArea = areaFilter !== '' && facility.dataset.area !== areaFilter;
        const overBudget = maxPrice > 0 && Number(facility.dataset.price || 0) > maxPrice;
        facility.classList.toggle('is-filtered', outsideArea || overBudget);
    });

    resourceInputs.forEach((input) => input.addEventListener('change', () => updateResourceSelection(input.dataset.mapResource)));
    mapFacilities.forEach((facility) => {
        facility.addEventListener('click', (event) => {
            event.preventDefault();
            if (facility.classList.contains('is-filtered')) return;
            updateResourceSelection(facility.dataset.anlage);
        });
        facility.addEventListener('keydown', (event) => {
            if (event.key === 'Enter' || event.key === ' ') {
                event.preventDefault();
                if (facility.classList.contains('is-filtered')) return;
                updateResourceSelection(facility.dataset.anlage);
            }
        });
    });

    const selectedInput = resourceInputs.find((input) => input.checked);
    if (selectedInput) updateResourceSelection(selectedInput.dataset.mapResource);
}