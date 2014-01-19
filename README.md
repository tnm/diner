diner
=====

**counting and ranking service with redis in ruby**

overview
--------

diner provides a simple example HTTP API to a specific subset of Redis actions, namely:

* incrementing a sorted set's element
* returning the cardinality of a sorted set
* returning the rank of a sorted set's element
* returning the score of a sorted set's element

diner is built on Sinatra, so it can be started locally with Sinatra on localhost and port 4567. 
diner's tests run against a local running instance of Redis; the tests will create a few test keys.

api
-----

diner is accessed via either GET or POST at `/:key`.
All the keys that Diner generates will be prepended with `diner:` for namespacing; however, interaction with the 
keys happens directly on the specified name (e.g., you interface with 'foo', not 'diner:foo').

Using the key `foo` as an example:

**Increment an element**

    POST /foo

with parameters: `command=increment, element=bigelement, score=20.0`

**Get the cardinality of a sorted set**

    GET /foo?command=card'

**Get the rank of an element of a sorted set**

    GET /foo?command=rank&element=bar

**Get the score of an element of a sorted set**
    
    GET /foo?command=score&element=bar

clients
--------

You can check out a Python client at: [https://github.com/tnm/pydiner](https://github.com/tnm/pydiner).

license
--------

BSD License
