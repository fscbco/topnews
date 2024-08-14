import React from 'react';
import { render, fireEvent, waitFor, screen } from '@testing-library/react';
import Login from '../Login';
import api from '../../services/api';

jest.mock('../../services/api');

describe('Login Component', () => {
  const mockSetToken = jest.fn();

  beforeEach(() => {
    jest.clearAllMocks();
  });

  test('renders login form', () => {
    render(<Login setToken={mockSetToken} />);
    expect(screen.getByPlaceholderText('Email')).toBeInTheDocument();
    expect(screen.getByPlaceholderText('Password')).toBeInTheDocument();
    expect(screen.getByRole('button', { name: 'Login' })).toBeInTheDocument();
  });

  test('submits form with email and password', async () => {
    api.post.mockResolvedValueOnce({ data: { token: 'fake-token' } });

    render(<Login setToken={mockSetToken} />);

    fireEvent.change(screen.getByPlaceholderText('Email'), { target: { value: 'test@example.com' } });
    fireEvent.change(screen.getByPlaceholderText('Password'), { target: { value: 'password123' } });
    fireEvent.click(screen.getByRole('button', { name: 'Login' }));

    await waitFor(() => {
      expect(api.post).toHaveBeenCalledWith('/auth/login', { email: 'test@example.com', password: 'password123' });
      expect(mockSetToken).toHaveBeenCalledWith('fake-token');
      expect(localStorage.getItem('token')).toBe('fake-token');
    });
  });

  test('displays error message on login failure', async () => {
    api.post.mockRejectedValueOnce({ response: { data: { error: 'Invalid credentials' } } });

    render(<Login setToken={mockSetToken} />);

    fireEvent.change(screen.getByPlaceholderText('Email'), { target: { value: 'test@example.com' } });
    fireEvent.change(screen.getByPlaceholderText('Password'), { target: { value: 'wrongpassword' } });
    fireEvent.click(screen.getByRole('button', { name: 'Login' }));

    await waitFor(() => {
      expect(screen.getByText('Invalid credentials')).toBeInTheDocument();
    });
  });
});