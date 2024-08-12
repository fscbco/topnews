document.addEventListener('DOMContentLoaded', function () {
    var loadButton = document.getElementById('load-latest-news');
    var loadStatus = document.getElementById('load-status');

    if (loadButton) {
        loadButton.addEventListener('click', function () {
            loadStatus.textContent = 'Loading...';
            loadStatus.style.display = 'inline';
        });
    }
});