import React from 'react';
import { render, fireEvent, waitFor, screen } from '@testing-library/react';
import StarredStories from '../StarredStories';
import api from '../../services/api';

jest.mock('../../services/api');

describe('StarredStories Component', () => {
  const mockGroupedStories = {
    current_user_email: 'user@example.com',
    stories: [
      { 
        id: 101, 
        title: 'Test Story 1', 
        url: 'http://example.com/1',
        user_emails: ['user@example.com', 'other@example.com'],
        current_user_starred: true
      },
      { 
        id: 102, 
        title: 'Test Story 2', 
        url: 'http://example.com/2',
        user_emails: ['other@example.com'],
        current_user_starred: false
      },
    ]
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  test('renders loading state', async () => {
    api.get.mockReturnValue(new Promise(() => {}));
    render(<StarredStories />);
    expect(screen.getByText('Loading...')).toBeInTheDocument();
  });

  test('renders starred stories', async () => {
    api.get.mockResolvedValueOnce({ data: mockGroupedStories });

    render(<StarredStories />);

    await waitFor(() => {
      expect(screen.getByText('All Starred Stories')).toBeInTheDocument();
      expect(screen.getByText('Test Story 1')).toBeInTheDocument();
      expect(screen.getByText('Test Story 2')).toBeInTheDocument();
      expect(screen.getByText('Starred by: user@example.com, other@example.com')).toBeInTheDocument();
      expect(screen.getByText('Starred by: other@example.com')).toBeInTheDocument();
      expect(screen.getByText('Unstar')).toBeInTheDocument();
      expect(screen.queryAllByText('Unstar')).toHaveLength(1);
    });
  });

  test('handles unstarring a story', async () => {
    api.get.mockResolvedValueOnce({ data: mockGroupedStories });
    api.delete.mockResolvedValueOnce({});

    render(<StarredStories />);

    await waitFor(() => {
      expect(screen.getByText('Test Story 1')).toBeInTheDocument();
    });

    fireEvent.click(screen.getByText('Unstar'));

    await waitFor(() => {
      expect(api.delete).toHaveBeenCalledWith('/user_stories/101');
      const starredByTexts = screen.queryAllByText('Starred by: other@example.com');
      expect(starredByTexts).toHaveLength(2);
      expect(screen.queryByText('Starred by: user@example.com, other@example.com')).not.toBeInTheDocument();
      expect(screen.queryByText('Unstar')).not.toBeInTheDocument();
    });
  });
  
  test('renders empty state when no starred stories', async () => {
    api.get.mockResolvedValueOnce({ data: { current_user_email: 'user@example.com', stories: [] } });

    render(<StarredStories />);

    await waitFor(() => {
      expect(screen.getByText('No stories have been starred yet.')).toBeInTheDocument();
    });
  });

  test('handles fetch error', async () => {
    api.get.mockRejectedValueOnce(new Error('Failed to fetch'));

    render(<StarredStories />);

    await waitFor(() => {
      expect(screen.getByText('Failed to fetch stories. Please try again.')).toBeInTheDocument();
    });
  });

  test('unstar removes story when it\'s the last user', async () => {
    const singleUserStory = {
      current_user_email: 'user@example.com',
      stories: [
        { 
          id: 103, 
          title: 'Test Story 3', 
          url: 'http://example.com/3',
          user_emails: ['user@example.com'],
          current_user_starred: true
        }
      ]
    };

    api.get.mockResolvedValueOnce({ data: singleUserStory });
    api.delete.mockResolvedValueOnce({});

    render(<StarredStories />);

    await waitFor(() => {
      expect(screen.getByText('Test Story 3')).toBeInTheDocument();
    });

    fireEvent.click(screen.getByText('Unstar'));

    await waitFor(() => {
      expect(api.delete).toHaveBeenCalledWith('/user_stories/103');
      expect(screen.queryByText('Test Story 3')).not.toBeInTheDocument();
      expect(screen.getByText('No stories have been starred yet.')).toBeInTheDocument();
    });
  });
});