#!/bin/bash

# cleanup any dangling server process ids
rm -f tmp/pids/server.pid

# Ensure database is created, seeded and new stories are pulled when server starts
pattern="rails server"

if [[ "${*}" =~ $pattern ]]; then
  bundle exec rake db:prepare
fi

exec "${@}"