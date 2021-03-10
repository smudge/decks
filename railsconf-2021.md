class: center, middle

<h1 style="margin-bottom:0;font-size:80px;">Predicting the Improbable:</h1>
<h1 style="margin-top:0;">Writing resilient "save" methods</h1>

???

- Hi, I'm Nathan.
- And, uh, thanks for joining me here, on the internet.
- I'm happy to be here, giving this talk, on the internet, but also in my home, which is not the internet.
- Today I'm going to talk about "writing resilient save methods" by "Predicting the Improbable", but more on that later.
- First, a bit about me:

---


<h3 style="margin-bottom:0;">Nathan Griffith</h3>
<h4 style="margin-top:0;">https://ngriffith.com<br/>@smudge on GitHub<br/>@smudgethefirst on Twitter</h4>


???

- I'm a staff engineer at Betterment where I work on one of the platform teams.
- My team focuses on a lot of cross-cutting concerns, like performance, scale, resiliency, and developer efficiency.
- Outside of work, I enjoy karaoke, reading books, and lately I've been streaming a ton of Jackbox games over Zoom.
- Now, I joined Betterment in 2016, but I've been working with Ruby on Rails since 2008...
---

???

- ...when I was hired to help build web applications for my university's IT department.
- (there I am, probably trying to get a Rails view working with Internet Explorer 6.)

---

???

- Over the years, I've had the opportunity to see Rails applications grow, both in terms of lines of code and number of users.
- And I've had the privilege of helping solve some of the challenges that emerge along the way.
- There's one challenge in particular that has always interested me.

---

???

- It's the challenge of what to do about errors that _seem_ very improbable, but that happen anyways.
- These can take many forms: race conditions, data integrity issues, dropped messages, the list goes on.
- What all of these have in common is that they are:
=> intermittent and usually somewhat infrequent
=> difficult to detect with automated tests
=> hard to spot even when you think you know what you're looking for

- To help contextualize what I'm talking about, I'm going to tell a story.

---


???

So, one Monday morning, early in my career, I was with my team, planning out an exciting new feature, when an urgent bug report hit our radar.
A bit of payment processing code that had been in production for months had, out of nowhere, decided to ... run about 12 times instead of once.
I checked the database to confirm, and, yes. Over the weekend, one of our biggest clients had been charged twelve times for the same order.
I had no idea how this was possible, but there it was.

So, I spent the next few hours puzzling through layers of payment code.
Eventually, I discovered that a resiliency issue had been hiding in plain sight from the very beginning.
It was pretty obvious now, but of course hindsight is 20-20.
Thankfully, the client had a good sense of humor, and so we refunded them and shipped a fix.
---

???

Maybe this story sounds familiar. For me, it was the first time I encountered a such a puzzling error in production.
And the question I kept coming back to was... why now? Why did it suddenly fail now, and not weeks ago?

Now, if you're like me, this kind of experience will make you question your entire codebase.
If that very innocuous-looking piece of code could make it through thousands of runs with zero issues,
what other potential errors might be lying in wait, scattered throughout all the code we had written over the years?

---

# 🏖️

???

A few years (and many similar bugfixes) later, I was reading a book while on vacation, and a line jumped out at me.

---

## "Improbable things happen a lot"
### - Jordan Ellenberg

???

Now, there are whole chapters on probability and how to interpret the world around us.

But what struck me about this is that 

---

# 🤔

???

- For one, they tend to happen in and around persistence operations, or, as I like to call them, "save" methods.

---
class: middle
```ruby
def save!
  # ...
end

def update!(**attrs)
  # ...
end

def post_changes_to_api!
  # ...
end

def perform_later
  # ...
end
```

???

- I'm talking about any method that does "persistence" work.
- Maybe it sends things to a database. Maybe it posts them to a remote API. Or maybe it sends something to a job queue.
- Look, as far as I'm concerned, these are all "save" methods.
- And if we want to make our applications more resilient to 

---
class: center, middle

# Writing <strong>resilient<strong> "save" methods

???

The ability to recover to a stable, functioning state when something goes wrong. To fail... successfully, and then resume.

---
class: center, middle

# Writing ~~robust~~ <strong>resilient</strong> "save" methods

???

What I don't mean is "robust" -- a robust system can absorb failures and keep chugging along for as long as it can, until it doesn't and fails catastrophically.

That's not what I want to talk about today, I'm talking about making our persistence operations resilient to common types of errors.

---
class: middle

### "Improbable things happen a lot"<br/>- Jordan Ellenberg


---


???

The Improbability Principle
- David J. Hand

How Not To Be Wrong
- Jordan Ellenberg

Two books that came out in 2014.

---

# Law of Inevitability

???

- "Something must always happen."
- If a controller action does not succeed, it must still do _something._
- "If you make a list of all possible outcomes, then one of them must occur." (Even if we don't know which one.)

---

# Law of Truly Large Numbers

???

- Given enough opportunities, we should expect a specified event to happen.
- With enough traffic, unlikely errors are bound to occur.

---

# Law of the Probability Lever

???

- "A slight change in circumstances can have a huge impact on probabilities"
Something that seems very unlikely might become a lot more likely given the right conditions.
Say you inadvertently run a very expensive query, and suddenly your DB CPU is maxed out at 100%.
Or maybe your database fails over, causing all connections to go bad at once.
Or you have an unexpected traffic spike, and a bunch of requests pile up and time out en masse.
Point being, you can't assume that your code will always run under ideal conditions.
Something that works today might suddenly break in strange ways because of something totally unrelated.

---

???

The scale tipping point: when the impact of novel errors surpasses the impact of "known" issues.


---


# WRITE IT OUT

Get it to fit in the 

# ASK: CAN I BREAK THIS?

---

???

- Our entire careers, we've been writing variations of the same save operation. 
- It _always_ (or almost always) fits in this structure.


---

```ruby
class PasswordChangesController < ApplicationController
  def create
    password_change = PasswordChange.new(
      user: current_user,
      old_password: permitted_params[:old_password]
      new_password: permitted_params[:new_password]
    )

    if password_change.save
      # yay
    else
      # boo
    end
  end
end
```

```ruby
class PasswordChange
  include ActiveModel::Model

  attr_accessor :user, :old_password, :new_password

  def save
    if user.authenticate(old_password)
      user.update(password: new_password)
    end
  end
end
```

---

```ruby
def save
  user.update(email: email)
end
```

```ruby
def save
  user.update(email: email) &&
    
end
```


---

```ruby
def save
  user.email = email
  if user.valid?
    user.save!
  end
end
```

---

```ruby
def save
  user.email = email
  if user.valid?
    user.save!

  end
end
```



---

???





When I say "Predicting the Improbable", I'm not talking about anything magical.

---

???

We aren't gazing into a crystal ball and observing the future state of our bug tracker.
Instead, we can make informed predictions based on careful observation of our code.
Our goal is to reduce uncertainty about what _might_ go wrong, not say for sure what _will_ go wrong.

