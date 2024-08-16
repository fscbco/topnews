import React from 'react';
import api from '../services/api';

const Story = ({ story, onStar }) => {
  const handleStar = async () => {
    try {
      await api.post('/user_stories', {
        story_id: story.id,
        title: story.title,
        url: story.url
      });
      if (onStar) onStar(story.id);
    } catch (error) {
      console.error('Error starring story:', error);
    }
  };

  return (
    <div>
      <h2>{story.title}</h2>
      <a href={story.url} target="_blank" rel="noopener noreferrer">Read more</a>
      <button onClick={handleStar}>Star</button>
    </div>
  );
};

export default Story;