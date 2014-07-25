# Beekeeper

## Tools

I’ve taken some time to evaluate the various choices and arrived at the following tooling:

- [Ember.js][ember] as single-page MVC-framework
- [ember-cli][cli] as work environment
- [Bootstrap][bs] as CSSbase

I’ve looked into [Emberscript][emberscr], but it sadly doesn’t yet integrate with ember-cli very well (/at all?).

## Setup

1. Clone the repo
2. `git checkout beekeeper`
3. Install ember-cli & dependencies (see below)
4. Install project dependencies
5. Run `ember server` & visit [http://localhost:4200]()

### ember-cli Installation

npm packets:

    ember-cli
    bower
    phantomjs

System wide or local:

- System wide via `sudo npm install -g` (do I want this?!)
- Locally with `npm install`
  1. Add a user folder to your PATH, e.g. `~/bin`
  2. Syslink every executable manually. Example:

      <code>cd ~/bin
      ln -s ~/node_modules/ember-cli/bin/ember</code>

### Bootstrap &al.

Install the projects dependencies (that’s what bower is for): IN `<beehive_dir>/beekeeper` execute:

    bower install

They are thrown inside the `vendor/` folder and NOT checked into git.


## Jerking around

If you want to learn ember, use the excellent [Guide](ember).

The project structure is described at the [ember-cli homepage][cli]. It changes lots about how you write ember, too, since it integrates an EcmaScript 6 transpiler. Read it.


## Beehive config route endpoints

Ember needs unique object IDs for its persistence backend.

One wants to model the beehive config REST endpoints in a way [DS.RESTAdapter][restadapter] can parse it. That includes said object ID, think relational database tables.


## Next steps

1. Create a REST config API in beehive and connect it to embers store & model via [DS.RESTAdapter][restadapter]
2. Let the user see available configurated bees & create new ones
3. Let the user see routes and create new ones in style of ifttt.
4. Somehow integrate filters in the process (new filter system?)
5. Export the changes to beehive and let beehive test if they are valid.

[ember]: http://emberjs.com
[cli]: http://www.ember-cli.com/
[bs]: http://getbootstrap.com/
[restadapter]: http://emberjs.com/api/data/classes/DS.RESTAdapter.html
[emberscr]: http://emberscript.com/