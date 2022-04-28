---
theme: default
colorSchema: light
title: RAILS_ENV=demo
info: For RailsConf 2022
highlighter: shiki
lineNumbers: false
background: /images/demo_mode_fancy.jpg
class: text-center
---

# **RAILS_ENV=demo**

#### unlocking the potential of the "demo" environment

<!--
Okay, so let's get started.

Hello. Welcome. I'm Nathan. I'm glad to be here.
A little nervous, too.

This is actually my first live conference talk.

I gave one last year, but it was prerecorded, so I spent like a week recording over and over trying to get the perfect take. Would definitely not recommend, so I'm more than happy to YOLO this one with you all today.
-->

---
layout: section
---

# RAILS_ENV=demo

<!--
Okay, so you might be here because you saw the title of this talk

RAILS_ENV=demo

and something about it intrigued you.

Or maybe you just picked a room at random. I don't know why you're here.

But either way, let's just unpack this title.
-->

---
layout: fact
---

## **RAILS_ENV=<ins>demo</ins>** bundle exec rails s

<!--
So, what it refers to is the environment variable used to control the mode that your Rails app boots up in.
-->

---
layout: fact
---

## **RAILS_ENV=<ins>development</ins>** bundle exec rails s

<!--
Now, by default, that's actually gonna be development.
-->

---
layout: fact
---

## **RAILS_ENV=<ins>test</ins>** bundle exec rails s

<!--
Or test if you're running your tests
-->

---
layout: fact
---

## **RAILS_ENV=<ins>production</ins>** bundle exec rails s

<!--
And you can toggle it to production, when you deploy your app somewhere.
-->

---
layout: fact
---

## **RAILS_ENV=<ins>staging</ins>** bundle exec rails s

<!--
Some teams might also have a staging environment.
-->

---
layout: fact
---

## ~~**RAILS_ENV=<ins>staging</ins>** bundle exec rails s~~

<!--
But that's actually not one of the built-ins.
-->

---
layout: fact
---

## RAILS_ENV={**development**, **production**, **test**}

<!--
Out of the box you get the big three: development, production, and test.
-->

---
layout: center
---

```bash
$ ls config/environments/

  development.rb
  production.rb
  test.rb
```

<style>
pre {
font-size: 200% !important;
line-height: 120% !important;
}
</style>

<!--
and these environments correspond to
files live in your config-slash-environments folder
-->

---
layout: center
---

### config/environments/production.rb

```ruby
Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true

  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  config.assets.compile = false

  config.log_level = :info
  config.log_tags = %i(request_id)

  # ...
end
```

<!--
And these files contain the actual *instructions* for how your app should behave in each environment.

Like, what makes that environment unique.

With me so far? Good.
-->

---
layout: fact
---

## RAILS_ENV={**demo**, development, test, production}

<!--
And so what I'm going to be talking about today is this idea of adding a new, dedicated environment -- called "demo" -- for giving, well, application demos.
-->

---
layout: image
image: /images/sales-pitch.jpg
---

<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@xteemu?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Teemu Paananen</a> on <a href="https://unsplash.com/s/photos/pitch?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
Like, the ability to step up in front of an audience, and show off a live version of your product.
Like, reliably. And repeatably. And consistently.

Because the last thing you want is to get up there, and for something to go horribly wrong, or even a little wrong.
-->

---
layout: image
image: /images/showroom.jpg
---

<div style="position:absolute;right:10px;bottom:10px"  class="text-xs">
Photo by <a href="https://unsplash.com/@rahulbhogal?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Rahul Bhogal</a> on <a href="https://unsplash.com/s/photos/showroom?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!-- 
So think of this like the showroom model of your app.
-->

---
layout: image
image: /images/kiosk.jpg
class: bg-contain
style: 'background-size: contain'
---

<div class="text-xs" style="color:grey;position:absolute;right:10px;bottom:10px">
Source: <a href="https://www.reddit.com/r/n64/comments/bn3x7d/playing_demos_in_the_stores/">reddit.com</a>
</div>

<!--
or maybe the walmart gamecube kiosk version of your app.

except without the horrible neck strain.
-->

---
layout: center
---

```bash {3}
$ ls config/environments/

  demo.rb
  development.rb
  production.rb
  test.rb
```

<style>
pre {
font-size: 200% !important;
line-height: 120% !important;
}
</style>

<!--
And I wish I could say it were as simple as just adding a new
demo.rb file to your app, but that's just the tip of the iceberg.
-->

---
layout: image
image: /images/iceberg.jpg
class: text-center
---

<div class="mt-50 text-shadow-lg">

<h1 style="font-size:400%"><b>"demoability"</b></h1>

</div>

<!--
Because "demoability" -- the ability to quickly take something
you've been building, and show it off to the world -- is about
a lot more than just the way you boot up your app.

It's actually something I and my team have been thinking
about and iterating on for almost six years.

And so who am I?
-->

---
layout: image-left
image: /images/me.jpg
---

# Nathan Griffith

GitHub: <a href="https://github.com/smudge">@smudge</a><br/>
Twitter: <a href="https://twitter.com/smudgethefirst">@smudgethefirst</a><br/>
Homepage: <a href="https://ngriffith.com">ngriffith.com</a>

<!--
Well, let me introduce myself.

My name is Nathan. I exist online in a few places.

I also exist in real life, and I work at a company called Betterment.
-->

---
layout: center
class: px-40
---

![Betterment Logo](/images/betterment.png)

<!--
You might've heard of us. We offer financial advice, investing accounts,
retirement, you name it.
I like to say that our top product is financial peace of mind.

And I work on the application platform teams at Betterment.
We focus on a lot of cross-cutting concerns, and we
provide our product teams with more of a day-to-day peace of mind.

But I haven't always worked on this team.
-->

---
layout: image
image: /images/2016.svg
---
# &nbsp;

<!--
Now, the story I want to tell starts in 2016, when I first joined Betterment.
-->

---
layout: center
class: px-30
---

![Betterment Logo](/images/b4b.png)

<!--
Back then, I was on a different team, helping build Betterment's 401k offering,
which is now part of Betterment @ Work.
-->

