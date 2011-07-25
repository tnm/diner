diner
=====

**counting and ranking service with redis in ruby**

overview
--------

diner provides a simple API to a specific subset of Redis actions, namely:

* incrementing a sorted set's element
* returning the cardinality of a sorted set
* returning the rank of a sorted set's element
* returning the score of a sorted set's element

With these actions, diner can be used to support a **counter and ranking service over HTTP**. 
diner speaks JSON, but it'd be trivial to add XML support.

diner is built on Sinatra, so it can be started locally with Sinatra on localhost and port 4567. 
diner's tests run against a local running instance of Redis; the tests will create a few test keys.

api
-----

All interaction with diner occurs at the key resource level, accessed via either GET or POST at `/:key`.
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

Copyright (c) 2011, Ted Nyman
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the <organization> nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

