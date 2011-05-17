# Jellyfish

## Description

Jellyfish is a quick-and-dirty hack to push a [GitHub post-receive
webhook](http://help.github.com/post-receive-hooks/) through to a set
of [Opscode Chef](http://opscode.com/chef/) nodes causing them to
converge.

## Design

GitHub -(webhook) ->
  jellyfish-server -(websocket)->
    jellyfish-clients -> chef-client

1. POSTing to http://jlyfsh.com/deploy generates a unique URI
2. On hosts deploying your code install the jellyfish daemon
3. Configure jellyfish.yml and start jellyfish-client.py so it has a
   persistent WebSockets connection to your unique URI
4. GET or POST to http://jlyfsh.com/deploy/{id} to signal a deploy

## Installation

1. Generate a new identifier: `curl --data '' http://jlyfsh.com/deploy`
2. Point your webhook at http://jlyfsh.com/deploy/{id}
3. Install/configure the [Jellyfish cookbook](http://community.opscode.com/cookbooks/)
4. Push to Converge!

## To Do

* Learn how to package, install and demonize Erlang and Python
  programs using native techniques

## Caveat emptor

Please don't expect any of this to work well. This is practically the
first Erlang program I've ever written. I'm certain it lacks good
style, design and is just wrong. I'd love to hear critical feedback to
become a better Erlang hacker. Pull requests welcome!

I'll run this code as a community service at http://jlyfsh.com. I'm
using it for my own projects so I may make a reasonable effort to keep
it healthy, but absolutely no promises. It may go down for days,
randomly destroy your data or vanish forever without notice.

Sincerely,

Darrin