---
layout: image
image: /images/sales-b2c.svg
---

# &nbsp;


<!--
And so while most people think of Betterment as a B2C business.
Like, financial services for everyday people like me and my parents.
-->

---
layout: image
image: /images/sales-b2b.svg
---

# &nbsp;

<!--

The thing my team was building was actually a B2B product.
Because our customers were companies, who might want to offer 401k plans to their employees.

And, look, I'm not on the business side of things.
I'm just a humble software engineer,

But if there's one thing I know about B2B businesses,
it's that they do a lot of product demos.
-->

---
layout: image
image: /images/sales-b2c2b.svg
---

# &nbsp;

<!--

And so we found ourselves in a position where, we 
really wanted to SHOW OFF Betterment's consumer product
to all of our new and prospective business clients.

And so how did we do that?
-->

---
layout: two-cols
class: text-center px-10
---

# RAILS_ENV=**production**

<img src="/images/app-cluster.png" class="pr-10 pt-3"/>

::right::

<v-click>

# RAILS_ENV=**staging**

<img src="/images/app-cluster.png" class="pr-10 pt-3"/>

</v-click>

<!--
So, firstly, there's always the option to just use the production app, right? And in our case, it's a cluster of multiple applications.
But since our app involves real money, and real personal info, that option didn't feel great.

But we looked around and saw that Betterment also had a _staging_ environment.

CLICK

It was deployed in exactly the same overall configuration as production, except
the database was reset and repopulated nightly with some magical sanitized data instead of real production data.

And we said, hey, what if we just did something like that?
-->

---
layout: center
---

![how to draw an owl](/images/how-owl.jpg)

<!--
and if this sounds a bit like

"step 1, draw circles, step 2, draw the owl"

it's because that's exactly what this is.
you see, if what you need is a drawing of an owl,
and someone else is already drawing owls,
then you don't really need to learn to draw the owl.
-->

---
layout: two-cols
class: text-center px-10
---

# RAILS_ENV=**staging**

<img src="/images/owl.jpg" class="mt-15 ml-15" />

::right::

<v-click>

# RAILS_ENV=**demo**

<div class="relative mt-15">

<img src="/images/owl.jpg" class="ml-15" />

<img src="/images/tophat.svg" class="absolute" style="top:-45px; left:120px; transform:rotate(25deg);" />
<img src="/images/moustache.svg" class="absolute" style="top:15px;left:48px; width:50%;" />

</div>

</v-click>

<!--
And so, the staging environment was our owl.

Of course, we made a couple modifications to the owl. We
didn't need or even want all of the sanitized staging data, so
we added another process that would pick out just the demo
accounts we needed and keep those around.
-->

---
layout: two-cols
class: text-center px-10
---

# RAILS_ENV=**staging**

<img src="/images/app-cluster.png" class="pr-10 pt-3"/>

::right::

# RAILS_ENV=**demo**

<img src="/images/app-cluster.png" class="pr-10 pt-3"/>

<!--
But as for the rest of it, we just copy-pasted the deployment
scripts, the environment file, everything that made staging...
staging. And we deployed it, 
-->

---
layout: image
image: /images/reenactment.jpg
---

<div style="position:absolute;right:10px;bottom:10px"  class="text-xs">
Photo by <a href="https://unsplash.com/@xteemu?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Teemu Paananen</a> on <a href="https://unsplash.com/s/photos/pitch?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
and it worked! so, our work was done, right?

well that's what we thought.
-->

---
layout: image
image: /images/2017.svg
---

# &nbsp;

<!--
But fast forward a bit, to 2017.
-->

---
layout: image
image: /images/roadmap.jpg
---

<div style="position:absolute;right:10px;bottom:10px"  class="text-xs">
Photo by <a href="https://unsplash.com/@airfocus?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">airfocus</a> on <a href="https://unsplash.com/s/photos/roadmap?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>  

<!--

We were still hard at work on our roadmap.
-->

---
layout: center
---

<img style="width:60%;margin:0 auto;" src="/images/slacks/1.png" />

<v-clicks>
<img style="position:absolute;left:8%;top:40%;width:60%;transform:rotate(-9deg)" src="/images/slacks/2.png" />
<img style="position:absolute;left:45%;top:50%;width:50%;transform:rotate(12deg)" src="/images/slacks/3.png" />
<img style="position:absolute;left:25%;top:60%;width:60%" src="/images/slacks/4.png" />
<img style="position:absolute;left:20%;top:15%;width:60%" src="/images/slacks/5.png" />
<img style="position:absolute;left:15%;top:25%;width:50%;transform:rotate(-15deg)" src="/images/slacks/6.png" />
<img style="position:absolute;left:30%;top:20%;width:50%;transform:rotate(15deg)" src="/images/slacks/7.png" />
<img style="position:absolute;left:10%;top:30%;width:60%" src="/images/slacks/8.png" />
<img style="position:absolute;left:18%;top:45%;width:50%;transform:rotate(-40deg)" src="/images/slacks/9.png" />
<img style="position:absolute;left:30%;top:30%;width:50%;transform:rotate(30deg)" src="/images/slacks/11.png" />
</v-clicks>

<!--
But we were getting a sense that the demo environment wasn't really all that reliable.

And, you know, anytime this happened, we could drop
what we were doing and fix it. But it was always a choice between
that and the roadmap.

Plus, everytime it broke,
it got a little bit harder to fix. Like an old
car that you keep patching up until eventually it's held
together by duck tape and sheer force of will.

and eventually, one morning, when you turn the key to start the ignition,
-->

---
layout: center
---

<img src="/images/slacks/12.png" />


<!--
nothing happens.
-->

---
layout: center
class: pt-20
---


<img style="width:42%;margin:0 auto;" src="/images/jenkins.png" />

<!--

that's where we ended up. and so we effectively gave up. And it felt bad.

By the way, we don't use Jenkins anymore, but I saved this screengrab of our build history,
and if you look closely, it's actually an entire year's worth of broken builds.

Each one of those was a developer, banging their head against their keyboard, trying to get this working.
-->

