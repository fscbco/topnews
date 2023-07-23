document.addEventListener('DOMContentLoaded', function() {
  const CREATE_ENDPOINT = "/stars/create";
  const DELETE_ENDPOINT = "/stars/delete";

  function toggleStar(group, isStarred) {
    if (isStarred) {
      group.children[0].style.display = "none";
      group.children[1].style.display = "flex";
    } else {
      group.children[0].style.display = "flex";
      group.children[1].style.display = "none";
    }
  }

  function toggle(group, event) {
    const csrfToken = document.getElementsByName('csrf-token')[0].content;

    const isStarred = group.children[0].style.display === "flex";
    const endpoint = isStarred ? DELETE_ENDPOINT : CREATE_ENDPOINT;
    const story_id = group.getAttribute("id");

    fetch(endpoint, {
      method: "POST",
      headers: {
        "X-CSRF-Token": csrfToken,
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ story_id: story_id })
    }).then(response => {
      if (!response.ok) { throw response; }
      return response.json()
    }).then((data) => {
      console.log(data)

      toggleStar(group, isStarred);
    }).catch(error => {
      console.error("error", error)
    })
  }
  
  const starGroups = document.getElementsByClassName("star-group")
  
  for (var i = 0; i < starGroups.length; i++) {
    const starGroup = starGroups[i];
  
    starGroup.addEventListener('click', (event) => {
      toggle(starGroup, event);
    });
  }
})
