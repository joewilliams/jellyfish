# Jellyfish

## Description

Jellyfish is a quick-and-dirty hack to push a [GitHub post-receive
webhook](http://help.github.com/post-receive-hooks/) through to a set
of [Opscode Chef](http://opscode.com/chef/) nodes causing them to
converge.

## Design

GitHub (webhook) ->
  jellyfish-server -(websocket)->
    jellyfish-clients -> chef-client

1. POSTing to http://jlyfsh.com/deploy generates a unique URI
2. On hosts deploying your code install the jellyfish daemon
3. Configure jellyfish.yml and start jellyfish-client.py so it has a
persistent WebSockets connection to your unique URI
4. GET or POST to http://jlyfsh.com/deploy/{id} to signal a deploy

## Installation

Generate a new identifier: `curl `

## Caveat emptor

Please don't expect any of this to work well. This is practically the
first Erlang program I've ever written. I'm certain it lacks good
style, design and is just wrong. I'd love to hear critical feedback to
become a better Erlang hacker. Please send changes.

I'll run this code as a community service at http://jlyfsh.com. It's
running for my own projects so I may make a reasonable effort to keep
it alive, but absolutely no promises. It may go down for days or
vanish forever without notice. You may want to run your own server if
this is something on which you rely.

Sincerely,
Darrin
