import React, { useState } from 'react';
import useTopStories from '../hooks/useTopStories';
import Story from './Story';

const StoryList = () => {
  const { stories, loading, error } = useTopStories(300000); // Update every 5 minutes
  const [starredStoryIds, setStarredStoryIds] = useState(new Set());

  if (loading) return <div>Loading stories...</div>;
  if (error) return <div>Error: {error}</div>;

  const handleStar = (storyId) => {
    setStarredStoryIds(prev => new Set(prev).add(storyId));
  };

  return (
    <div>
      <h1>Top Hacker News Stories</h1>
      {stories.map(story => (
        <Story 
          key={story.id} 
          story={story} 
          onStar={handleStar}
          isStarred={starredStoryIds.has(story.id)}
        />
      ))}
    </div>
  );
};

export default StoryList;