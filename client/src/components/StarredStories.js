import React, { useState, useEffect } from 'react';
import api from '../services/api';

const StarredStories = () => {
  const [groupedStories, setGroupedStories] = useState([]);
  const [currentUserEmail, setCurrentUserEmail] = useState('');
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchGroupedStories();
  }, []);

  const fetchGroupedStories = async () => {
    try {
      setIsLoading(true);
      const response = await api.get('/user_stories');
      setGroupedStories(response.data.stories);
      setCurrentUserEmail(response.data.current_user_email);
    } catch (error) {
      console.error('Error fetching grouped stories:', error);
      setError('Failed to fetch stories. Please try again.');
    } finally {
      setIsLoading(false);
    }
  };

  const handleUnstar = async (storyId) => {
    try {
      await api.delete(`/user_stories/${storyId}`);
      setGroupedStories(prevStories =>
        prevStories.reduce((acc, story) => {
          if (story.id === storyId) {
            const updatedEmails = story.user_emails.filter(email => email !== currentUserEmail);
            if (updatedEmails.length > 0) {
              acc.push({
                ...story,
                user_emails: updatedEmails,
                current_user_starred: false
              });
            }
          } else {
            acc.push(story);
          }
          return acc;
        }, [])
      );
    } catch (error) {
      console.error('Error unstarring story:', error);
    }
  };

  if (isLoading) return <div>Loading...</div>;
  if (error) return <div>{error}</div>;

  return (
    <div>
      <h1>All Starred Stories</h1>
      {groupedStories.length === 0 ? (
        <p>No stories have been starred yet.</p>
      ) : (
        groupedStories.map(story => (
          <div key={story.id}>
            <h2>{story.title}</h2>
            <a href={story.url} target="_blank" rel="noopener noreferrer">Read more</a>
            <p>Starred by: {story.user_emails.join(', ')}</p>
            {story.current_user_starred && (
              <button onClick={() => handleUnstar(story.id)}>Unstar</button>
            )}
          </div>
        ))
      )}
    </div>
  );
};

export default StarredStories;