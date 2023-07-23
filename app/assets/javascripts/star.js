document.addEventListener('DOMContentLoaded', function() {
  function toggleVisibility(group, event) {
    if (group.children[0].style.display === "none") {
      group.children[0].style.display = "flex";
      group.children[1].style.display = "none";
    } else {
      group.children[0].style.display = "none";
      group.children[1].style.display = "flex";
    }
  }
  
  const starGroups = document.getElementsByClassName("star-group")
  
  for (var i = 0; i < starGroups.length; i++) {
    const starGroup = starGroups[i];
  
    starGroup.addEventListener('click', (event) => {
      toggleVisibility(starGroup, event);
    });
  }
})
