class: middle

<h1 style="margin-bottom:0;font-size:80px;">Predicting the Improbable:</h1>
<h1 style="margin-top:0;">Writing resilient "save" methods</h1>

<h3 style="margin-bottom:0;">Nathan Griffith</h3>
<h4 style="margin-top:0;">https://ngriffith.com<br/>@smudge on GitHub<br/>@smudgethefirst on Twitter</h4>

???

- Hi, I'm Nathan.
- I work at a company called Betterment.
- We focus on helping people achieve financial peace of mind by being a smart money manager and investing planner.

---
class: center, middle
class: center, middle

# 💸

???

- Because I work in a regulated industry, I've paid careful attention to some of the guarantees we can make when writing code, to achieve operational peace of mind.
- And I've found that being able to trust our persistence operations, our "save" methods, is one of the most important guarantees.
- And so that's what this talk is about: Writing resilient "save" methods.

---
class: center, middle

# Writing resilient .red.bold["save" methods]

???

"But I already have a save method."

I mean anything that does meaningful persistence work internally.

Maybe that means a controller action. Maybe you're using model callbacks.

At Betterment, we use a kind of Service Object. We call them "Resource Models"

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
class: center, middle

# Improbable Things Happen All The Time

???

We are expecting a thunderstorm.

Lightning will strike your home tonight. (1/1M odds)
Lightning will strike _a_ home in your city tonight. (relative certainty)


