
class Likes {
  constructor() {
    document.addEventListener("ajax:success", this.ajax_listener);
  }

  ajax_listener = (event) => {
    const [data, _status, _xhr] = event.detail;
    const { cmd, ...json } = data;

    switch (data.cmd) {
      case "update_story_likes":
        const { story_id, likers } = json;
        return this.update_story_likes(story_id, likers);
    }
  }

  update_story_likes(story_id, likers) {
    const storyLikeElementId = "story_likes_" + story_id;

    let newContents = "";
    if (likers.length > 0) {
      newContents = "Liked by: "
      newContents += likers
        .map(liker => liker.name)
        .join(", ")
    }

    this.replace_element(storyLikeElementId, newContents);
  }

  replace_element(elementId, newContents) {
    document.getElementById(elementId).innerHTML = newContents;
  }
}

new Likes();
