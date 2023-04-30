import React, { useState } from 'react';

function Story(props) {

    const [starred, setStarred] = useState(false)

    const handleStar = () => {
        // placeholder method
        setStarred(!starred)
    }

    return (
        <div className="story-card">
            <div>
                <p className="story-title">{props.story.title}</p>
                <div><a href={props.story.url}>{props.story.url}</a></div>
            </div>
            <div>
                {starred ? 
                    <img src="https://img.icons8.com/fluency/48/null/star.png" onClick={(e) => handleStar(e)}/> :
                    <img src="https://img.icons8.com/ios/50/null/star--v1.png" width={44} height={44} onClick={(e) => handleStar(e)}/>
                }
            </div>
        </div>
    )
}

export default Story