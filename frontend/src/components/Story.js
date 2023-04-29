import React from 'react';

function Story(props) {
    return (
        <div className="story-card">
            {/* Make title bigger */}
            <div className="story-title">{props.story.title}</div>
            {/* make url clickable */}
            <div className="story-url">{props.story.url}</div>
        </div>
    )
}

export default Story