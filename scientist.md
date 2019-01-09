title: Refactoring with Science
author: Nathan Griffith (aka smudge)
date: January 10, 2019
---

# "Science"

science.gif

<!--
In the fall of 2018, the B4B team discovered a rare edge case in our participant vesting logic. To fix it, we would need to refactor some existing code in a nontrivial way.

Unfortunately, this would impact a highly-trafficked, business-critical codepath, and could adversely affect a wide array of balance calculations. We decided that relying on automated tests alone might not be sufficient given the risks involved, so we decided we needed to be able to safely test this change in production.

That's where "Science" comes in.
Or, more specifically, a controlled experiment that we ran in our production environment.
-->

# Why?

- Reduce the risk of refactoring our code
<!--
be confident in the stability of a major changes, before we ship the change

sidebar: you might ask, right, so why not just write a bunch of tests
and you wouldn't be wrong. our test suite is an obvious line of defense...
...but it doesn't have to be the only one.
-->
- Speed up development
<!--
by reducing the risk of making major changes, we can...
...make those major changes that allow us to deliver quality software faster
...and be more confident that decisions we make today can be adjusted in the future.
-->

# How?

1. Run new code along side existing code. <!-- the code it is meant to replace -->
2. Compare outputs & track whether or not they match.
3. Return the output of the existing code. <!-- so, effectively, the new code is NOT live -->

# `scientist`

GitHub made a Ruby gem to do exactly this.

It has been ported to many, many languages, including Java.

But it doesn't do everything. <!-- like reporting -->

# Anatomy of a Code Experiment

```ruby
  Scientist.run 'my-experiment' do |e|
    e.use { current_implementation(user) }
    e.try { experimental_implementaiton(bar) }
  end
```

# Anatomy of a Code Experiment

```java
  Experiment<Integer> e = new Experiment("foo");
  e.run(this::controlFunction, this::candidateFunction);
```

# Anatomy of a Code Experiment

```ruby
  Scientist.run 'my-experiment' do |e|
    e.use { current_implementation(user) }
    e.try { experimental_implementaiton(bar) }
  end
```

# Anatomy of a Code Experiment

```ruby
  Scientist.run 'my-experiment' do |e|
    e.use { current_implementation(user) }
    e.try { experimental_implementaiton(bar) }
    e.run_if { rand(100) < ENV['MY_EXPERIMENT_ROLLOUT'] } # 10% of the time
  end
```

# Anatomy of a Code Experiment

```ruby
  Scientist.run 'my-experiment' do |e|
    e.use { current_implementation(user) }
    e.try { experimental_implementaiton(bar) }
    e.context(user_id: user.id, foo: 'bar')
    e.ignore { |control, experiment| (control - experiment).abs < 0.1 }
  end
```

# Our reporting solution

```ruby
results = { name: experiment_name, status: status }.to_json.to_s
Rails.logger.info("[science-experiment] #{results}")
```

# Other Opinionated Defaults

Where we diverge from GitHub's implementation.

- Only run in delayed jobs by default.
<!-- lower customer impact, and zero risk of timing-out web requests -->
- Run 100% of the time locally and in CI.
- Fail automated tests if there are any mismatches.

# So how did it work?

Let's look at the dashboard.

<!--
timeline:

Got it green and discovered a bug in the control code.

Ran the experiment for a while, investigated failures.

Fixed a bug in the experiment.

Mismatches are now zero!
-->
# I need your help making it:

- Easy to add to our code. <!-- works in many situations, and we know when to add it -->
- Hard to get wrong. <!-- protects us from common pitfalls, particularly around mutations -->

<!--
This is a new idea, so we need to reduce friction and discover/prevent any footguns.
The best way to do that is to battle-test our implementation.
-->
