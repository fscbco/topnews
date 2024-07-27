import React from 'react';
import Grid from '@mui/material/Unstable_Grid2';
import StoriesList from './StoriesList';

export default App = () => {
  return (
    <div>
      <h1>Welcome to TopNews</h1>
      <Grid container spacing={2}>
        <Grid xs={12} sm={6}>
          <h2>Top Stories</h2>
          <StoriesList />
        </Grid>
      </Grid>
    </div>
  );
}