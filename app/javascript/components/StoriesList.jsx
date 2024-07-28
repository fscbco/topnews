import React, { useState, useEffect } from "react";
import { List } from '@mui/material';
import StoriesListItem from "./StoriesListItem";

export default StoriesList = () => {
  const [stories, setStories] = useState([]);

  useEffect(() => {
    fetch("/api/stories")
      .then((response) => response.json())
      .then((data) => setStories(data));
  }, []);

  const favoriteStory = (storyId) => {
    fetch(`/api/stories/${storyId}/favorites`,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        }
      },
    );
  }

  const unfavoriteStory = (storyId) => {
    fetch(`/api/stories/${storyId}/favorite`,
      {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        }
      },
    );
  }

  return (
    <div>
      <h2>Stories List</h2>
      <List>
        {stories.map((story) => (
          <StoriesListItem
            key={story.id}
            story={story}
            favoriteStory={favoriteStory}
            unfavoriteStory={unfavoriteStory}
          />
        ))}
      </List>
    </div>
  );
}