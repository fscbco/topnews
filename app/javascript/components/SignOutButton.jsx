import React from 'react';

export default SignOutButton = () => {
  return (
    <form action="/users/sign_out" method="post">
      <input type="hidden" name="_method" value="delete" />
      <input type="hidden" name="authenticity_token" value={document.querySelector('meta[name="csrf-token"]').getAttribute('content')} />
      <button type="submit">Sign Out</button>
    </form>
  )
}