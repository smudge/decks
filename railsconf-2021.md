class: middle

<h1 style="margin-bottom:0;font-size:80px;">Predicting the Improbable:</h1>
<h1 style="margin-top:0;">Writing resilient "save" methods</h1>

<h3 style="margin-bottom:0;">Nathan Griffith</h3>
<h4 style="margin-top:0;">https://ngriffith.com<br/>@smudge on GitHub<br/>@smudgethefirst on Twitter</h4>

???

- Hi, I'm Nathan.
- I work at a company called Betterment.
- We do a lot of things these days, managing investments, giving retirement advice, benefits programs like 401ks, you name it.
- But our number one product, the one that drew me to Betterment in the first place, is the financial peace of mind we give to our customers.

---
class: center, middle
class: center, middle

# 💸

???

- Now, if you work in finance, or health care, or, I dunno, maybe auto manufacturing, you might know what it's like to work in a highly regulated industry.
- Since joining Betterment, I've been on a quest to help us achieve operational peace of mind.
- We need to be able to trust that our systems will do what we expect, or, at the very least, will fail in a way that we can predict and recover from.
- Because if we get that wrong, well, I mean, so much of what we do involves real money. Failing to predict an errant behavior might have a real dollar value attached.
- And so that's what this talk is about: persistence operations.
- Or, as I like to call them, "save" methods.

---
class: center, middle

# Writing resilient .red.bold["save" methods]

???

"But I already have a save method."

I mean anything that does meaningful persistence work internally.

Maybe that means a controller action. Maybe you're using model callbacks. Doesn't matter. It saves stuff. It's a "save" method.

---
class: center, middle

# Writing .red.bold[resilient] "save" methods

???

The ability to recover to a stable, functioning state when something goes wrong. To fail... successfully, and then resume.

---
class: center, middle

# Writing ~~robust~~ .red.bold[resilient] "save" methods

???

What I don't mean is "robust" -- a robust system can absorb failures and keep chugging along for as long as it can, until it doesn't and fails catastrophically.

That's not what I want to talk about today, I'm talking about making our persistence operations resilient to common types of errors.

---

# Why aren't all "save" methods resilient?

???

I write a method. It checks a couple things, it inserts one model and updates another, and then it fires off an email.
I ship it, it works in production for months, maybe years, but suddenly it breaks? Why?

---

# Murphy's Law

[interstellar gif]

???

I'm not actually a fan of using Murphy's Law as an _explanation_.
I especially don't think it makes sense to cite this when reviewing someone's code.
What do you say? "I've identified something that is extremely unlikely to break, but Murphy's Law tells me it will break, therefore you need to fix it?"
Not a very compelling argument.

So if murphy's law is fake statistics, maybe there's something in the study of _real_ statistics that can explain these probabilistic puzzlers.

---
class: center, middle

# Improbable things happen _all the time_

???

The Improbability Principle
- David J. Hand

How Not To Be Wrong
- Jordan Ellenberg

Two books that came out in 2014.

---

# Law of Truly Large Numbers

???

- With enough traffic, unlikely outcomes are bound to happen.


# Law of the Probability Lever

???

The probabilities of things happening are not unrelated.
Something that seems very unlikely might become very likely given the right conditions.
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

Our entire careers, we've been writing variations of the same save operation. It _always_ (or almost always) fits in this structure.
