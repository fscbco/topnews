import React, { useState } from 'react';
import Grid from '@mui/material/Unstable_Grid2';
import SignOutButton from './SignOutButton';
import StoriesList from './StoriesList';
import FavoritedStoriesList from './FavoritedStoriesList';

export default App = () => {
  const [lastFavoriteUpdate, setLastFavoriteUpdate] = useState(new Date());

  const onToggleFavorite = () => {
    setLastFavoriteUpdate(new Date());
  }

  return (
    <div>
      <div>
        <SignOutButton />
      </div>
      <h1>Welcome to TopNews</h1>
      <Grid container spacing={2}>
        <Grid xs={12} sm={6}>
          <h2>Top Stories</h2>
          <StoriesList onToggleFavorite={onToggleFavorite} />
        </Grid>
        <Grid xs={12} sm={6}>
          <h2>Favorited Stories</h2>
          <FavoritedStoriesList lastFavoriteUpdate={lastFavoriteUpdate} />
        </Grid>
      </Grid>
    </div>
  );
}