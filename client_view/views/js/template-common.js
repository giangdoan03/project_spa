// Handlebars helpers
Handlebars.registerHelper("lowercase", function (str) {
    return (str || "").toLowerCase();
});

Handlebars.registerHelper("formatPrice", function (value) {
    const p = parseFloat(value || 0);
    return isNaN(p) ? '' : `${p.toLocaleString("vi-VN")} ₫`;
});

Handlebars.registerHelper("eq", (a, b) => a === b);
Handlebars.registerHelper("gt", (a, b) => a > b);
Handlebars.registerHelper("formatPrice", function (value) {
    const p = parseFloat(value || 0);
    return isNaN(p) ? '' : `${p.toLocaleString("vi-VN")} ₫`;
});
Handlebars.registerHelper('lowercase', str => (str || '').toLowerCase());

Handlebars.registerHelper("safeImage", function(val) {
    try {
        if (typeof val === 'string') return val;
        if (Array.isArray(val)) return val[0]?.url || '';
        return val?.url || '';
    } catch {
        return '';
    }
});