---
layout: image
image: /images/2019.svg
---

# &nbsp;

<!--
So fast forward again, and by 2019, the business needs had caught up with us
again. We really needed this thing to be working.

But we also had time in our roadmap finally.
-->

---
layout: image
image: /images/iceberg.jpg
class: text-center
---

<div class="mt-50 text-shadow-lg" v-click>

<h1 style="font-size:250%"><b>maintenance burden > up-front cost</b></h1>

</div>

<!--
And thinking back to that iceberg of demoability, we had already learned the first lesson, right under the surface:

CLICK

The maintenance burden is always going to outweigh the up front cost. And so we knew that this time around,
we needed to figure out a solution that we could maintain in the long run.
-->

---
layout: image
image: /images/notebook.jpg
class: font-mono pl-40 text-3xl pt-10
---

<style>
li { list-style-type: none; }
li + li {
  margin-top: 1em;
}
</style>


<div class="text-gray-800">

<v-clicks>

- Consisted of **multiple apps/services**
- Populated with **seed/fixture data**
- Relied on **short-lived databases**
- Deployed via **push-button (and 🤞)**
- Owned by **one team**

</v-clicks>

</div>

<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
And so we started just writing down a list of what the original demo env had consisted of.

Firstly, what got deployed? Well, everything. All of our apps.

Secondly, the database was populated up front with all of the demo accounts,

and the entire database got reset with every deployment.

And at first, all of this was deployed weekly (on Sundays), and then Monthly,
but when even that got to be too painful, we started only deploying when we
needed to. So it was "push button" deploys, but I'd call it"push button and
cross fingers"

Lastly, who maintained it? Well, us. The engineering team closest to the need
for its existence (and most incentivized to do the work).

And so, now that we had this list, we started crossing things out.
-->

---
layout: image
image: /images/notebook.jpg
class: font-mono pl-40 text-3xl pt-10
---

<style>
li { list-style-type: none; }
li + li {
  margin-top: 1em;
}
</style>

<div class="text-gray-800">

- Consisted of ~~**multiple apps/services**~~
- Populated with **seed/fixture data**
- Relied on **short-lived databases**
- Deployed via **push-button (and 🤞)**
- Owned by **one team**

</div>

<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
Starting with the idea of deploying an entire cluster of services.

And the choice there should be obvious right? From a maintainability standpoint, why keep a _bunch_ of apps running if we really only cared about one app. The thing we wanted to demo.

And that got us thinking, because at Betterment we already have a way of running our Rails apps in isolation.
-->

---
layout: image
image: /images/dev-laptop.jpg
---

<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@cgower?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Christopher Gower</a> on <a href="https://unsplash.com/s/photos/laptop-office?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>


<!--

It's how we run them on our development laptops!

And so when we develop apps locally, we use a tool called...
-->

---
layout: center
---

![webvalve](/images/webvalve.png)

<!--
...webvalve.

what webvalve lets us do is define fake versions of any external service or app,
and it will automatically route all web traffic to the fakes.
-->

---
layout: two-cols
class: text-center px-10
---

# Without WebValve:

<v-click>

<img src="/images/webvalve-without.png" class="pt-3" />

</v-click>

::right::


# With WebValve:

<v-click>

<img src="/images/webvalve-with.png" class="px-10 pt-20" />

</v-click>

<!--
and so 

CLICK

instead of running an entire cluster of applications locally, or maybe connecting to external sandbox APIs

CLICK

we have a set of fakes which actually run _inside_ of the Rails app itself.

So it's all one Rails process.
-->

---
layout: center
---

```ruby {all|3}
class FakeBank < WebValve::FakeService
  get '/widgets' do
    json result: { value: 9.99, message: 'it works!' }
  end
end
```

<style>
pre {
font-size: 150% !important;
line-height: 120% !important;
}
</style>


<!--
And these fakes apps are really simple.

They don't have to do everything the real app would do,

CLICK

they just have to respond with some fake data, so that your app doesn't break.
-->

---
layout: center
---

![rails at scale](/images/rails-at-scale.jpg)

<!--
Now, there's a whole other talk on WebValve itself.
-->

---
layout: center
class: px-30
---

![rails at scale 2](/images/rails-at-scale-2.png)

<!--
And our VP of Architecture, Sam, summarizes how useful WebValve can be for local development
and testing, and so I'm not gonna cover all of that here.
-->

---
layout: center
class: px-55 text-blue-500 font-weight-500 text-center
---

## [github.com/Betterment/webvalve](https://github.com/Betterment/webvalve)

![webvalve readme](/images/webvalve-readme.png)

<!--
So if you're interested, you can find that **and more** on GitHub

But what I will cover is how we got all of this working in our demo environment
-->

---
layout: two-cols
class: text-center px-10
---

# Before

<img src="/images/app-cluster.png" class="pr-10 pt-3"/>

::right::

# After

<v-click>

<img src="/images/app-cluster-after.png" class="pr-10 pt-3"/>

</v-click>

<!--
And, so, firstly,

CLICK

it did allow us to actually deploy just a single app, basically for free.

Because it relied on all of the fake services that our teams had _already_ written.
-->

---
layout: center
class: px-40 bg-blue-100
---

![summary page](/images/summary-page.png)

<!--
And so, right off the bat, this was great!

But remember that we were stubbing out all collaborating services. Like, basically all outside HTTP requests.

So. I showed it one of my colleagues who commonly gave client demos, and he clicked
around, and he liked what he was seeing.

But then he encountered...
-->

---
layout: center
class: px-20 bg-blue-100
---

![performance page (no graphs)](/images/performance/page-empty-graphs.png)

<!--
...this page, which is supposed to graph he performance history of an account.

And he said, hold on, I can't show this to a client.
-->

---
layout: center
class: px-20 bg-blue-100
---

![empty returns graph](/images/performance/returns-empty.png)

<!--
And I was like, well we don't actually have any performance history, because
this is just a demo app, and the history comes from a different backend
service, and blah blah blah, developer talk.

