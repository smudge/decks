# Refactoring with Science

<img src="http://www.gravatar.com/avatar/4b0e809dfd8629466d64c96ea45ac03c" />

#### Nathan Griffith
[github.com/smudge](https://github.com/smudge)

January 10, 2019

???

Okay, so I know you might be thinking...

---

# "Science"

<img src="https://i.imgur.com/M5o4O9P.gif" style="width:100%" />

---

# "Science"

First, some background.

???

In December, we discovered a bug in our balance calculations - a very rare case in the way we calculate vested amounts.

FLIP TO SPREADSHEET. FLIP BACK.

We decided to fix it, but first we needed to refactor the existing code to make it easier to slot in a fix.

Unfortunately, this would impact a highly-trafficked, business-critical codepath.

And automated tests alone might not be sufficient, because we're dealing with a huge variety of customer data.

It's a combinatorially complex problem.

So we decided we needed to be able to safely test this change in production.

That's where "Science" comes in.

Or, more specifically, a controlled experiment.

That we ran in our production environment.

Essentially allowing us to run the new code alongside the old code and make sure it returned the correct results.

---

# How it Works

1. Run new code along side existing code.

???

the code it is meant to replace

---

# How it Works

1. Run new code along side existing code.
2. Compare outputs & track whether or not they match.

???

also track runtime to detect perf regressions

---

# How it Works

1. Run new code along side existing code.
2. Compare outputs & track whether or not they match.
3. Return the output of the existing code.

???

so, effectively, the new code is NOT live

---

# How it Works

1. Run new code along side existing code.
2. Compare outputs & track whether or not they match.
3. Return the output of the existing code.
4. ...

---

# How it Works

1. Run new code along side existing code.
2. Compare outputs & track whether or not they match.
3. Return the output of the existing code.
4. ...
5. Promote the new code and delete the existing code.

???

awesome! so... how do we do that?

---


# `scientist`

<img src="https://i.imgur.com/vVeiTWQ.png" style="width:100%" />

???

Github made a Ruby library that does exactly this

---

# `scientist`

- [github/scientist](https://github.com/github/scientist) (Ruby)
- [daylerees/scientist](https://github.com/daylerees/scientist) (PHP)
- [github/scientist.net](https://github.com/github/scientist.net) (.NET)
- [joealcorn/laboratory](https://github.com/joealcorn/laboratory) (Python)
- [rawls238/Scientist4J](https://github.com/rawls238/Scientist4J) (Java)
- [tomiaijo/scientist](https://github.com/tomiaijo/scientist) (C++)
- [trello/scientist](https://github.com/trello/scientist) (node.js)
- [ziyasal/scientist.js](https://github.com/ziyasal/scientist.js) (node.js, ES6)
- [yeller/laboratory](https://github.com/yeller/laboratory) (Clojure)
- [lancew/Scientist](https://github.com/lancew/Scientist) (Perl 5)
- [lancew/ScientistP6](https://github.com/lancew/ScientistP6) (Perl 6)
- [MadcapJake/Test-Lab](https://github.com/MadcapJake/Test-Lab) (Perl 6)
- [cwbriones/scientist](https://github.com/cwbriones/scientist) (Elixir)
- [calavera/go-scientist](https://github.com/calavera/go-scientist) (Go)
- [jelmersnoeck/experiment](https://github.com/jelmersnoeck/experiment) (Go)
- [spoptchev/scientist](https://github.com/spoptchev/scientist) (Kotlin / Java)
- [junkpiano/scientist](https://github.com/junkpiano/scientist) (Swift)

???

it has been ported to a zillion languages

---

# `scientist`

But it doesn't do everything.

???

like reporting! actually seeing the results is kind important.

---

# Anatomy of a Code Experiment

```ruby
  Scientist.run 'my-experiment' do |e|
    e.use { current_implementation(user) }
    e.try { experimental_implementaiton(bar) }
  end
```

---

# Anatomy of a Code Experiment

```ruby
  Scientist.run 'my-experiment' do |e|
    e.use { current_implementation(user) }
    e.try { experimental_implementaiton(bar) }

    e.context(user_id: user.id, foo: 'bar')
  end
```

---

# Anatomy of a Code Experiment

```ruby
  Scientist.run 'my-experiment' do |e|
    e.use { current_implementation(user) }
    e.try { experimental_implementaiton(bar) }
    e.context(user_id: user.id, foo: 'bar')

    e.run_if { rand(100) < ENV['MY_EXPERIMENT_ROLLOUT'] } # X% of the time
  end
```

---

# Anatomy of a Code Experiment

```ruby
  Scientist.run 'my-experiment' do |e|
    e.use { current_implementation(user) }
    e.try { experimental_implementaiton(bar) }
    e.context(user_id: user.id, foo: 'bar')
    e.run_if { rand(100) < ENV['MY_EXPERIMENT_ROLLOUT'] }

    e.compare { |control, experiment| (control - experiment).abs < 0.1 }
  end
```

---

# Anatomy of a Code Experiment

```ruby
  Scientist.run 'my-experiment' do |e|
    e.use { current_implementation(user) }
    e.try { experimental_implementaiton(bar) }
    e.context(user_id: user.id, foo: 'bar')
    e.run_if { rand(100) < ENV['MY_EXPERIMENT_ROLLOUT'] }
    e.compare { |control, experiment| (control - experiment).abs < 0.1 }

    e.ignore { |control, experiment| known_edge_case?(control, experiment) }
  en
```

---

# GitHub's reporting solution

???

there is none. you have to build it yourself.

---

# Our reporting solution

```ruby
results = {
  name: experiment_name,
  status: status,
  context: experiment.context,
  # etc...
}.to_json.to_s

Rails.logger.info("[science-experiment] #{results}")
```

???

More or less, log out a JSON blob.

---

# Our reporting solution

```ruby
results = {
  name: experiment_name,
  status: status,
  context: experiment.context,
  # etc...
}.to_json.to_s

Rails.logger.info("[science-experiment] #{results}")
```

Compatible with:

- Splunk
- DataDog
- Humans

???

but let's look at an actual log entry in DataDog

---

# Other Opinionated Defaults

(Where we diverge from GitHub's implementation.)

???

FLIP TO CUSTOM EXPERIMENT CODE (if time)

---

# Other Opinionated Defaults

(Where we diverge from GitHub's implementation.)

- Only run in delayed jobs by default.

???

Largely for performance reasons. Cuts risk of timing-out web requests, limit customer impact.

---

# Other Opinionated Defaults

(Where we diverge from GitHub's implementation.)

- Only run in delayed jobs by default.
- Run 100% of the time locally and in CI.

???

There is no reason not to, since we aren't worried about performance.

---

# Other Opinionated Defaults

(Where we diverge from GitHub's implementation.)

- Only run in delayed jobs by default.
- Run 100% of the time locally and in CI.
- Raise locally if there are any mismatches.

???

Early implementation feedback! Don't wait until after a deploy to find obvious discrepancies!

Guarantees that production mismatches are for cases not covered by tests.

In fact, while I was refactoring our vesting math, I discovered a bug in the existing code!

---

# So how did it go?

<img src="https://i.imgur.com/YzJF7sb.png" style="width:100%" />

???

timeline:

Got it green and discovered a bug in the control code.

Ran the experiment for a while, investigated failures.

Fixed a bug in the experiment.

Mismatches are now zero!

Also note the performance improvements (on average, at least)!

---

# I need your help making it:

???


This is a new idea, so we need to reduce friction and discover/prevent any footguns.
The best way to do that is to battle-test our implementation.

---

# I need your help making it:

- Easy to drop new experiments into existing code.

???

works in many situations, and we want to know when to add it.

---

# I need your help making it:

- Easy to drop new experiments into existing code.
- Hard to get wrong.

???

protects us from common pitfalls, particularly around side-effects.

(INSERT, DELETE, POST, PUT, etc)

---

# Thanks!

#### Scientist-related resources

https://github.com/github/scientist (Ruby source)  
https://githubengineering.com/scientist/ (Introduction blog post)  
https://githubengineering.com/move-fast/ (Real-world case study)

#### Talks on testing in production

Testing in Production - Quality Software Faster (Michael Bryzek)  
https://www.youtube.com/watch?v=9C0efJkT0Hg

The Doctor Is In: Using checkups to find bugs in production (Ryan Laughlin)  
https://www.youtube.com/watch?v=gEAlhKaK2I4
