const BASE_URL = 'https://hacker-news.firebaseio.com/v0';

export const fetchStory = async (id) => {
  try {
    const response = await fetch(`${BASE_URL}/item/${id}.json`);
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    return await response.json();
  } catch (error) {
    console.error('Error fetching story:', error);
    return null;
  }
};

export const fetchTopStories = async (limit = 30) => {
  try {
    const response = await fetch(`${BASE_URL}/topstories.json`);
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    const ids = await response.json();
    const stories = await Promise.all(ids.slice(0, limit).map(fetchStory));
    return stories.filter(Boolean); // Remove any null stories
  } catch (error) {
    console.error('Error fetching top stories:', error);
    return [];
  }
};