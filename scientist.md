# Refactoring with Science

#### Nathan Griffith (aka "smudge")

January 10, 2019

---

# "Science"

science.gif

<!--
In the fall of 2018, the B4B team discovered a rare edge case in our participant vesting logic. To fix it, we would need to refactor some existing code in a nontrivial way.

Unfortunately, this would impact a highly-trafficked, business-critical codepath, and could adversely affect a wide array of balance calculations. We decided that relying on automated tests alone might not be sufficient given the risks involved, so we decided we needed to be able to safely test this change in production.

That's where "Science" comes in.
Or, more specifically, a controlled experiment that we ran in our production environment.
-->

---

# Why?

- Reduce the risk of refactoring our code
- Speed up development

<!--
be confident in the stability of a major changes, before we ship the change

sidebar: you might ask, right, so why not just write a bunch of tests
and you wouldn't be wrong. our test suite is an obvious line of defense...
...but it doesn't have to be the only line of defense.

This is for when tests aren't enough.

Maybe you're dealing with a lot of legacy customer data.
Or maybe it's a combinatorially complex problem that can't be reduced any further.
Or maybe you just need to make some big changes and aren't confident that you can cover all of your assumptions.

Think about the times you'd add a regression test -- where you discover an issue in production, fix it, and add a test to make sure it doesn't come up again.
...and then you have to deal with the fallout.
What if you could detect those cases -- in production -- but before the code is _actually_ live?
-->

<!--
by reducing the risk of making major changes, we can...
...make those major changes that allow us to deliver quality software faster
...and be more confident that decisions we make today can be adjusted in the future.
-->

---

# How?

1. Run new code along side existing code. <!-- the code it is meant to replace -->

---

# How?

1. Run new code along side existing code. <!-- the code it is meant to replace -->
2. Compare outputs & track whether or not they match. <!-- also track runtime to detect perf regressions -->

---

# How?

1. Run new code along side existing code. <!-- the code it is meant to replace -->
2. Compare outputs & track whether or not they match. <!-- also track runtime to detect perf regressions -->
3. Return the output of the existing code. <!-- so, effectively, the new code is NOT live -->

---

# How?

1. Run new code along side existing code. <!-- the code it is meant to replace -->
2. Compare outputs & track whether or not they match. <!-- also track runtime to detect perf regressions -->
3. Return the output of the existing code. <!-- so, effectively, the new code is NOT live -->
4. ...

---

# How?

1. Run new code along side existing code. <!-- the code it is meant to replace -->
2. Compare outputs & track whether or not they match. <!-- also track runtime to detect perf regressions -->
3. Return the output of the existing code. <!-- so, effectively, the new code is NOT live -->
4. ...
5. Promote the new code and delete the existing code.

---

# `scientist`

GitHub made a Ruby gem to do exactly this.

---

# `scientist`

It has been ported to many, many languages, including Java.

---

# `scientist`

But it doesn't do everything. <!-- like reporting -->

---

# Anatomy of a Code Experiment

```java
  Experiment<Integer> e = new Experiment("foo");
  e.run(this::controlFunction, this::candidateFunction);
```

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

# Our reporting solution

<!-- In essence: -->

```ruby
results = {
  name: experiment_name,
  status: status,
  context: experiment.context,
  # etc...
}.to_json.to_s

Rails.logger.info("[science-experiment] #{results}")
```

---

# Our reporting solution

<!-- In essence: -->

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

<!-- but let's look at an actual log entry in DataDog -->

---

# Other Opinionated Defaults

(Where we diverge from GitHub's implementation.)

---

# Other Opinionated Defaults

(Where we diverge from GitHub's implementation.)

- Only run in delayed jobs by default.
<!-- Largely for performance reasons. Cuts risk of timing-out web requests, limit customer impact. -->

---

# Other Opinionated Defaults

(Where we diverge from GitHub's implementation.)

- Only run in delayed jobs by default.
- Run 100% of the time locally and in CI.
<!-- There is no reason not to, since we aren't worried about performance. -->

---

# Other Opinionated Defaults

(Where we diverge from GitHub's implementation.)

- Only run in delayed jobs by default.
- Run 100% of the time locally and in CI.
- Raise locally if there are any mismatches.
<!-- Early implementation feedback! Don't wait until after a deploy to find obvious discrepancies! -->
<!-- Guarantees that production mismatches are for cases not covered by tests. -->
<!-- In fact, while I was refactoring our vesting math, I discovered a bug in the existing code! -->

---

# So how did it work?

zero-mismatches.png

<!--
timeline:

Got it green and discovered a bug in the control code.

Ran the experiment for a while, investigated failures.

Fixed a bug in the experiment.

Mismatches are now zero!

Also note the performance improvements (on average, at least)!
-->

---

# I need your help making it:

<!--
This is a new idea, so we need to reduce friction and discover/prevent any footguns.
The best way to do that is to battle-test our implementation.
-->

- Easy to add to our code.
<!-- works in many situations, and we want to know when to add it -->

---

# I need your help making it:

- Easy to add to our code.
- Hard to get wrong. <!-- protects us from common pitfalls, particularly around mutations -->

<!--
This is a new idea, so we need to reduce friction and discover/prevent any footguns.
The best way to do that is to battle-test our implementation.
-->

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
