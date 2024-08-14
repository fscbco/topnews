import { useState, useEffect } from 'react';
import { fetchTopStories } from '../services/hackerNewsService';

const useTopStories = (updateInterval = 300000) => {
  const [stories, setStories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchStories = async () => {
      try {
        setLoading(true);
        const newStories = await fetchTopStories();
        setStories(newStories);
        setError(null);
      } catch (err) {
        setError('Failed to fetch stories');
      } finally {
        setLoading(false);
      }
    };

    fetchStories();

    const intervalId = setInterval(fetchStories, updateInterval);

    return () => clearInterval(intervalId);
  }, [updateInterval]);

  return { stories, loading, error };
};

export default useTopStories;