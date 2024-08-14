import React from 'react';
import { render, fireEvent, waitFor, screen } from '@testing-library/react';
import StarredStories from '../StarredStories';
import api from '../../services/api'

jest.mock('../../services/api');

describe('StarredStories Component', () => {
  const mockStarredStories = [
    { id: 1, story: { id: 101, title: 'Test Story 1', hn_id: 1001, url: 'http://example.com/1' } },
    { id: 2, story: { id: 102, title: 'Test Story 2', hn_id: 1002, url: 'http://example.com/2' } },
  ];

  beforeEach(() => {
    jest.clearAllMocks();
  });

  test('renders loading state', async () => {
    api.get.mockReturnValue(new Promise(() => {}));
    render(<StarredStories />);
    expect(screen.getByText('Loading...')).toBeInTheDocument();
  });

  test('renders starred stories', async () => {
    api.get.mockResolvedValueOnce({ data: mockStarredStories });

    render(<StarredStories />);

    await waitFor(() => {
      expect(screen.getByText('Your Starred Stories')).toBeInTheDocument();
      expect(screen.getByText('Test Story 1')).toBeInTheDocument();
      expect(screen.getByText('Test Story 2')).toBeInTheDocument();
    });
  });

  test('handles unstarring a story', async () => {
    api.get.mockResolvedValueOnce({ data: mockStarredStories });
    api.delete.mockResolvedValueOnce({});

    render(<StarredStories />);

    await waitFor(() => {
      expect(screen.getByText('Test Story 1')).toBeInTheDocument();
    });

    fireEvent.click(screen.getAllByText('Unstar')[0]);

    await waitFor(() => {
      expect(api.delete).toHaveBeenCalledWith('/user_stories/1');
      expect(screen.queryByText('Test Story 1')).not.toBeInTheDocument();
      expect(screen.getByText('Test Story 2')).toBeInTheDocument();
    });
  });

  test('renders empty state when no starred stories', async () => {
    api.get.mockResolvedValueOnce({ data: [] });

    render(<StarredStories />);

    await waitFor(() => {
      expect(screen.getByText('You haven\'t starred any stories yet.')).toBeInTheDocument();
    });
  });

  test('handles fetch error', async () => {
    api.get.mockRejectedValueOnce(new Error('Failed to fetch'));

    render(<StarredStories />);

    await waitFor(() => {
      expect(screen.getByText('Failed to fetch starred stories. Please try again.')).toBeInTheDocument();
    });
  });
});