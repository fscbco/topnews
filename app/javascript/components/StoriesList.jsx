import React, { useState, useEffect } from "react";
import {
  List,
  ListItem,
  ListItemText,
  IconButton
} from '@mui/material';
import StarBorderIcon from '@mui/icons-material/StarBorder';

export default StoriesList = () => {
  const [stories, setStories] = useState([]);

  useEffect(() => {
    fetch("/api/stories")
      .then((response) => response.json())
      .then((data) => setStories(data));
  }, []);

  const handleFavorite = (storyId) => {
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

  return (
    <div>
      <h2>Stories List</h2>
      <List>
        {stories.map((story) => (
          <ListItem
            key={story.id}
            secondaryAction={
              <IconButton
                edge="end"
                aria-label="favorite"
                onClick={() => handleFavorite(story.id)}
              >
                <StarBorderIcon />
              </IconButton>
            }
          >
            <ListItemText
              primary={story.title}
              secondary={story.text}
            />
          </ListItem>,
        ))}
      </List>
    </div>
  );
}