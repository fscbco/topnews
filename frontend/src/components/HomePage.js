import React from 'react';
import Story from './Story'

function HomePage(props) {

    const showStarredStories = () => {
        props.showOnlyStarredStories()
    }

    const showAllStories = () => {
        props.showAllStories()
    }

    const stories = props.starredStoriesMode ? props.starredStories : props.stories

    return (
        <div> 
         { props.currentUser ? 
            <div className='stories-block'>
                <div className='stories-links'>
                    <button className='button-text' onClick={() => showAllStories()}>All Stories</button>
                    <button className='button-text'onClick={() => showStarredStories()}>Only Starred</button>
                </div> 
                <ul>
                    {
                        stories.map(story => {
                            return <Story key={story.id} story={story} starStory={props.starStory} currentUser={props.currentUser}/>
                        })
                    }
                </ul>
            </div> : null }
        </div>

    )
}

export default HomePage