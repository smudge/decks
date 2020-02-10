
#### Nathan Griffith
[github.com/smudge](https://github.com/smudge)

---

Improbable Events Become Probable

??? 

At a certain scale, given a high enough request volume and enough time, unlikely failures start to happen.
And they start to happen a lot.

Failure that has a 1/1,000,000 chance of happening -- but in an endpoint that receives 10,000 requests per day.
Extrapolate - web traffic spread out across 100's or 1000's of controller endpoints.
Sure, you may identify and fix the most common culprits - power law of controller usage -
but the long tail will still result in your teams playing whack-a-mole with one-off errors

Lastly, _when_ a failure happens -- db connections dropped, wrong time zone deployed, service times out, double-submit --
these are the types of issues that immediately happen. And they are reproducible!

---



---

How Can I Break This?

---

To Understand the Problem,
Reduce the Problem

???

What does that mean in the case of Rails controllers?
I'm going to outline one strategy for taking a complex controller action and reducing it to something far simpler.
This isn't the only way to approach the problem.
What's important is finding something that can be applied consistently.

---

```ruby
class UsersController < ApplicationController

  def update
    @user = User.find(params[:id])
    if @user.update(params.permit(:user))
      # redirect_to 'dashboard'
    else
      # render 'edit'
    end
  end
end
```

---


---

High-Value Actions Have Side Effects

---

Safety Guarantees Can Be Cheap

???

This answers the question "is it worth it?" -- maybe the data isn't *that* important,
or maybe actions like emails don't *need* to succeed. (Look at the bounce rate!)
But if it's cheap, why not? To prevent the slowly-compounding growth of on call issues,
you have to apply cheap solutions broadly.

---

Listen to the Product

???

Who is the audience?
What actions are most important?
Do we need immediate feedback?
Is it okay to display intermediate states? ("in progress", loading spinners)

---
