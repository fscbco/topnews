var userData;
var userId;
var authToken;

document.addEventListener('turbolinks:load', function() {
  userData = document.getElementById('user-data');

  // If current authenticated user exists
  if (userData) {
    userId = userData.getAttribute('data-user-id');
    authToken = userData.getAttribute('data-auth-token');

    // Fetch current user's starred story IDs for updating text of Star/Unstar button
    fetch('/starred_story_ids', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': authToken,
      },
      body: JSON.stringify({ user_id: userId }),
    })
      .then(response => response.json())
      .then(data => {
        const starredStoryIds = data.starred_story_ids;
        updateStarButtons(starredStoryIds);
      })
      .catch(error => console.error('Error fetching starred story IDs:', error));
    
    // Register event listeners for star buttons
    // Prevent multiple event listeners from being attached to star button
    document.querySelectorAll('.star-button').forEach(function(button) {
      button.removeEventListener('click', starButtonClickHandler);
      button.addEventListener('click', starButtonClickHandler);
    });
  }
});

function updateStarButtons(starredStoryIds) {
  document.querySelectorAll('.star-button').forEach(function(button) {
    const storyId = button.getAttribute('data-story-id');
    const isStarred = starredStoryIds.includes(Number(storyId));
    const buttonText = isStarred ? 'Unstar' : 'Star';

    button.textContent = buttonText;
    button.setAttribute('data-starred', isStarred);
  });
}

function starButtonClickHandler() {
  const button = this;

  // Capture data attributes from button
  const storyId = button.getAttribute('data-story-id');
  const title = button.getAttribute('data-story-title');
  const url = button.getAttribute('data-story-url');
  const score = button.getAttribute('data-story-score');
  const time = button.getAttribute('data-story-time');

  const authToken = userData.getAttribute('data-auth-token');
  // data-starred attribute tracks current starred/unstarred state of button
  // Determine if the action we take should be starring or unstarring the story
  const action = button.getAttribute('data-starred') === 'true' ? 'unstar' : 'star';

  // Send request to backend for starring and unstarring a story
  fetch('/stories/' + storyId + '/' + 'star', {
    method: action === 'star' ? 'POST' : 'DELETE',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': authToken,
    },
    body: JSON.stringify({
      story_id: storyId,
      title: title,
      url: url,
      score: score,
      time: time,
    }),
  })
    .then(function() {
      button.setAttribute('data-starred', action === 'star' ? true : false);
      const buttonText = action === 'star' ? 'Unstar' : 'Star';
      button.textContent = buttonText;
    })
    .catch(error => {
      console.error('Error creating or destroying star:', error);
    });
}




