import { useEffect, useState } from "react"
import Story from "./Story";

function HomePage() {

    const [stories, setStories] = useState([]);

    useEffect(() => {
      fetchStoriesJSON()
    }, []) 


     const fetchStoriesJSON = async () => {
        const response = await fetch('http://localhost:3000/stories/')

        if (!response.ok) {
            const message = `An error has occured: ${response.status}`;
            throw new Error(message);
        }

        const stories = await response.json()
        setStories(stories)
      }
    
    return (
        <div className="stories-block"> 
                    <ul>
                        {
                            stories.map(story => {
                                return <Story key={story.id} story={story}/>
                            })
                        }
                    </ul>
            </div>

    )
}

export default HomePage