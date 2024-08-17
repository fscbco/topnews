import React, { useState, useEffect } from "react";
import { List } from '@mui/material';
import FavoritedStoriesListItem from "./FavoritedStoriesListItem";

export default FavoritedStoriesList = ({ lastFavoriteUpdate }) => {
  const [stories, setStories] = useState([]);

  useEffect(() => {
    fetch("/api/favorited_stories")
      .then((response) => response.json())
      .then((data) => setStories(data));
  }, [lastFavoriteUpdate]);

  return (
    <div>
      <List>
        {stories.map((story) => (
          <FavoritedStoriesListItem
            key={story.id}
            story={story}
          />
        ))}
      </List>
    </div>
  );
}