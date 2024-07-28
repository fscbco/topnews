import React, { useState } from "react";
import {
  ListItem,
  ListItemText,
  IconButton
} from '@mui/material';
import StarIcon from '@mui/icons-material/Star';
import StarBorderIcon from '@mui/icons-material/StarBorder';

export default StoriesListItem = ({ story, favoriteStory, unfavoriteStory }) => {
  const [isFavorited, setIsFavorited] = useState(story.is_favorited);

  const handleFavorite = () => {
    if (isFavorited) {
      unfavoriteStory(story.id);
      setIsFavorited(false);
    } else {
      favoriteStory(story.id);
      setIsFavorited(true);
    }

  };

  return (
    <ListItem
      key={story.id}
      secondaryAction={
        <IconButton
          edge="end"
          aria-label="favorite"
          onClick={handleFavorite}
        >
          {isFavorited ? <StarIcon /> : <StarBorderIcon />}
        </IconButton>
      }
    >
      <ListItemText
        primary={story.title}
        secondary={story.text}
      />
    </ListItem>
  )
}