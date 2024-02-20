document.addEventListener('turbolinks:load', function () {
  let recommendationsList = document.getElementById('recommendations-list');
  let recommendation = document.getElementById('recommendation-' + storyId);
  let recommendBtn = document.getElementById('recommend-button-<%= @story.story_id %>');

  let removeRecommendBtn = document.getElementById('remove-recommend-button-<%= @story.story_id %>');

  removeRecommendBtn.setAttribute = hidden;
});