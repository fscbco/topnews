document.addEventListener('DOMContentLoaded', function() {
  function refreshStories() {
    fetch('/news')
      .then(function(response) {
        console.log('Stories refreshed!');
      })
      .catch(function(error) {
        console.log('Error refreshing stories.');
      });
  }
  setInterval(refreshStories, 600000);
});
