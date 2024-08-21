function pinStory(storyId, button, event) {
  console.log("Pinning or Unpinning a story")

  event.preventDefault();
  fetch(`/news_stories/${storyId}/pin`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
      'Accept': 'application/json'
    },
    body: JSON.stringify({ id: storyId }),

  })
  .then(response => {
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    return response.text();
  })
  .then(() => {
    let icon = button.querySelector('.unpinned-thumbtack-icon');
    
    if (icon){
      icon.classList.replace('unpinned-thumbtack-icon', 'pinned-thumbtack-icon');
      showFlashMessage("Story successfully pinned!", 'success');
    } else {
      icon = button.querySelector('.pinned-thumbtack-icon');

      icon.classList.replace('pinned-thumbtack-icon', 'unpinned-thumbtack-icon');
      showFlashMessage("Story successfully unpinned!", 'alert');
    }
  })
  .catch(error => {
    console.error('Error:', error);
    showFlashMessage('An error occurred while pinning the story.', 'error');
  });
  
  function showFlashMessage(message, type) {
    const flashContainer = document.querySelector('.alert-float') || createFlashContainer();
    
    const alertClass = getAlertClass(type);
    const iconClass = getIconClass(type);
    
    const alertHtml = `
    <div class="alert ${alertClass} alert-dismissible fade show" role="alert">
    <i class="${iconClass} alert-icon"></i>
    <strong>${type.charAt(0).toUpperCase() + type.slice(1)}:</strong> ${message}
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    `;
    
    flashContainer.insertAdjacentHTML('beforeend', alertHtml);
    
    setTimeout(() => {
      const alertElement = flashContainer.lastElementChild;
      if (alertElement) {
        alertElement.remove();
      }
      if (flashContainer.children.length === 0) {
        flashContainer.remove();
      }
    }, 5000);
  }
  
  function createFlashContainer() {
    const container = document.createElement('div');
    container.className = 'alert-float';
    document.body.insertBefore(container, document.body.firstChild);
    return container;
  }
  
  function getAlertClass(type) {
    switch (type) {
      case 'success': return 'alert-success';
      case 'error': return 'alert-danger';
      case 'alert': return 'alert-warning';
      case 'notice': return 'alert-info';
      default: return 'alert-secondary';
    }
  }
  
  function getIconClass(type) {
    switch (type) {
      case 'success': return 'fas fa-check-circle';
      case 'error': return 'fas fa-exclamation-circle';
      case 'alert': return 'fas fa-exclamation-triangle';
      case 'notice': return 'fas fa-info-circle';
      default: return 'fas fa-bell';
    }
  }
}