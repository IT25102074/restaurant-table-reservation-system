(function () {
    function setupSearch() {
        const input = document.getElementById('tableSearch');
        const table = document.getElementById('tableListTable');
        const counter = document.getElementById('visibleCount');

        if (!input || !table) {
            return;
        }

        const rows = Array.from(table.querySelectorAll('tbody tr.data-row'));

        function updateCount() {
            const visible = rows.filter((row) => row.style.display !== 'none').length;
            if (counter) {
                counter.textContent = visible + ' shown';
            }
        }

        function runFilter() {
            const keyword = input.value.trim().toLowerCase();

            rows.forEach((row) => {
                const searchableText = Array.from(row.querySelectorAll('.searchable'))
                    .map((cell) => cell.textContent || '')
                    .join(' ')
                    .toLowerCase();

                row.style.display = searchableText.includes(keyword) ? '' : 'none';
            });

            updateCount();
        }

        input.addEventListener('input', runFilter);
        updateCount();
    }

    function setupDeleteConfirmation() {
        const forms = document.querySelectorAll('.delete-form');
        forms.forEach((form) => {
            form.addEventListener('submit', function (event) {
                const ok = window.confirm('Delete this table record?');
                if (!ok) {
                    event.preventDefault();
                }
            });
        });
    }

    document.addEventListener('DOMContentLoaded', function () {
        setupSearch();
        setupDeleteConfirmation();
    });
})();
