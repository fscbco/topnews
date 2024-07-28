import React, { useState } from "react";
import {
  ListItem,
  ListItemText,
} from '@mui/material';

export default StoriesListItem = ({ story }) => {
  return (
    <ListItem>
      <ListItemText
        primary={`${story.favorites_count} - ${story.title}`}
        secondary={story.text}
      />
    </ListItem>
  )
}