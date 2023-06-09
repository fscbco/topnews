import React, { useEffect, useState } from 'react'
import Story from './Story'
import axios from 'axios'
import { useTheme } from '@mui/material/styles';
import Box from '@mui/material/Box';
import Tabs from '@mui/material/Tabs';
import Tab from '@mui/material/Tab';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableFooter from '@mui/material/TableFooter';
import TablePagination from '@mui/material/TablePagination';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import IconButton from '@mui/material/IconButton';
import FirstPageIcon from '@mui/icons-material/FirstPage';
import KeyboardArrowLeft from '@mui/icons-material/KeyboardArrowLeft';
import KeyboardArrowRight from '@mui/icons-material/KeyboardArrowRight';
import LastPageIcon from '@mui/icons-material/LastPage';


function Stories({ user, setOpenLogin }) {

    const [stories, setStories] = useState([])
    const [order, setOrder] = useState("top")

    const fetchStories = () => {
        path = order === "liked" ? "/likes" : "/stories?sort=" + order
        axios.get(path)
            .then((response) => {
                setStories(response.data)
            })
            .catch((error) => console.log(error))
    }

    useEffect(fetchStories, [order])

    const isLiked = (story) => user !== null && user.id in story.liked_by

    const onLikeCallback = (id) => (response_data) => {
        new_stories = stories.map(
            (story) => story.id === id ? Object.assign(story, response_data) : story
        )
        console.log("RSPD:")
        console.log(response_data)
        if (order === "liked") {
            new_stories = new_stories.filter((story) => Object.keys(story.liked_by).length > 0)
        }
        setStories(new_stories)
    }

    const [page, setPage] = React.useState(0);
    const [rowsPerPage, setRowsPerPage] = React.useState(25);

    // Avoid a layout jump when reaching the last page with empty rows.
    const emptyRows =
        page > 0 ? Math.max(0, (1 + page) * rowsPerPage - rows.length) : 0;

    const handleChangeOrder = (event, newValue) => setOrder(newValue)

    const handleChangePage = (event, newPage) => setPage(newPage)

    const handleChangeRowsPerPage = (event) => {
        setRowsPerPage(parseInt(event.target.value, 10));
        setPage(0);
    };

    return (
        <div>
            <Tabs value={order} onChange={handleChangeOrder} centered>
                <Tab label="Top" value="top" />
                <Tab label="New" value="new" />
                <Tab label="Best" value="best" />
                <Tab label="Liked" value="liked" />
            </Tabs>
            <TableContainer component={Paper}>
                <Table sx={{ minWidth: 500 }} aria-label="stories table">
                    <TableBody>
                        {(rowsPerPage > 0
                            ? stories.slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
                            : stories
                        ).map((row) => (
                            <TableRow key={row.id}>
                                {/* react hates divs in table rows, but it still renders */}
                                <Story
                                    user={user}
                                    id={row.id}
                                    title={row.title}
                                    url={row.url}
                                    score={row.score}
                                    by={row.by}
                                    liked={isLiked(row)}
                                    liked_by={Object.values(row.liked_by)}
                                    likeCallback={onLikeCallback(row.id)}
                                    setOpenLogin={()=>setOpenLogin(true)} />
                            </TableRow>
                        ))}
                        {emptyRows > 0 && (
                            <TableRow style={{ height: 53 * emptyRows }}>
                                <TableCell colSpan={6} />
                            </TableRow>
                        )}
                    </TableBody>
                    <TableFooter>
                        <TableRow>
                            <TablePagination
                                rowsPerPageOptions={[10, 25, 50, { label: 'All', value: -1 }]}
                                colSpan={3}
                                count={stories.length}
                                rowsPerPage={rowsPerPage}
                                page={page}
                                SelectProps={{
                                    inputProps: {
                                        'aria-label': 'rows per page',
                                    },
                                    native: true,
                                }}
                                onPageChange={handleChangePage}
                                onRowsPerPageChange={handleChangeRowsPerPage}
                                ActionsComponent={TablePaginationActions}
                            />
                        </TableRow>
                    </TableFooter>
                </Table>
            </TableContainer>
        </div>
    )
}

function TablePaginationActions(props) {
    const theme = useTheme();
    const { count, page, rowsPerPage, onPageChange } = props;

    const handleFirstPageButtonClick = (event) => {
        onPageChange(event, 0);
    };

    const handleBackButtonClick = (event) => {
        onPageChange(event, page - 1);
    };

    const handleNextButtonClick = (event) => {
        onPageChange(event, page + 1);
    };

    const handleLastPageButtonClick = (event) => {
        onPageChange(event, Math.max(0, Math.ceil(count / rowsPerPage) - 1));
    };

    return (
        <Box sx={{ flexShrink: 0, ml: 2.5 }}>
            <IconButton
                onClick={handleFirstPageButtonClick}
                disabled={page === 0}
                aria-label="first page"
            >
                {theme.direction === 'rtl' ? <LastPageIcon /> : <FirstPageIcon />}
            </IconButton>
            <IconButton
                onClick={handleBackButtonClick}
                disabled={page === 0}
                aria-label="previous page"
            >
                {theme.direction === 'rtl' ? <KeyboardArrowRight /> : <KeyboardArrowLeft />}
            </IconButton>
            <IconButton
                onClick={handleNextButtonClick}
                disabled={page >= Math.ceil(count / rowsPerPage) - 1}
                aria-label="next page"
            >
                {theme.direction === 'rtl' ? <KeyboardArrowLeft /> : <KeyboardArrowRight />}
            </IconButton>
            <IconButton
                onClick={handleLastPageButtonClick}
                disabled={page >= Math.ceil(count / rowsPerPage) - 1}
                aria-label="last page"
            >
                {theme.direction === 'rtl' ? <FirstPageIcon /> : <LastPageIcon />}
            </IconButton>
        </Box>
    );
}

export default Stories