And he said, doesn't matter. If a client has to ask why something looks broken,
then the demo is already off track.
-->

---
layout: center
class: px-40
---

![peanuts gif](/images/charlie-brown.gif)


<div style="position:absolute;right:10px;bottom:10px;color: #ddd" class="text-xs">
Arrested Development (TV Series 2003-2019)
</div>

<!--
So I walked away from that meeting feeling a little bummed, because he was
right, and I knew I was just making excuses for technical shortcomings.

And, so I started to wonder if this whole WebValve idea was even the right approach.
-->

---



<div grid="~ cols-2 gap-5" m="-t-2"><div>

```ruby
class FakeBalanceService < WebValve::FakeService
  get '/api/daily_returns' do
    json([
      {
        date: Date.yesterday.to_s(:iso8601),
        balance_cents: 1_000_00,
        starting_balance_cents: 1_000_00,
        market_change_amount_cents: 0,
        dividend_amount_cents: 0,
        fees_cents: 0
      }
    ])
  end
end
```

</div>
<div><div class="bg-blue-100 px-5 pt-2 pb-2 absolute top-0 bottom-0">

![empty graph](/images/performance/returns-empty.png)

</div></div></div>


<!--
But I thought about it more. Because, like, most of the application worked
as intended. It was just some of these external service boundaries that didn't
make for a good demo.

And so, I thought, why not, just, make the fake service a little more fake.
-->

---


<div grid="~ cols-2 gap-5" m="-t-2"><div>

```ruby {all|7|8|9|10|11|all}
class FakeBalanceService < WebValve::FakeService
  get '/api/daily_returns' do
    date_range = dates(params[:from], params[:to])
    balance = Money.new(1_000_00)
    json(date_range.map.with_index do |date, idx|
      starting_balance = balance
      buys = deposit?(date) ? random_buy : 0
      sells = withdraw?(date) ? random_sell : 0
      mkt_changes = balance * random_market_change
      divs = dividend?(date) ? balance * 0.01 : 0
      fees = fee?(date) ? balance * 0.0025 : 0
      balance += buys - sells + mkt_changes + divs - fees
      {
        date: date.to_s(:iso8601),
        balance_cents: balance.cents,
        starting_balance_cents: starting_balance.cents,
        market_change_amount_cents: mkt_changes.cents,
        dividend_amount_cents: divs.cents,
        fees_cents: fees.cents,
      }
    end)
  end
end
```

</div>
<div><div class="bg-blue-100 px-5 pt-2 pb-2 absolute top-0 bottom-0" v-click-hide>

![empty graph](/images/performance/returns-empty.png)

</div>

<div class="bg-blue-100 px-5 pt-2 pb-2 absolute top-0 bottom-0" v-after>

![graph](/images/performance/returns.png)

</div></div></div>



<!--
And so, I wrote a fake stock market simulation.
With buys, and sells, and market changes, and dividends, and fees.

CLICK

And of course, none of this is actually based in any kind of reality.
Like, this is a terrible simulation.
But it resulted in

CLICK

this graph.

Again, is this real? No, absolutely not. But is it demoable? Maybe.
-->

---
layout: center
class: px-20 bg-blue-100
---

![performance page (with graphs)](/images/performance/page-graphs.png)

<!--
So I went back to my colleague, and he said, yeah, sure, looks fine, and, so at
that point I decided, okay, we can probably run with this.

And we did. And there were only like one or two other places where we had to fill in the gaps like this.

But there was one more issue.
-->

---
layout: center
class: px-20
---

![dory](/images/dory.gif)

<div style="position:absolute;right:10px;bottom:10px;color: #ddd" class="text-xs">
Finding Nemo (2003)
</div>


<!--
These fake services had no ability to remember anything.

And by that I mean, if you performed an action...
-->

---
layout: center
class: px-50
---

![webvalve nonstateful fake](/images/webvalve-nonstateful-fake.png)

<!--
Like make a deposit, which resulted in an external POST request.
The next time you fetched your balance, via an external GET request.
It would show your previous balance.

So again, that was gonna break the immersion.
-->

---
layout: cover
background: /images/demo_mode_fancy.jpg
class: text-center
---

# **"Stateful" Fakes**

<!--
And this is where we came up with the idea of stateful fakes
-->

---
layout: center
---

```ruby {all|2-5|6-11|13-22|19}
class FakeBalanceService < WebValve::FakeService
  class FakeAccount < ActiveRecord::Base
    money :balance
  end

  get '/api/balance' do
    fake_account = FakeAccount
      .find_by(account_id: params[:account_id])

    json balance_cents: fake_account&.balance.cents || 0
  end

  post '/api/deposit' do
    fake_account = FakeAccount
      .where(account_id: params[:account_id)
      .first_or_create!(balance_cents: 0)

    deposit = params[:amount_cents].to_money
    fake_account.update!(balance: fake_account.balance + deposit)

    json balance_cents: fake_account.balance.cents
  end
end
```

<style>
pre {
font-size: 95% !important;
line-height: 140% !important;
}
</style>




<!--
A stateful fake is a WebValve fake, that can remember things.

CLICK

It gets its own database tables and ActiveRecord models.

CLICK

And it can read from those tables during GET requests

CLICK

And during POST requests

CLICK

It can actually UPDATE those tables during POST/PUT/PATCH/DELETE/etc
-->

---
layout: center
class: px-50
---

![webvalve stateful fake](/images/webvalve-stateful-fake.png)

<!--
And so now it can remember things!

You could deposit 123 dollars and then actually see it reflected in your balance.
-->

---
layout: center
class: text-center
---

# RAILS_ENV=**demo**

<img src="/images/app-cluster-after-small.png" class="px-85 mt-10" />

<!--
And so we'd done it. We could run our app in total isolation from all external apps and services.

And, so, quickly, to recap:

We enabled WebValve. We made the fake services real _enough_ to support a useful demo. And we gave fakes the ability to remember things.
-->

---
layout: image
image: /images/iceberg.jpg
class: text-center
---

<div class="mt-50 text-shadow-lg" v-click>

<h1 style="font-size:250%"><b>An app should (mostly) work in isolation</b></h1>

