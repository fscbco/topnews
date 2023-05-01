import React from 'react';

function Story(props) {

    const handleStar = () => {
        props.starStory(props.story.id)
    }

    const starredBy = () => {
        let starredBy = []
        props.story.starred_by.map(user => starredBy.push(user))
        return starredBy
    }

    const starredByNames = () => {
        let names = []
        let starredbyUsers = starredBy()
        starredbyUsers.map(user => names.push(user.first_name))
        let uniqueNames = [...new Set(names)]
        return uniqueNames
    }

    const isCurrentUserStarred = () => {
        if (props.story.starred) {
            let starredbyUsers = starredBy()
            let starredByMe = starredbyUsers.find((user) => {
                return user.id === props.currentUser.id
            }) 
            return starredByMe
        }
        return false
    }

    const userNames = starredByNames()
    const starredByCurrentUser = isCurrentUserStarred()

    return (
        <div className="story-card">
            <div>
                <p className="story-title">{props.story.title}</p>
                <div><a href={props.story.url}>{props.story.url}</a></div>
            </div>
            <div>
                {!starredByCurrentUser ? 
                    <img src="https://img.icons8.com/ios/50/null/star--v1.png" width={44} height={44} onClick={(e) => handleStar(e)}/> :
                    <div className='star-section'>
                        <img src="https://img.icons8.com/fluency/48/null/star.png" onClick={(e) => handleStar(e)}/>
                        <p>Starred by: {userNames}</p>
                    </div>
                }
            </div>
        </div>
    )
}

export default Story