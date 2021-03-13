class: center, middle

<h1 style="margin-bottom:0;font-size:80px;">Predicting the Improbable:</h1>
<h1 style="margin-top:0;">Writing resilient "save" methods</h1>
<h2 style="margin-top:0;margin-bottom:0">Nathan Griffith</h2>

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
- My team focuses on a lot of cross-cutting concerns, like performance, scale, and developer efficiency.
- Outside of work, I enjoy karaoke, reading books, and lately I've been streaming a ton of Jackbox games over Zoom.
- Now, I joined Betterment in 2016, but I've been working with Ruby on Rails since 2008...
---

# [me in 2008]

???

- ...when I was hired to help build web applications for my university's IT department.
- (there I am, probably trying to get a Rails view rendering correctly in Internet Explorer 6.)

---

# [rails at scale badge]

???

- Over the years, I've had the opportunity to see Rails applications grow, both in terms of lines of code and number of users.
- And I've had the privilege of helping solve some of the challenges that emerge along the way.
- Let me tell you a story of one such challenge:

---

# 

???

It was a Monday morning, many years and several jobs ago.
I was working at a growing B2B company, planning out an exciting new feature with my team, when an urgent bug report hit our radar.
A bit of payment processing code that had been in production for over a year had, out of nowhere, decided to ... run about 12 times instead of once.
I checked the database to confirm, and, yes. Over the weekend, one of our clients had been charged twelve times for the same order.
I had no idea how this was possible, but there it was.

So, I spent the next few hours puzzling through layers of payment code.
Eventually, I discovered that a very subtle persistence bug had been hiding in plain sight from the very beginning.
A system outage had caused a background job to get stuck in a retry loop, resulting in periodic charges through a 3rd party payment provider.
It was pretty obvious to me at this point, but of course hindsight is 20-20.
Thankfully, the client had a good sense of humor, and so we refunded them, and we shipped a fix, and all was well.
---

???

Maybe this story sounds familiar. For me, it was the first time I really felt the pain of running a live application.
And the question I kept coming back to was... why now? Why did it suddenly fail now, and not weeks ago?

If you're like me, this kind of experience will make you question your entire codebase.
If that very innocuous-looking piece of code could make it through thousands of runs with zero issues,
what other potential errors might be lying in wait, scattered throughout all the code we had written over the years?

---

# Why now?

???

- This question, of why errors happen when they do, and what we can do to guard against them,
- is going to be core to this talk.

- Now, when I found that payments bug, I didn't know it at the time, but I've come to realize is that what I was reaching for was resiliency.

---
class: center, middle

# resilient code

???

- Resilient code gets us through adverse conditions. When something goes wrong, it fails gracefully, and quickly,
- in a way that is predictable, and that can eventually resume normal operation without intervention.
- instead of charging a client 12 times, a resilient system might fail to charge, until success is more guaranteed

---