</div>

<!--
And all of this brings us to the next layer of the demoability iceberg, which is that...

CLICK

An app should mostly work in isolation. Like, it might need some extra massaging at the system boundaries, but it should mostly make sense on its own.
-->

---
layout: image
image: /images/notebook.jpg
class: font-mono pl-40 text-3xl pt-10
---

<style>
li { list-style-type: none; }
li + li {
  margin-top: 1em;
}
</style>

<div class="text-gray-800">

- Consisted of ~~**multiple apps/services**~~
- Populated with **seed/fixture data**
- Relied on **short-lived databases**
- Deployed via **push-button (and 🤞)**
- Owned by **one team**

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

<v-clicks>

- <span class="pl-60">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>

</v-clicks>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
And so, again, instead of deploying an entire cluster of apps, we could...

CLICK

deploy just one app. With some stateful fakes.

So next we focused our attention on the way we populate the demo data and accounts.
-->

---
layout: image
image: /images/notebook.jpg
class: font-mono pl-40 text-3xl pt-10
---

<style>
li { list-style-type: none; }
li + li {
  margin-top: 1em;
}
</style>

<div class="text-gray-800">

- Consisted of ~~**multiple apps/services**~~
- Populated with ~~**seed/fixture data**~~
- Relied on **short-lived databases**
- Deployed via **push-button (and 🤞)**
- Owned by **one team**

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
And so we crossed out that one too. Because, why not, it worked with the first
one!

But wait, if we don't use seeds or fixture data -- like, if we don't populate
the user accounts ahead of time -- then what do we do?
-->

---
layout: center
class: px-80
---

![login form](/images/log_in.png)

<!--
Like, how else are you going to login?

You'll be faced with this form, and you'll need to enter something, right?

Well the more we thought about this, the more we realized how awkward this must be for our client-facing teams.
-->

---
layout: image
image: /images/sticky-note.jpg
class: bg-contain
style: 'background-size: contain'
---

# &nbsp;

<!--
Did they, like, keep the list of demo logins on a sticky note? 

How did they know that someone else wasn't already using one of the demo accounts?
-->

---
layout: center
class: px-80
---

![login form](/images/log_in.png)

<!--
And so, if it's so awkward, why are we using this login form at all? 

And that was our "ah ha" moment.
-->


---
layout: center
---

![personas whiteboard](/images/personas-whiteboard.png)


<!--
So we sketched out something totally different on a whiteboard.

A page where you are presented with, like, 3 different users, each with a sign in button.

And we thought to ourselves, well what if...
-->

---
layout: center
---

![personas whiteboard](/images/personas-whiteboard-button.png)


<!--
...when you click sign in, instead of logging in as a _specific_ user account, it spins out a background job and generates a NEW user for you on the fly.
-->


---
layout: center
---

![personas process](/images/personas-process.png)

<!--

So you'd see a brief loading spinner, and then you'd be dropped straight into a totally fresh account summary page.

This felt way less awkward than the login page and sticky notes approach.

We just needed to figure out how to dynamically create user accounts on the fly.
-->

---
layout: image
image: /images/dev-laptop.jpg
---

<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@cgower?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Christopher Gower</a> on <a href="https://unsplash.com/s/photos/laptop-office?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
And again, when we looked to our local development environments we saw that we already had
a way of doing this.
-->

---
layout: center
class: px-40
---

![factory_bot logo](/images/factory_bot.png)


<!--
Factories! So we use a tool called FactoryBot.by our friends at ThoughtBot.
-->

---
layout: center
---

```ruby
FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    sequence(:email) { |i| "user_#{i}@example.org" }
  end
end
```

<style>
pre {
font-size: 120% !important;
line-height: 120% !important;
}
</style>



<!--
FactoryBot lets you define Factories.

Like this user factory, which describes how to generate a user.
-->

---
layout: center
---

```ruby
user_1 = FactoryBot.create(:user)
user_2 = FactoryBot.create(:user)
user_3 = FactoryBot.create(:user)
```

<style>
pre {
font-size: 150% !important;
line-height: 120% !important;
}
</style>



<!--
And then you can use that factory to generate as many users as you want.
-->

---
layout: center
---

![personas process](/images/personas-process-withfb.png)


<!--
And so we could easily wire this up to our sign in button.
-->

---
layout: center
---

```ruby {7-11}
FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    sequence(:email) { |i| "user_#{i}@example.org" }

    trait :with_roth_401k do
      after(:create) do |user, _|
        Factorybot.create(:account, :roth_401k, user: user)
      end
    end
  end
end
```

<style>
pre {
font-size: 120% !important;
line-height: 120% !important;
}
</style>


<!--
Plus, you you can define things like traits, like a user with a Roth 401k account.
-->

---
layout: center
---

```ruby
FactoryBot.create(:user, :with_roth_401k)
```

<style>
pre {
font-size: 150% !important;
line-height: 120% !important;
}
</style>


<!--
And then you just apply those traits at creation time.
And so this was actually perfect.
-->

---
layout: center
---

![personas process](/images/personas-process-expanded.png)

<div v-click-hide class="bg-white absolute bottom-0 left-0 right-0 top-70"></div>


<!--
Because each persona could get its own factory definition. And by just changing up the traits

CLICK

We could change up the actual account dashboard that you drop into.
-->

---
layout: center
---

```ruby {all|6}
DemoMode.add_persona :nathans_test_persona do
  features << 'Retirement Goal'
  features << 'Roth 401(k)'

  sign_in_as do |_password|
    FactoryBot.create(:user, :with_roth_401k)
  end
end
```

<style>
pre {
font-size: 120% !important;
line-height: 120% !important;
}
</style>


<!--
So to support this, we came up with a quick little DSL for defining these personas.

All you had to do was drop your factory bot code in here, 

CLICK

and it would take care of there rest.

And, so, we took these persona definitions, and we built...
-->

---
layout: center
---

<video muted>
  <source src="/images/personas-login.mov" />
</video>


<!--
This user interface.

And so we had our persona picker. And we made this replace the login page entirely.
-->

