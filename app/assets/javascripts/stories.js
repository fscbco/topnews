document.addEventListener('DOMContentLoaded', () => {
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

    document.querySelectorAll('.star').forEach(starElement => {
        starElement.addEventListener('click', async (event) => {
            const storyId = starElement.getAttribute('data-id');
            const isStarred = starElement.classList.contains('starred');
            const response = await fetch(`/stories/${storyId}/${isStarred ? 'unstar' : 'star'}`, {
                method: 'PATCH',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': csrfToken
                }
            });

            if (response.ok) {
                const json = await response.json();
                if (json.success) {
                    starElement.classList.toggle('starred');
                    const isStarred = starElement.classList.contains('starred');
                    starElement.textContent = isStarred ? '★' : '☆';
                    updateStarredBy(starElement, json.starred_by);
                    window.location.reload();
                } else {
                    console.error(json.message || 'Failed to star/unstar the story');
                }
            } else {
                console.error('Failed to star/unstar the story');
            }
        });
    });

    function updateStarredBy(starElement, starredBy) {
        const storyNode = starElement.closest('li');
        const starredByElement = storyNode.querySelector('.starred-by');
        if (starredByElement) {
            if (starredBy.length > 0) {
                starredByElement.textContent = `Starred by: ${starredBy.join(', ')}`;
            } else {
                starredByElement.textContent = 'Starred by: No one yet';
            }
        }
    }

});