[aesop's fable: the oak and the reed]

???

- It's a bit like aesop's fable of oak and the reed.
- The oak tree is a system that is designed to stay standing. It sounds good, in theory,
- But when a really big storm hits, it stays vertical as long as it can, and then fails catastrophically.
- The reed, on the other hand, is a system that is resilient.
- During the storm, the reed is flattened to the ground quickly, but gradually recovers once the wind and rain subsides.

- The storm, in this metaphor, represents the realities of a production environment.
- Things like traffic spikes, memory limits, timeouts, multithreading issues, network errors, service outages.
- I'd like to categorize all of these under a single word:

---

# ⛈️  "entropy" ⛈️

???

- entropy.
- Now, this kind of entropy, software entropy, isn't a universal law, like like the second law of thermodynamics, 
- but much like that law, what we see in software is that entropy typically increases over time.
- As an application gets more users, receives more traffic, gets more features, does more things, entropy goes up.
- I suspect this is what we often mean by the word "scale"

---

# "scale" ≈ entropy 📈

???

- It's the entropy of the live application environment that leads us, as application maintainers, to encounter entirely new classes of error.
- You'll begin to uncover things like data integrity issues (where invalid data starts to crop up in your tables),
- or race conditions (where two processes compete for some operation and do something unexpected),
- or just strange bugs in general, like dropped messages, missed emails, pages that sometimes fail to render and nobody knows why,
- I mean, the list goes on.
- For me, these weren't the kinds of things I thought about when I set out to build Rails apps in 2008.

---

[build a blog in 5 minutes]

???

- I mean, I was thinking about building cool and useful things!
- In my world, all of the code underneath either worked or it didn't.
- If it didn't work, we fixed it, and then it worked. Mission accomplished!
- But as I'm sure many of you know very well, that's not how reality works.

---

# 😮

???

- It may have taken a while for me to get there, but
- learning that that's not how the world works is the _first step_ towards writing resilient code.
- And as I became more responsible for the uptime of apps, I began to change the way I thought about failures.

---

[graph of errors, with a long tail]

???

- If we were to take an application today,
- and graph all the types of errors we saw last month by their frequency, we get something like this.
- In 2008, I was focused entirely on the left. The errors that were obvious.
- Anything on the right was "transient" or "flakey." We saw it once, but it went away. No worries.
- And to be fair, some things in there _are_ truly transient errors, one-off blips that we're safe to just ignore.
- But some of them are like that payment processing error. They're real bugs, they just don't fail right away.
- And if you aren't careful, they'll start to overwhelm you.
- Entropy will go up, and you'll be drowning in a long tail of errors that only _sometimes_ happen.
- They might not happen _today_. Or even this _week_.
- Or, even, ever. There are plenty of _potential_ errors that will never show up in this graph.
- Instead of thinking of this as a known list of issues, we could instead think of it as...

---

[mirrored graph, with a bell curve overlaid]

???

- a bell curve!
- as far as resiliency goes, we're not very worried about the things in the middle.
- these kinds of errors make themselves known quickly, and with enough volume or urgency that we notice them right away and fix them.
- instead, we are are concerned with the outliers.
- errors that may _seem_ very unlikely, but that happen anyways.
- They _might_ happen, but simply haven't happened _yet._
- And that leads us to another realization.

---


## errors are probabilities

???

- errors. are. probabilistic. and resiliency, is inherently probabilistic.
- Of course, most of the bugs we catch with our automated tests have a high chance of occurring. Like, often 100%.
- but the bugs we don't catch, the ones that lie in weight, they might only happen 1/100 times, 1/1000, 1/1M

- Does that mean we shouldn't worry about them? Or should we invest more in preventing them?
- Well, probabilities are just math, right? But I'm no mathematician, that's for sure.
- So maybe we should consult a mathematician.

---

# 🏖️ + [photo of book]

???

- A couple years after that payment snafu, I was reading a book while on vacation.
- It's a great book, despite its title, and I'd definitely recommend it.
- But that day on the beach, one line in particular jumped out at me:

---
class: middle

## "Improbable things happen a lot"
### - Jordan Ellenberg

???

- Improbable things happen a lot.
- Now, there are whole chapters on how probability theory can help us interpret the world around us.
- But this line in particular could easily be applied to software engineering:

---
class: middle

## "Improbable ~~things~~ errors happen a lot"
### - Jordan Ellenberg
#### - Me

???

- At a certain scale, improbable errors happen a lot.
- We don't know which ones they'll be, we just know that as entropy increases, they'll happen, somewhere in our app.
- This speaks to a phenomenon that a lot of statisticians talk about.
- They call it...

---

# The Law of Truly Large Numbers

???

- It's a law in the same way that Murphy's Law is a law, meaning it's more of an adage.
- It's also not the same thing as the Law of Large Numbers.
- The law of _Truly_ Large Numbers states that, given enough opportunities, we should expect crazy and outrageous things to happen.
- It's not just that they _can_ happen. They _will_ happen.

---

# [ book cover ]

???

- Time for another book recommendation.
- The Improbability Principle by David J. Hand, a statistician,
- devotes an entire chapter to The Law of Truly Large Numbers

---

# ⛈️  + 🎰 + ⛳

???

- The book outlines examples of this law in action, and many of them involve lightning strikes, lotteries, and golf
- Where the same person survives multiple lightning strikes, years apart,
- Or, wins the lottery twice,
- Or, gets two holes in one, two days in a row.
- Maybe not the _same_ person experiences all of the above, but... maybe they do...?

---

[ our world in data population growth chart? maybe with earth overlayed? ]

???

- The Law of Truly Large Numbers reminds us that, that since we have nearly 8 billion people on the planet,
- events that seem extraordinarily unlikely should be _expected_ to happen somewhere, every day.

- You know what else supports billions of people?

---

# [ facebook logo ] [ youtube logo ] [ WhatsApp logo ]
## [ apple logo ] [ gmail logo ] [ twitter logo ]


sources:
https://datareportal.com/social-media-users
https://techcrunch.com/2016/02/01/gmail-now-has-more-than-1b-monthly-active-users
https://9to5mac.com/2020/01/28/apple-hits-1-5-billion-active-devices
???

- Now, a billion monthly active users is A LOT.
- Very few of us can expect the code we write to approach anywhere near that number.
- But that doesn't mean that these principles don't apply to others in the industry.

---

# 

[ bell curve with arrow ]

???

- a failure that has a one-in-a-million chance of occurring _will_ occur if it is given enough chances.
- How many web requests have you had in the entire lifetime of your app?
- even a one-in-a-thousand bug might not really show up, until we hit a certain number of users.

---

# [ book cover ] [ book cover ]

???

- Again, I'm no mathematician, or statistician, so I'd encourage you to read these books, and develop your own takeaways.
- By the way, _both_ of these books came out at like the time in 2014, and now seven years later I've referenced them both on the same slide.
- Maybe that's just another improbable coincidence that both books can explain.

- I'd like to pull one more law out of that second book, The Improbability Principle,
- because I think we can also apply it here.

---

# Law of the Probability Lever

"A slight change in circumstances can have a huge impact on probabilities"

???

- And that's the Law of the Probability Lever
- It states that "A slight change in circumstances can have a huge impact on probabilities"

---

[ see saw diagram ]

???

- Like a see-saw, when one person moves a little, the whole thing can tip in a new direction.

---

[ error rate chart with big spike ]

???

- So, how does this apply to a Rails app?
- Essentially, a resiliency error that seems very unlikely might become a lot more likely given the right conditions.

- Say, for example, your database fails over, causing all open connections to go bad at once.
- Think of all the codepaths that might be halfway-done right at that moment.
- Suddenly, * snaps fingers * -- there's your probability lever.

- It's a similar story if you have an unexpected traffic spike, and a bunch of requests time out en masse.
- Or, say you inadvertently run a very expensive query, and now your database CPU is maxed out.
- By running that query, you, yourself have created novel conditions under which ... who knows what might happen.

---
class: middle, center

# Your Code Will Often Run Under Less-Than-Ideal Conditions

???

- Point being, you can't assume that your code will always run under ideal conditions.
- The Law of the Probability Lever tells us that failures aren't always unrelated.
- They may play off one another, and create an environment that makes unlikely errors suddenly very likely.

---

# What we know, and next steps.

???

- By now, we should have a sense for what "resiliency" means.
- We've learned that with enough opportunities or under the right conditions, we should _expect_ improbable failures.
- And we should anticipate, that when scale up our apps, essentially adding entropy to the system, _old code_ will yield _new bugs_.


- So next, let's talk about how we can use this knowledge to actually _predict_,
- and _prevent_ some of the more common resiliency issues.

---

# 🔮

???

- To be clear, when I say "predict", I'm not talking about telling the future.
- We aren't gazing into a crystal ball and observing our bug tracker a month from now.
- We know by now that future errors are just probabilities.
- So our goal is to reduce uncertainty about what _might_ go wrong, even if we can't say for sure what _will_ go wrong.
- We can make informed guesses based on careful observation of our code.

---

# 🔍 👀

???

- There's one observation, a big one, that I'm gonna focus on for the next part of this talk.
- And that is that most resiliency issues involve _persistence operations_.
- Things like updates, insertions, deletions.

---

# persistence operations

???

- Such code might live in your controller, or in model callbacks, or a cron job, maybe a rake task.
- Wherever it lives, what it does, usually, is save things to a database. But not always!
- Maybe it posts them to a remote API. Or maybe it sends something to a message queue.
- As long as it persists a change into the universe, and so, it's a "persistence" operation.
- By that logic, I would argue that sending an email counts. It's a kind of write-only distributed database.
- So that's a persistence operation. Every app will do it a little differently, all apps do some form of it.


- So, once you've identified a persistence operation, there are a few steps you can take to make it a _lot_ easier to find and fix resiliency bugs.
- Let me walk you through those now.

---

# 1. Write down each step
# 2. 
# 3. 

???

- Step one, is to write down the whole operation, all in one place.
- It doesn't matter what your code looks like today, or what you'll end up shipping to production.
- For the purposes of this exercise, you'll want to pull everything together into one method body, one list of actions, that you can then read procedurally.
- So, let's apply this to some actual code.


---

```
class < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @invite = Invite.new(params.require(:invite).permit(:email, :name))

    if @invite.save
      @user.update(last_invite_sent_at: Time.zone.now)

      # redirect_to :something
    else
      # render :new
    end
  end
end
```

???

Simple case: create 1 thing, update another, txn needed
- BEGIN ... COMMIT
- in order for anything to save, you must get to that commit. The "end" on our txn.

- but transactions require exceptions to trigger rollbacks, so we change these to !
- how do we return true/false without rescuing exceptions?
- separate validity from persistence. (valid? = a.valid? && b.valid?)
- but this might still return more than true/false, it might raise!

- this is okay. Using valid? to guard against user-correctable errors, and we rely on whiny persistence to notify us of developer errors. We will see an error in our bug tracker. Without this, the customer might see something strange. (Case study: invalid data at rest due to phone number validation)

Side effects and queues / ActiveJob

Co-transactionality and side effects
- queue cannot see the changes yet.
- you could introduce a delay, but if it fails to commit, the update will implicitly roll back, and the queue runs a job that it shouldn't.

Solutions:
- Wait until after commit! Now we're back to the first problem! Maybe this is okay. After_commit is a common solution for companies on Redis-backed queues (resque, sidekiq).
- use a co-transactional queue like delayed_job or que.


Email change + email verify - locks



---

```ruby
class EmailChangesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    email = params.require(:user).permit(:email)[:email]

    if @user.update(email: email)
      BetaTesterInvite.find_by(email: @user.email_was)&.update(email: email)

      # redirect_to :something
    else
      # render :new
    end
  end
end

class User < ApplicationRecord
  # ...

  after_commit :send_email_change_notifications, if: :saved_change_to_email?

  # ...

  def send_email_change_notifications
    UserMailer.with(self, email_was).email_change_notification.deliver_now
    UserMailer.with(self).email_verification.deliver_now
  end
end
```

???

- Don't try to look for bugs just yet. We're going to focus on identifying what is happening, and writing it down.
- We have an email changes controller that accepts some params, looks up a user, and updates that user's email.
- If that works, then it looks like someone added an extra step, to update the email on a different model, if it exists.
- But we're not done there! ActiveRecord models support callbacks, and on User, we have an after_commit callback.
- So when the user save successfully commits, we call "send_email_change_notifications" to send an email to the new address.
- Remember what I said earlier? Sending an email is just another part of saving things!

---

# 1. Write down each step

```ruby
class EmailUpdate
  def initialize(user:, email:)
    @user = user
    @email = email
  end

  def save
    if @user.update(email: email)
      UserMailer.with(@user, @user.email_was).email_change_notification.deliver_now
      UserMailer.with(@user).email_verification.deliver_now
      BetaTesterInvite.find_by(email: @user.email_was)&.update(email: email)

      true
    else
      false
    end
  end
end
```

???

- Here's what we get if we consolidate all of those steps into one place
- I really like calling these operations "save", and I'll explain why in a bit, but for now,
- the point is that we can see everything in one place.
- We update the user, and if it works, we trigger the mailer, and then, we go and do that other update.

---

# 1. Write down each step
# 2. Ask: Can I break this?
# 3. 

???

Halt execution
=> only some of it will save

---

# 1. Write down each step
# 2. Ask: Can I break this?
# 3. Refactor to reduce uncertainty.

???


=> add a transaction
=> make the entire operation atomic. If you don't get to that `end`, it never commits, so it rolls back, like it never happened.
=> This also gives you isolation. While you're performing these actions, no other processes can see them. Only you.



Tools:
- Halt execution
 => txn


- Make it happen twice at exactly the same time
 => pessimistic lock (SELECT FOR UPDATE)
 => advisory lock

- Using a state machine
 => ensure that side effects don't run twice

- Save things to different datastores
 => co-transactional queue
 => after_commit (if you must)
 => eventual consistency



Resiliency by default












---

# Law of Inevitability

???

- "Something must always happen."
- If a controller action does not succeed, it must still do _something._
- "If you make a list of all possible outcomes, then one of them must occur." (Even if we don't know which one.)
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