---
layout: center
---

<video muted autoplay>
  <source src="/images/personas-login.mov" />
</video>

<!--
And it worked!

CLICK

There's the loading spinner, and that should take us to the dashboard.

But there was one hiccup. When we deployed a change, suddenly...
-->

---
layout: image
image: /images/500-error.png
---

# &nbsp;

<!--
...it broke. Darn. This was definitely giving us flashbacks. But we dug in...
-->

---
layout: center
---


<v-clicks>

### <span class="text-blue-500">deployment 1:</span>

✅ <strong>user_1</strong>@example.org

✅ <strong>user_2</strong>@example.org

✅ <strong>user_3</strong>@example.org

### <span class="text-blue-500">deployment 2:</span>

<p>❌ <strong>user_1</strong>@example.org</p>

</v-clicks>

<arrow x1="350" y1="150" x2="350" y2="400" color="#aaa" width="3" />

<!--
And here's what was happening.

CLICK

After the initial deployment, we could generate user 1, user 2, user 3, and so on, and they'd work just fine.
But when we redeploy, the next user we generate would reset back to user_1.

And this would fail against uniqueness constraints in our database, or uniqueness validations in the models,
because user_1's email was already taken.
-->

---
layout: center
---

```ruby {5}
FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    sequence(:email) { |i| "user_#{i}@example.org" }
  end
end
```


<style>
pre {
font-size: 120% !important;
line-height: 120% !important;
}
</style>

<!--
And if you look back at the way factories are defined,
you see that we rely on this sequence feature to generate unique emails for us.

And this time the problem is that...
-->

---
layout: center
class: px-20
---

![dory](/images/dory.gif)

<div style="position:absolute;right:10px;bottom:10px;color: #ddd" class="text-xs">
Finding Nemo (2003)
</div>

<!--
It has no LONG term memory

The sequences reset every time the Ruby process restarts.

So, apologies to our friends at ThoughtBot, but...
-->

---
layout: center
---

```ruby
module FactoryBot
  class DefinitionProxy
    def sequence(name, &block)
      add_attribute(name) do
        find_next_in_sequence(@instance&.class, name, &block)
      end
    end

    def find_next_in_sequence(klass, name, &block)
      # ???
    end
  end
end
```


<style>
pre {
font-size: 120% !important;
line-height: 120% !important;
}
</style>


<!--
we decided to patch FactoryBot

So that it could actually look up the next value in the sequence by checking the database.
-->

---
layout: center
---

```ruby {10}
module FactoryBot
  class DefinitionProxy
    def sequence(name, &block)
      add_attribute(name) do
        find_next_in_sequence(@instance&.class, name, &block)
      end
    end

    def find_next_in_sequence(klass, name, &block)
      klass.select("MAX(#{name})") + 1
    end
  end
end
```


<style>
pre {
font-size: 120% !important;
line-height: 120% !important;
}
</style>

<!--
First, we said, let's just take the MAX value in the table - like SELECT MAX - and add 1.

And if it's an integer, or a string with a standard lexographic order, it kinda works? But not really.
-->

---
layout: center
---

```ruby
sequence(:short_id) { |i| 10000009 - i }
```

<v-clicks>

<p class="ml-50 pl-10 pb-5 relative font-mono">
  1000000<strong>9</strong><br/>
  1000000<strong>8</strong><br/>
  1000000<strong>7</strong><br/>
  ...
  <arrow x1="20" y1="0" x2="20" y2="100" color="#aaa" width="3" />
</p>


```ruby
sequence(:ssn) { |i| i.to_s.rjust(9, '0') }
```

<p class="ml-15 pl-10 relative font-mono">
  decrypt(<strong>"342lk9s..."</strong>) => 000-00-0000<br/>
  decrypt(<strong>"jf9893d..."</strong>) => 000-00-0001<br/>
  decrypt(<strong>"j52c5ag..."</strong>) => 000-00-0002<br/>
  ...
  <arrow x1="20" y1="0" x2="20" y2="100" color="#aaa" width="3" />
</p>

</v-clicks>

<style>
pre {
font-size: 120% !important;
line-height: 120% !important;
}
</style>



<!--
Like, here's a sequence that goes in...

CLICK

descending order.

CLICK

And here's a sequence where the attribute is actually...

CLICK

ENCRYPTED at rest.

There's just no way with SQL to select for the MAX value in these columns.

There are a few ways to solve for this, and I'd say that we went with the best worst option. Which is...
-->

---
layout: center
class: text-center pt-10
---

![clever sequence](/images/clever-sequence.png)

<v-click>

<p class="text-5xl pt-10"><strong>O(log n)</strong></p>

</v-click>

<!--
...to use an exponential search function to search the space of possible values, and find the next gap in the sequence.

And this was a little slow, but

CLICK

not that slow,

and we only had to do it once. Because once you find the starting value, the sequence can just keep going from there.
-->

---
layout: center
---

```ruby {10}
module FactoryBot
  class DefinitionProxy
    def sequence(name, &block)
      add_attribute(name) do
        find_next_in_sequence(@instance&.class, name, &block)
      end
    end

    def find_next_in_sequence(klass, name, &block)
      block.call CleverSequence.lookup(klass, name).next
    end
  end
end
```


<style>
pre {
font-size: 120% !important;
line-height: 120% !important;
}
</style>

