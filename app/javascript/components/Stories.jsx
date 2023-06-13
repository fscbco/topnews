import React, { useState, useEffect } from "react";
import {
  List,
  ListItem,
  ListItemText,
  Paper,
  Tabs,
  Tab,
} from "@material-ui/core";
import Pagination from "@mui/material/Pagination";
import Story from "./Story";

import axios from "axios";

const Stories = ({ user, setOpenLogin }) => {
  const [stories, setStories] = useState([]);
  const [order, setOrder] = useState("top");
  const [page, setPage] = useState(1);
  const [rowsPerPage, setRowsPerPage] = useState(25);

  const fetchStories = () => {
    path = order === "liked" ? "/likes" : "/stories?sort=" + order;
    axios
      .get(path)
      .then((response) => {
        setStories(response.data);
      })
      .catch((error) => console.log(error));
  };

  useEffect(() => {
    fetchStories();
  }, [order]);

  const isLiked = (story) => user !== null && user.id in story.liked_by;

  const onLikeCallback = (id) => (response_data) => {
    new_stories = stories.map((story) =>
      story.id === id ? Object.assign(story, response_data) : story
    );
    if (order === "liked") {
      new_stories = new_stories.filter(
        (story) => Object.keys(story.liked_by).length > 0
      );
    }
    setStories(new_stories);
  };

  const handleChangeOrder = (event, newValue) => {
    setOrder(newValue);
    setPage(1);
  };

  const handleChangePage = (event, newPage) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(parseInt(event.target.value, 10));
    setPage(1);
  };

  const emptyRows =
    rowsPerPage -
    Math.min(rowsPerPage, stories.length - (page - 1) * rowsPerPage);

  return (
    <div>
      <Tabs value={order} onChange={handleChangeOrder} centered>
        <Tab label="Top" value="top" />
        <Tab label="New" value="new" />
        <Tab label="Best" value="best" />
        <Tab label="Liked" value="liked" />
      </Tabs>
      <Paper>
        <List>
          {stories
            .slice(
              (page - 1) * rowsPerPage,
              (page - 1) * rowsPerPage + rowsPerPage
            )
            .map((row) => (
              <ListItem key={row.id}>
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
                  setOpenLogin={() => setOpenLogin(true)}
                />
              </ListItem>
            ))}
          {emptyRows > 0 && (
            <ListItem style={{ height: 53 * emptyRows }}>
              <ListItemText primary="" />
            </ListItem>
          )}
        </List>
        <div
          style={{
            display: "flex",
            justifyContent: "space-between",
            alignItems: "center",
            padding: "16px",
          }}
        >
          <Pagination
            count={Math.ceil(stories.length / rowsPerPage)}
            page={page}
            onChange={handleChangePage}
            color="primary"
            shape="rounded"
          />
          <span>
            {`Rows per page: `}
            <select value={rowsPerPage} onChange={handleChangeRowsPerPage}>
              {[25, 50, 100].map((value) => (
                <option key={value} value={value}>
                  {`${value}`}
                </option>
              ))}
            </select>
          </span>
        </div>
      </Paper>
    </div>
  );
};

export default Stories;
