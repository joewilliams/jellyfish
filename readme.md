# Jellyfish

## Description

Jellyfish is a quick-and-dirty hack to wire up a [Github post-receive
webhook](http://help.github.com/post-receive-hooks/) to an [Opscode
Chef](http://opscode.com/chef/) node convergence.

## Design

Github (webhook) -> ellyfish (server) -(websocket)-> jellyfish-client -> chef-client

1. GETing http://jlyfsh.com/new generates a unique URI
2. Install the jellyfish daemon on the host to which you're deploying
3. Configure jellyfish.yml and start jellyfish.py so it has a
persistant WebSockets connection to your unique URI
4. POST or GET to http://jlyfsh.com/deploy/{id} to deploy