<!--
And of course, we called it clever sequence (because clever code isn't necessarily good code)

But it helped us get to a demoable state, and that's what mattered.
-->

---
layout: image
image: /images/sales-pitch.jpg
class: text-center
---

<video muted autoplay width=390 class="absolute left-67 top-40">
  <source src="/images/personas-login.mov" />
</video>

<div v-click style="position:absolute;bottom:40px;left:0;right:0" class="text-3xl">
  <strong>(this is definitely a real demo)</strong>
</div>

<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@xteemu?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Teemu Paananen</a> on <a href="https://unsplash.com/s/photos/pitch?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
And so now it worked for real. And we could actually use it to start giving real demos.

CLICK
-->

---
layout: image
image: /images/iceberg.jpg
class: text-center
---

<div class="mt-50 text-shadow-lg" v-click>

<h1 style="font-size:250%"><b>The UX should inform everything else</b></h1>

</div>

<!--
And so we have another iceberg reveal. This time, the take-away was that...

CLICK

We needed to start with the user experience and work backwards.
-->

---
layout: image
image: /images/notebook.jpg
class: font-mono pl-40 text-3xl pt-10
---

<style>
li { list-style-type: none; }
li + li {
  margin-top: 1em;
}
</style>

<div class="text-gray-800">

- Consisted of ~~**multiple apps/services**~~
- Populated with ~~**seed/fixture data**~~
- Relied on **short-lived databases**
- Deployed via **push-button (and 🤞)**
- Owned by **one team**

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>
- <span v-click class="pl-70">↱ **personas** <span class="text-xl">(+ factories)</span></span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
So cross another one off the list. Instead of fixtures and seeds, we had...

CLICK

the new personas framework powered by factories.

And we could've stopped there, but we're not done crossing out this list!

So let's look at this short-lived database idea. And this one is really easy.
-->

---
layout: center
class: px-80
---

![short-lived db](/images/short-lived-db.png)


<!--
So, if you recall, we had this process that would basically destroy and recreate the database every so often.

But the only reason we needed to do this was because we had previously relied on pre-populated demo accounts,
and we wanted to reset them.

But we had personas now!
-->

---
layout: center
class: px-80
---

![long-lived db](/images/long-lived-db.png)


<!--
So if we just... didn't reset the database ever, and kept it around indefinitely,
all of the demo functionality would still work as intended.
-->

---
layout: center
class: px-30 pb-25
---

![db:migrate](/images/db-migrate.png)

<!--
And we'd just rely on schema migrations, the same way we do in production.
-->

---
layout: image
image: /images/notebook.jpg
class: font-mono pl-40 text-3xl pt-10
---

<style>
li { list-style-type: none; }
li + li {
  margin-top: 1em;
}
</style>

<div class="text-gray-800">

- Consisted of ~~**multiple apps/services**~~
- Populated with ~~**seed/fixture data**~~
- Relied on ~~**short-lived databases**~~
- Deployed via **push-button (and 🤞)**
- Owned by **one team**

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>
- <span class="pl-70">↱ **personas** <span class="text-xl">(+ factories)</span></span>
- <span v-click class="pl-45">↱ a **long-lived database**</span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
So cross that out, and replace short-lived databases with

CLICK

a long lived database.

So next up, was the cadence of deployments
-->

---
layout: center
class: px-50 mr-20
---

![pain graph](/images/pain-graph.png)


<!--
And if you remember, I said that the longer the cadence, the more painful it got.

And there's a simple reason for this.

It's because whenever something goes wrong, the way to debug it is to look into every change
that has happened since the last deploy.

-->

---
layout: two-cols
---

![git log with lots of changes](/images/git-push-button.png)

::right::

<v-click>

![git log with very few changes](/images/git-continuous.png)

</v-click>

<style>
img { width: 65% }
</style>

<!--
So if you haven't deployed in 3 months, you have to **sift** through 3 months of changes to figure out what broke.
So, I'm sure you can see where I'm going with this.

CLICK

If you deploy all the time, then when something goes wrong, you just have 1 or 2 things that might've caused it!

And so if it sounds like I'm making the case for continuous integration and continuous deployment, it's because...
-->

---
layout: center
---

![ci-cd diagram](/images/ci-cd.png)

<!--
...I am!

This is how we build our production apps, so it made sense to just do the same thing for demo.


Of course, with continuous deploys, you need to actually operate and monitor as well, so that you actually know when something breaks.
-->

---
layout: two-cols
class: text-center px-10 pt-25
---

![slack](/images/slack.png)

::right::

<v-click>

![sentry](/images/sentry.png)

</v-click>

<!--
So we enabled slack alerts, and 

CLICK

we made sure errors would show up in our bugtracker.

And both of these can feed into our teams' on call processes.
-->

---
layout: center
---

![ci-cd diagram](/images/ci-cd.png)

<!--
And then the last bit that was missing was there on the lower left... testing.
-->

---

<div grid="~ cols-2 gap-5" m="t-10"><div>

```ruby {all|1-3|6-8|all}
before do
  with_env('DEMO_MODE', 'true')
end

scenario 'visitor selects the "finley" persona' do
  demo_session_new_page.finley.sign_in.click
  expect(demo_loading_page).to be_loaded
  work_off_jobs!

  expect(summary_page).to be_loaded
  expect(summary_page).to have_goal_cards(count: 1)
  summary_page.goal_cards[0].tap do |goal|
    expect(goal.type).to have_content('Retirement')
    expect(goal).to have_content('$16,245.94')
  end
  summary_page.performance_tab.click

  expect(performance_page).to be_loaded
end
```

</div>
<div><div class="bg-white px-5 pt-35 pb-2 absolute top-0 bottom-0" v-click-hide=4 v-click=3>

![empty graph](/images/build-fail.png)

</div>

<div class="bg-white px-5 pt-35 pb-2 absolute top-0 bottom-0" v-after>

![graph](/images/build-pass.png)

</div></div></div>

<!--
And so we wrote tests and stuck them in our standard test suite!

CLICK

We actually made it possible to toggle the personas mode on and off using an environment variable.

CLICK

And then the test itself would click through an actual product demo, starting with the personas page.

CLICK

And so now if a test failed, a developer would see a red PR build, and know that they broke an actual customer demo or sales pitch.

CLICK

And they can't merge until they make it green.
-->

---
layout: center
---

![ci-cd diagram](/images/ci-cd.png)

<!--
And with that, we were running the whole CI/CD infinity loop with our demo application.
-->


---
layout: image
image: /images/notebook.jpg
class: font-mono pl-40 text-3xl pt-10
---

<style>
li { list-style-type: none; }
li + li {
  margin-top: 1em;
}
</style>

<div class="text-gray-800">

- Consisted of ~~**multiple apps/services**~~
- Populated with ~~**seed/fixture data**~~
- Relied on ~~**short-lived databases**~~
- Deployed ~~via **push-button (and 🤞)**~~
- Owned by **one team**

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>
- <span class="pl-70">↱ **personas** <span class="text-xl">(+ factories)</span></span>
- <span class="pl-45">↱ a **long-lived database**</span>
- <span v-click class="pl-40">↱ **continuously**</span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>


<!--
And so instead of push-button deploys...

CLICK

We were deploying continuously, and really benefiting from it, just like in our production environment.

And so what's left here is that last line.
-->

---
layout: image
image: /images/notebook.jpg
class: font-mono pl-40 text-3xl pt-10
---

<style>
li { list-style-type: none; }
li + li {
  margin-top: 1em;
}
</style>

<div class="text-gray-800">

- Consisted of ~~**multiple apps/services**~~
- Populated with ~~**seed/fixture data**~~
- Relied on ~~**short-lived databases**~~
- Deployed ~~via **push-button (and 🤞)**~~
- ~~Owned by **one team**~~

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>
- <span class="pl-70">↱ **personas** <span class="text-xl">(+ factories)</span></span>
- <span class="pl-45">↱ a **long-lived database**</span>
- <span class="pl-40">↱ **continuously**</span>
- <span v-click>↱ Maintained by **everyone**</span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--

And I think we can cross this out, without any more slides, because we can just look at the things we've done above.

So for one, we're using these stateful fakes, which teams already write when developing and testing apps locally.

And for the demo personas, we're using factories, which again, teams already produce when writing their tests.

Then we have this long-lived database, that depends just on migrations, that teams already write when building features.

And we're following a CI/CD process that routes any build failures or issues through to the team closest to the change being made.


And so after all of this, who owns this thing is immaterial, because the real question is who maintains it.

And it's effectively...

CLICK

maintained by everyone!

And, uh, this has gotten kinda messy at this point, so let's just rewrite the list.
-->

---
layout: image
image: /images/notebook.jpg
class: font-mono pl-40 text-3xl pt-10
---

<style>
li { list-style-type: none; }
li + li {
  margin-top: 1em;
}
</style>

<div class="text-gray-800">

- Consisted of <span class="text-blue-800">**one app**</span>
- Populated with <span class="text-blue-800">**personas**</span>
- Relied on a <span class="text-blue-800">**long-lived database**</span>
- Deployed <span class="text-blue-800">**continuously**</span>
- <strong>Maintained</strong> by <span class="text-blue-800">**everyone**</span>

</div>

<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
There we go. So this was the Demo environment 2.0.

An isolated app, centered around personas, utilizing a long-lived database, and deployed continuously.

And, as a result of all of the tools we use in our day-to-day work, was maintained by everyone.
-->

---
layout: image
image: /images/2020.svg
---

# &nbsp;

<!--
So we shipped this in 2020, and as we all know it has been at least 6 years since then. Or I dunno, I stopped counting.
-->

---


<div grid="~ cols-3 gap-5" m="t-2">
<div>

<img src="/images/persona-picker.png" class="mb-10 mt-30" />
<img src="/images/betterment.png" class="px-10 pt-1" />

</div><div>

<img src="/images/persona-picker-b4b.png" class="mb-5 mt-31" />
<img src="/images/b4b.png" class="px-10" />

</div><div>

<img src="/images/persona-picker-b4a.png" class="mb-9 mt-31" />
<img src="/images/b4a.png" class="px-10" />

</div>
</div>

<!--
And since then we launched versions of it for 3 of our consumer facing products.
So each of these is a different Rails app with its own set of stateful fakes and personas.
-->

---
layout: center
---

<video muted autoplay loop>
  <source src="/images/personas-ecosystem.mov" />
</video>

<!--
We also launched a version of this for internal testing purposes, teams have added like a zillion test personas.

So any Betterment employee has access to this and can test run the app with any persona.
-->

---
layout: center
---

<div style="width: 882px; height: 61px; background-image:url(/images/personas-cli.gif); margin-bottom: -1px" />
<div style="width: 882px; height: 319px; background-image:url(/images/personas-cli.gif); background-position: bottom; margin-top: -1px" />

<!--
And we paired this with a developer CLI so that devs can generate personas in their local development environments.

In fact, this ended up replacing user seeds entirely, which cut down a bunch on the time it takes to run rake db:setup.
-->

---
layout: center
---

<video muted autoplay loop width=222 height=480 style="width:222px;height:480px;">
  <source src="/images/personas-mobile.mov" />
</video>

<img src="/images/iphone-front.png" class="absolute top-6" style="left:365px; width:251px;" />

<!--
We also connected a test build of our mobile app to a Rails API backed by the same set of personas.
-->

---
layout: image
image: /images/demo-mode-usage.svg
---

# &nbsp;

<!--
And most importantly, the internal usage of these apps has only gone up over time.

And that leads us to...
-->

---

# iceberg: incentives matter

<!-- 
Our final observation, which is that... like, incentives matter. And human incentives have a much greater long term impact than any technology choices you might make.
-->

---

# teams in friction

<!--
Thinking back, to a few years ago, what we had were three misaligned teams.

We had the teams building Betterment's consumer-facing product, focused on their own roadmaps and goals.

Then, we had a B2B engineering team trying to stand up a demo environment for that consumer-facing product.

And then a non-engineering team who desperately needed that demo environment, but couldn't trust that it would work.
-->

---

# teams in harmony

<!--
And what we managed to do was align these incentives. And secretly, that's what this talk has actually been about.

Tools like webvalve and factory bot were just implementation details.


-->

---
layout: image
image: /images/iceberg.jpg
---

<div class="ml-50 mt-30 text-3xl text-shadow-lg font-bold">

<v-clicks>

1. Maintenance cost > up-front cost
2. An app should make sense in isolation
3. Start with the UX and work backwards
4. The demo env _is_ a production env
5. Incentives matter more than tech

</v-clicks>

</div>

<!--
Recap of the demoability iceberg.

I'm gonna add just one more thing...

CLICK

And it's that incentives matter more than technical solutions.
-->
