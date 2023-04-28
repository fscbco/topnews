function Story(props) {

    console.log(props)
    
    return (
        <div className="story-card">
            <div className="story-title">{props.story.title}</div>
            <div className="story-url">{props.story.url}</div>
        </div>
    )
}

export default Story