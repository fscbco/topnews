import React, { useState, useEffect } from 'react';
import api from '../services/api';

const StarredStories = () => {
  const [starredStories, setStarredStories] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchStarredStories();
  }, []);

  const fetchStarredStories = async () => {
    try {
      setIsLoading(true);
      const response = await api.get('/user_stories');
      setStarredStories(response.data);
    } catch (error) {
      console.error('Error fetching starred stories:', error);
      setError('Failed to fetch starred stories. Please try again.');
    } finally {
      setIsLoading(false);
    }
  };

  const handleUnstar = async (userStoryId) => {
    try {
      await api.delete(`/user_stories/${userStoryId}`);
      setStarredStories(prevStories => prevStories.filter(story => story.id !== userStoryId));
    } catch (error) {
      console.error('Error unstarring story:', error);
    }
  };

  if (isLoading) return <div>Loading...</div>;
  if (error) return <div>{error}</div>;

  return (
    <div>
      <h1>Your Starred Stories</h1>
      {starredStories.length === 0 ? (
        <p>You haven't starred any stories yet.</p>
      ) : (
        starredStories.map(userStory => (
          <div key={userStory.id}>
            <h2>{userStory.story.title}</h2>
            <a href={userStory.story.url} target="_blank" rel="noopener noreferrer">Read more</a>
            <button onClick={() => handleUnstar(userStory.id)}>Unstar</button>
          </div>
        ))
      )}
    </div>
  );
};

export default StarredStories;