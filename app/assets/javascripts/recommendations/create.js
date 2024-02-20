document.addEventListener('turbolinks:load', function() {
  let recommendBtn = document.getElementById('recommend-button-<%= @story.id %>');
  let recommendationsList = document.getElementById('recommendations-list-<%= @story.id %>');

  console.log(recommendBtn, recommendationsList);

  if (recommendBtn) {
    let newBtnHTML = '<button onclick="removeRecommendation(<%= @story.story_id %>, <%= @recommended.id %>)" class="recommend" id="remove-recommend-button-<%= @story.story_id %>">Remove from Recommendations</button>';
    recommendBtn.outerHTML = newBtnHTML;
  }

  if (recommendationsList) {
    let newRecommendation = document.createElement('li');
    newRecommendation.innerHTML = '<%= @recommended.user.first_name + " " + @recommended.user.last_name %>';
    recommendationsList.appendChild(newRecommendation);
  }
});
