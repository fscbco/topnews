import React from 'react';
import Story from './Story'

function HomePage(props) {

    return (
        <div className="stories-block"> 
            <ul>
                {
                    props.stories.map(story => {
                        return <Story key={story.id} story={story}/>
                    })
                }
            </ul>
        </div>

    )
}

export default HomePage