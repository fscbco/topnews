import React, { useState, useEffect } from "react";

export default StoriesList = () => {
  const [stories, setStories] = useState([]);

  useEffect(() => {
    fetch("/api/stories")
      .then((response) => response.json())
      .then((data) => setStories(data));
  }, []);

  return (
    <div>
      <h2>Stories List</h2>
      {stories.map((story) => (
        <div key={story.id}>
          <a href={story.url}><h3>{story.title}</h3></a>
          <p>By: {story.by}</p>
          <p>{story.text}</p>
        </div>
      ))}
    </div>
  );
}