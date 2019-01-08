title: Refactoring with Science
author: Nathan Griffith (aka smudge)
date: January 10, 2019
---

# Anatomy of a Code Experiment

```ruby
  Scientist.run 'my-experiment' do |e|
    e.use { current_implementation(user) }
    e.try { experimental_implementaiton(bar) }
    e.context(user_id: user.id, foo: 'bar')
  end
```

```java
  Experiment<Integer> e = new Experiment("foo");
  e.run(this::controlFunction, this::candidateFunction);
```

# Our reporting solution
# Case study
## Getting it green
And discovering a bug in the control
## Monitoring
And fixing a rare edge case
# Going forward, this needs to be:
- Easy.
- Low Risk.

<!--This is a new idea, so we need to reduce friction and discover/prevent any footguns.
The best way to do that is to experiment with our implementation and-->
