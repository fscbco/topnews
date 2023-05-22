#!/bin/bash
docker build . -t topnews
docker run -it -p 8888:8888 topnews
