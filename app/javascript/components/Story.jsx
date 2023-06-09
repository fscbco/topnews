import React from 'react'
import axios from 'axios'
import StarBorderIcon from '@mui/icons-material/StarBorder';
import StarIcon from '@mui/icons-material/Star';
import Grid from '@mui/material/Unstable_Grid2';
import Box from '@mui/material/Box';


function Story({ user, id, title, url, score, liked, liked_by = [], likeCallback, setOpenLogin }) {

    const onLike = () => {
        const url = `/stories/${id}/${liked ? 'unlike' : 'like'}`
        axios.put(url, {}, {
            headers: {
                Authorization: `Bearer ${user.token}`
            }
        }).then((response) => {
            likeCallback(response.data)
        }).catch((error) => {
            console.log(error)
        })
    }

    checked_url = url || `https://news.ycombinator.com/item?id=${id}`

    const truncate = (str, n) => {
        return (str.length > n) ? str.substr(0, n - 1) + '...' : str;
    };

    return (
        <Grid container spacing={2}>
            <Grid xs={1}>
                <Box>
                    {liked ? <StarIcon onClick={onLike} /> : <StarBorderIcon onClick={user !== null ? onLike : setOpenLogin} />}
                </Box>
            </Grid>
            <Grid xs={1}>
                <Box><h2>{score}</h2></Box>
                points
            </Grid>

            <Grid xs={7}>
                <Box>
                    <strong>
                        <a href={checked_url}>{truncate(title, 60)}</a>
                    </strong>
                    <br />
                    {liked_by.length > 0 && "liked by "+truncate(liked_by.join(', '), 50)}
                </Box>
            </Grid>
            <Grid xs={3}>
                <Box>({truncate(checked_url, 22)})</Box>
            </Grid>
        </Grid>
    )
}

export default Story