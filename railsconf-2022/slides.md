---
theme: default
colorSchema: light
title: RAILS_ENV=demo
info: For RailsConf 2022
download: true
highlighter: shiki
lineNumbers: false
background: /images/demo_mode_fancy.jpg
class: text-center
---

# **RAILS_ENV=demo**

### diving into the "demo" environment

<!--
LOCAL SERVER+JOBS!

Okay, so let's get started.

Hello. Welcome to my talk. I'm glad to be here. A little nervous, too.

This is actually my first live conference talk.

I gave one last year, but it was prerecorded, so I spent like a week recording takes over and over trying to get the perfect take. Would definitely not recommend that strategy, so I'm happy to do it live with you today.
-->

---
layout: section
---

# RAILS_ENV=demo

<!--
So you might be here because you saw the title of this talk

RAILS_ENV=demo

and something about it intrigued you.

Or maybe you just picked a room at random. I don't actually know why you're here. But either way, let's just unpack this title.
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
Or if you're deploying to production, hopefully you're using the _production_ environment.
-->

---
layout: fact
---

## **RAILS_ENV=<ins>staging</ins>** bundle exec rails s

<!--
And, some companies actually have a staging environment...
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
So out of the box you get the big three: development, production, and test.
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
padding: 1em !important;
}
</style>

<!--
And of course these environments correspond to config files...
-->

---
layout: center
---

<div class="text-center mb-2 text-blue-500 text-3xl"><strong>config/environments/production.rb</strong></div>

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

<style>
pre {
font-size: 100% !important;
line-height: 140% !important;
padding: 1em !important;
}
</style>


<!--
And these config files have actual config **content** in them in them, like, what makes that environment unique.

And I mean, I'm talking to a room of Rails engineers, but I want to make sure we're on the same page, because...
-->

---
layout: fact
---

## RAILS_ENV={**demo**, development, production, test}

<!--
What I'm going to be talking about today is -- at its core -- the idea of adding a new, dedicated environment -- called "demo" -- for giving...

well, application demos.
-->

---
layout: image
image: /images/sales-pitch.jpg
---

<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@xteemu?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Teemu Paananen</a> on <a href="https://unsplash.com/s/photos/pitch?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
Like, the ability to step up in front of an audience, and show off a live version of your product. Reliably. And repeatably. And consistently.

Because the last thing you want is to get up there, and for something to go horribly wrong.
-->

---
layout: image
image: /images/showroom.jpg
---

<div style="position:absolute;right:10px;bottom:10px"  class="text-xs">
Photo by <a href="https://unsplash.com/@rahulbhogal?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Rahul Bhogal</a> on <a href="https://unsplash.com/s/photos/showroom?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
So think of this a little bit like the showroom floor... model of your app.
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
padding: 1em !important;
}
</style>

<!--
And I wish I could say it were as simple as just adding a new
demo.rb config file to your app, but that's just the... tip of the iceberg.
-->

---
layout: cover
background: /images/iceberg.jpg
class: text-center text-shadow-lg font-mono
---

# "Demoability"

<!--
Because "demoability" -- the ability to quickly take something
you've been building, and show it off to the world -- is about
a lot more than just the way you boot up your app.

It's actually something I and my team have been thinking
about and iterating on for almost six years. We've been exploring this iceberg of demoability!

And so who am I?
-->

---
layout: image-left
image: /images/me.jpg
---

<h1 class="pb-2 pt-30"><span class="text-5xl font-weight-600">Nathan Griffith</span></h1>

<svg style="width:40px;height:40px;float:left" version="1.1" viewBox="0.0 0.0 225.0 225.0" fill="none" stroke="none" stroke-linecap="square" stroke-miterlimit="10" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg">
<image xmlns="http://www.w3.org/2000/svg" clip-path="url(#gc745338790_0_14.2)" fill="#000" width="225.0" height="225.0" x="0.0" y="0.0" preserveAspectRatio="none" xlink:href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAADAFBMVEX///8bHyMAAAAYHCATGB0VGh4QFRoAAAoNExgABw8AAAYGDhQUGR0YHSEAChEAAAz09PR5eny2t7jJycqPkJH4+PigoaKXmJm8vb7R0dLX19iur7CkpaZbXV/d3t7HyMhhY2VFR0o7PkEtMDRvcXPn5+dTVVeHiIkmKS1xcnSTlJZJS040NzowMzZnaWuBg4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD25qzxAAASmElEQVR4Xu2djVubyPbHZwYIEFBjNGrUxtaaWrvt9v//M36/e/f2bmuttXW7barGmPfwcnmJCQwDHAiQ9Hn28zy7jScx8uXMnDkzcwCMcqey3jPLQ31rtD7Awp8InU5MuSPecFIfK502/enMwbQhSxpjc834NkJIIEQ3DGyUu7ZZ7ROTEM4wJtbrbfEWl67o38yQvBQ2uk86nxESTV1yVIVhKcXWKTjjv6g5ycxDYWMo3nclPNLpN8LhRHMoV0dSDiqzVljjRg+GYIqRjmOjjuQHhRf1Fv3GYmSqsKIo50geGrQdDpEG6KDHZSkyO4U1XbmWtAltTo6goUYnO5FZKawrF4jPQJ6LJXJD+kZb05GJwpoofiqNaOtilAev2l9pYxoyUNj8eS8YGm1dHJ5M3vQ/0NbELKxwn7uW+7QxK8qD1+1FB5AFFW6tf86u97EQxycPi3XIhRTWq+9IgmE9HYJ20v2LNiZgAYX76nn++mwErWGkb6upFTbNi3zbpxdxvGGmnYVwtAHI7tfhZIHcJSE6Ir1aj7bCSKfwqDvWC3OgwwQNToUUyW66VlrbuMDF+W8Gr2/c0TYAKXy41+1OTNpYAAYS8ME9bY0lsQ9rypWSqrVkATGPz2lbHEl9eHQznIxpY2GYSNN3E57fhD7cvF+eA12IWf1J2yJJ5MPmQXu0PAe6mGj4FA1pawRJfLj3o5xyTMoWQeZvaFs4CXx4+kVZCYHImAx24EcC9mFt83wZQ0QI+PX/06YwoD5sKl+LTWJi6LwcAzsj0Idbd6vRBecIUgU234AprLaXPUgE4fVNULwBKdz5uUJdcIbaq9zSNgaENjA4XUmBqGu2D2kbA4APN+9XUqANrn2nTQHiY+kKC0SoHz8wxipcaYEQiXH98O1qC0Rma4c2UcT0w+3b1RZogevXtMlHtMLVHCYocPSgEdkPq6vvQZvRXlQ6EtUP6+1fQiBSvjdpk4eIVtr8uHqpGhseVcI3VMN9WDsnv4hApHFrtGlOuEJVLGRTIhNG336nTTNCW+lmf9krMokIz9/CYunBz1/Hgw796oA2uYS00sa3XyOMzsFahTa5hPiww0duTCgaxliWzXIxLZlTkWH9wVJUszKNHfb+G7sfnvx4oE1elP3OpFTSRuq3iaBH/dkM4IQROvsu8hNkkruQhuiC2UvFTIXVmKEez9YPGrpyLo1zE0lKo6fS3Wwf/8Vl5GoY3mXt+LMUVjrRm2eq4Z2xVJTS53yqMQSNbK17y01izjwvsVoeK9LslCIFIuPE+1P7+tNhCZdUry0LyvjpE+27r54mJGg8ouFN2oSYPjyIi6PzRjqjIrY5LssUqDw47QVXC598j2ymrCOzUjqaSpxAVQ9+jRXGDjulzCKrOC7tv6ONFgbDIV4wYwM12ErXSrSFYsSeVX/tVHCZNqZCwbXnd8xyLy7ahcgQ3tKmYCvd+xHjQlSqhVXUVfA9swJFHWKBGyHPW5JOiK6ZrP6u9o6GrJjooMTNBvAh3bYDrfQWxykMrzJpo8baO9+USzHtitNJg2vt9MxBaVKyTqmJSqOxrO2ZD5elCZL4oe79wrJW/+T5keL5e9pCUQ4Ion14ehW74YG3widjVpy6w+7QYZduo6O2IJvhlxzUJvKIqDc9JGD3vPH66c+ob995iDu8uGWbJsFxcC/pX/JTOyGcuk7I8dtqg34vhEp956lAytKajLfo9/wcxR7fmljz/wrl1El8IawQE4lara37nc4mubBaPP1eCG3byc2+fLExCIZpH3E9CKGuVI1qBPXYU4Tx+in9WwVSAxwg8a/a+EcLCRDuR3GLzHnSwvG5k+x3tE/h3mfA0XO55KBQzuIijTUXvvD1f59CJSbxcxhGrPrkTy++J6KS7zNehXufQPXomeVmaQB0IzS69jrRqxDkwiXDSpkClLyqPK+PYC5cLoJEWxiMrjzh1KOQQFqARcx4mC+wMCd71jPmCuuQQGrBnEgXBonNSGz69/OFt7lCEegbAejqfGhBWqklZn/2cpa1NT8C4rCNptCWAql0YEfJz9PvmQ/v4pMFlwmoneQEtP10H6qPL2cDhDGEnR2EHkLnh/kjIGC8554+5t+PPtwbQ4/bMEKWz4vgCT2fDUN/9zjqPypcD8yNw9mgDcVhgBMq9XFcmQprJigelWHhLA8qf4AP03zcAZj68D5BOj0GdoUcUOAntzs4cl9MFaqw0d5B+zQfbApGSXByS9O467bSxiXY+zbxc7Sc0PwT9khGf7r/ur8yEj1vxYGr0PWXzHmYJAiIyG2mrsJaAu+XD5jbdIXQOkiwkVcSnH+c8QWcsVnwGvyzORC7bTRHJc4uhuPDgasWhP6EthTK9TE46ncf6vY/jsIy+LwgXLuiTcVyboKjjbpu/9/5+DlobcCGexpWtlIY/nWmKNymaSuMWUn3YixtoJhx8xoa+LX/2Bm0rRCwyjqlfLrIlfEZcQXOTR119n/r0GkFGoRu7BVIuwrN3ZzVb0th5RKasq01Q/fJisS+sRSIsT0NtmbACrhvTTTwR/Okv8XDGqrR3hjaPuShPbd8uhIutEJIzFb3nA2nlUaWi3kZMCodlkL7GOgUUXFa6QRYJcKffaRNywIDIwcWOpbCZgsmEKlL3Tn0MSCx9RQO5dHIaqVAfdbUZYnrMzSvYQNGt9u0fChysODLH61MI7ViDXBrAVvutoYA2sxG7tCWJRJT0DBDkKxWWgEuQXaXuZof4AS218lvW620K8B6Il7e8gwDTGBHrd6QigEbPknq2xjlAg87ap0g4swSAQhvaMtSAc70jfc1AuyFCC996uuDWZzJYkI04BoNBq8DFMMr4LpimWjAFG8I/FxRjEFJjX0L4z1YTLK37lYKDuZDQSM96AR/lQZ8CwM2IBJMRsAChVXz4Q1Q4ZAIkVfarC5xRe1T9AMSc/XInKi61CXArIIPYozJdA8qHqq4+FdBAC+RrxywIzfuYJ+zgbX7wgDmYngdrnDF0GGx3RjAFUJT9ILYgq0QGiUO6G2Ey8CFg4IwgDdQvYH7EJgHFoUKEwiNSDYrpjD6UmwPBHp9iADLdAtDBJ7xUyIANw/FVVqlsXgP86HKkx6schqNVyungdZH9nuEBwbT1dhYmwEtpZU1IgFjjbwC+9seoOd7LHJj4E0RxsYG9FuL4NkQtjYhTMgObCZpIdOGZQLcBUYcx9/BYpJ1NsCnogjeAQ/bkIgA/CjCwEXYQqj4ro6OwOgT5uXlLPRV8iF4K3OCCVTgtMJoRegB8xT7Cn7ggG8D23cthDVgI0Wog5EMHQTKpTSPJsgF6MVBSB2NCTqBptTD1ZkgArMUhAaH1mcxNIIYxtJq9GkOocvYPEEc0sHVGGtb0O3znKl9BtYeIAH3CII/bqv3mbYsCVieaTPCViuVoJEGGePpZSjLpg7uh8i+mQoiwLhk+Xz/kjYtgwSXFmDDjkrQ3VQrQfBeI708yuA5AHfmXBV0XQL3RBXePPKj8i+wC0XNqU3c6oJ77vh2BSaJKjw2asbAbqXAnTgHGbjmkSOV2wQnecvx4f0asMAU2Zc5P1l2Ge2zPtgjxH6aqd2xNmDFiQ78smeJ+3/C5wqCFWgchaMETW/ybnYZ+HKQEwQ7087B7M+DJ8E2ynCp08RX38Bh0XKHvebouE8G1sE5iLUvtKk49v8GjxSW94zpFSUIHSRx4uh6lzYVRu1ngg6FJOcG0Y7CW3AstTFbS0tPdwh4bm8xcOpFncmhmCCY2nSWNGScXCZyBXYUOj5sn0FnwS64tZT89O1FIoGie98IV5o4SBCh7M3SznHx13O/heejDgZ2yr3c0UVOEmqQne99LHxF4yyhQEui94ffePrefDFwZM/7+/nzQqQPIQbpqfuL0w5Ygl518YiJ+lvw9GlhmjtfE+TbDoboDvJThWlubzV8NUn6V9NyeHWXKMggu/tNJU0V9t/cJ4o1Dp3JRiGlm83tz2bSPojks2np/eMwoaW4Lk2XH17J+Y+MO9ed5GcfaWTqw1kWhBOlC48IWvoHZsPYq1ylaShc4+Lx1aNpV2PGGk5FJb0kOjksAwOR3u+j/Lrj3s51O2kPdJEfI8vMh+zNDnz0IPVLnMq/Q6FPimffPj0DKqr6PuWDJcm8hHieq599Cmancu1xmbvGbb0L/Wvi+Gg8zrpKuq5cCFqanmOzVp/VPs8T0nJw74w/uHx82e+29iojZkO2V9kng4cjkmHZVP354K6n6axmBWKyOcsqPfMtxtMj8LovjLz6b8RjIcQxOvtJMrjpQkOXf3TluJuvRyIens9eeyYVpeCoL+77dptaexMxcBYesbppf3iPX1WFeuqsvInXaoP26IGMF3v4t6HMBzHvnPn4KhBMSqf+5+42uYtQiS72ne/FvbailQZJembzVlL73wwk6tNkaxGEXc9Ci1fh0Zdgu5fqnO9CuMo9FzgNAVTT5K0GcfYH/UYYVaszCOIwA3EOeM9TouZb93j2JXj0grbvexRCpW+GxBsKMeoJADSHfwVPbmp8LvTviHcYcWSi/IXdybJLey94FlgQIxibw/nahO5bA9AilqtelOhZlo3gnwvuAe78jjFJOEU+TjpDDUU68X2xfwW5y2yAmvnDK/HvDcDKfnkjYbVm6sE9wNjvQv8S1EPYJKpf9wwlw3HstrFqSAnnx/cVeHlWJNLxe9/P1C7AIGQYwvfeIuhqnECkzW4BC2Z2O87FUA1qNKYUfnjJ7vGG7n18zs1pXAHYKGEbRQluOhNNbzvu3GKO7rkuxPeEoJfRccFdT08I5OEasfDH9NcG9qoaIS3Q/OldBe4bkcWB4zQz/2/wu+mFE7yhXOBLPzdCGgvvbb9XMQ+LThhmXH6Pa/vxSG8C3YOxnN9XmeHG+LnpiQXd/YgMSzhOtQEnLVxURozg3CbgQ9SuhLhHGXjj6XU9/FZ9XJpGag0YtCExJqN2OKgQ3R6w22kX+Ta4rzd77M9ZkZSZOMTSXrQjrp0yWgHrOx/GbO8MP/g2uG/WG5hZTsX5TwWcI0afSQDps55Gx/rO4WZwLuxQ5n2RanizW2vTtf68MjnjL/02KDxmRgAwO6zYwFKIBs815p+ajKiSqO7d7u4dLpvuxYmqLvP6U23rQ8gJiqWaZul3Bq7+oE02TIXo9tmQmSRKgWyze7Mhc8/a9qNeMb9f7x+c99MHjIUuxBUPAwOFA7MjIaTTSlx4Ru5oTc/vnIvlhNYn+IPImDDPKhCCk8xHLarsFCrfXcNF8jbi3BaZASuW2ty+YRZxkm3akiURc/M48HZwrHcJU4j+7xlrtNP/k3IgABHSZQBIr5lRxiZUIfrBvMO7oq/W1bIuwnP/oqeXcIWtY50x8HdHi6fHoaRLhSzfC77lQD/hCtGHXVaCOroOPq51yaj6VsQeJns8dOnuMseMH7mVKKyxcpJ4Jpt/0yYPET5E6O99VnQzb1kPh14euM7It+dEKkRfq0yJ/d+WUvXFBu9HPzw2jrfMQbjkX7XJin3mH4sm9kiifWgNixssL07MLn9IG5cCroUOhFPiFKK7NyyJaGC2yGaCRw7kBK7F3rAyKpa6fH/BzKZNHZEHfCivVfF8RlU7wFXxZJNjDTMAEsdSgEBQKrjbCllhtC/St8sbXoytJLavnNuTSkEcj7fjWk4I9e+hf4gJ9m/8sYEojN3dIxhJaIilqQuktUIUqr0Ks3VRxPZDm6+V8HU1G0PXez0dfrf7TOB783qLKEAK0e1uL77DFosgH0YO9DNgCtG35zprMrU8pBfkiraxASpEH7afM6fETECdeyFw898RybYPqELU+qOZ+4EzF/gYqLgWPh+kASu00psK+NL9fBH0zfhhcEYChej2+Rl7/7RY5MMSLMa4JFGIPvzrZfSwUQAEP7mAdkGHRAqtlvokz5gKOHtlaRN8T1mXhArRZ6UW78bcMnKC670kLdSGtZ4WSQtVh+XoZQzYnUVTsIbleVUllKQ+tLhVnrN31XKGx1wpakEmhDSH2modyakK6BcCN/phy9qRpFFo9Ua0O5TDm2rKqUUU5cH2R9oGI0Urdfi+3sCZ97dgKf0UATfW0562dD60aLcb0nlI9f5Wts9iVfpPh6z9axipFSJ0hepSn6VxkY3cIEq/NvTX4iVjAYXWnAodkT7jav4MtzYErWYkqDVmsJBCO+TU+Ws65nCByisggXSpPNjVFtO3sELbj42HgeC7oUo37XKGP68n/OSk7yujXyKHL4k0W4VeI6m3GH+bV2FLBO+k/p48qJ8R4h4eVRWeiMb0O/gy+T2r5Da7eXtNV5wtkmftpLmxh6Z+KaEhOmtnd6FYdgotKrKJSsAFojAaOtLXVqX3/cM//MM/wPgfAag/xSi9J6EAAAAASUVORK5CYII=" xmlns:xlink="http://www.w3.org/1999/xlink"/>
</svg>

<p class="text-gray-500 font-weight-600 text-2xl pt-2 pl-13">@smudge</p>

<div style="clear:both;"></div>

<svg style="width:40px;height:40px;float:left" version="1.1" viewBox="0.0 0.0 400.0 400.0" fill="none" stroke="none" stroke-linecap="square" stroke-miterlimit="10" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg">
  <image xmlns="http://www.w3.org/2000/svg" clip-path="url(#gc745338790_0_14.3)" fill="#000" width="400.0" height="400.0" x="0.0" y="0.0" preserveAspectRatio="none" xlink:href="data:image/png;base64,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" xmlns:xlink="http://www.w3.org/1999/xlink"/>
</svg>

<p class="text-gray-500 font-weight-600 text-2xl pt-2 pl-13" style="margin-top:0; margin-bottom:16px">@smudgethefirst</p>

<div style="clear:both;"></div>

<img src="/images/website-icon.png" width=40 style="float:left;" />
<p class="text-gray-500 font-weight-600 text-2xl pt-2 pl-13" style="margin-top:0">ngriffith.com</p>

<!--
Well, let me introduce myself.

My name is Nathan. I exist online in a few places.

I also exist in real life, and I work at a company called...
-->

---
layout: center
class: px-40
---

![Betterment Logo](/images/betterment.png)

<img v-click src="/images/were-hiring.png" style="width:200px;position:absolute;right:90px;bottom:130px" />
<img v-click src="/images/face.png" style="width:200px;position:absolute;left:100px;top:190px;transform:rotate(30deg)" />

<!--
Betterment. You might've heard of us, we offer financial advice, investing accounts, retirement, , you name it.
I like to say that our top product is financial peace of mind.

CLICK

And I should mention that we're hiring.

CLICK

And so I work on the application platform teams at Betterment.
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
And so, the story I want to tell starts in 2016, when I first joined Betterment.
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
Like, financial services for everyday people like me, and all of you, and my parents.
-->

---
layout: image
image: /images/sales-b2b.svg
---

# &nbsp;

<!--
The thing my team was building was actually a B2B product.
Because our customers were companies, who might want to offer 401k plans to their employees, who would then get the Betterment consumer experience.

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
**really** wanted to show off Betterment's consumer product
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
So, firstly, there's always the option to just use the production app, right? And in our case, it's a cluster of multiple relatively monolithic applications - so not microservices, but also not one big rails app.
But since our app involves real money, and real personal info, this option didn't feel great.

So we looked around and saw that Betterment also had a _staging_ environment.

CLICK

It was deployed in exactly the same overall configuration as production, except
the database was reset and repopulated nightly with some magical sanitized "staging" data.

And we said, okay, what if we do something like that?
-->

---
layout: center
---

![how to draw an owl](/images/how-owl.jpg)

<!--
and if this sounds a bit like

"step 1, draw circles, step 2, draw the owl"

it's because that's exactly what this is.

See, if what you need is a drawing of an owl,
and someone else is already drawing owls,
then you don't really need to learn how to draw the owl.
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

CLICK

Of course, we made a couple modifications to the owl. For instance, we
didn't need all of the sanitized staging data, so
we added another process to just sort of populate the database with some demo accounts.
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
and it worked! or... so we thought.
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

But we were getting a sense that the demo environment wasn't really all that reliable.
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
In fact, we were being told directly,

CLICK

and again, and again,

CLICK

in no uncertain terms,

CLICK

that the demo environment was not reliable.

CLICK

And it just kept breaking for all sorts of reasons.
-->

---
layout: center
---

<img src="/images/slacks/12.png" />


<!--
And eventually, getting it working was just too much for us.

And so we effectively gave up. And it felt bad.
-->

---
layout: image
image: /images/2018.svg
---

# &nbsp;

<!--
And by 2018, we _knew_ we had truly failed, because the Slack messages had stopped entirely. Teams had found other ways of giving demos.
-->

---
layout: center
class: pt-20
---

<img style="width:42%;margin:0 auto;" src="/images/jenkins.png" />

<!--
And, I saved this screengrab of our build history. (Now, I can tell this is really old because we haven't used Jenkins for years...)

And if you look closely, it's actually an entire year's worth of broken builds.

So each one of those was a developer, banging their head against their keyboard, trying to get this working.
-->

---
layout: cover
background: /images/iceberg.jpg
class: text-center text-shadow-lg font-mono
---

# "Demoability"
## Observation No. 1

<!--
And thinking back to that iceberg of demoability, we had already made our first big observation, right beneath the surface, which is that...
-->

---
layout: cover
background: /images/iceberg.jpg
class: text-center text-shadow-lg font-mono
---

# deployment<br/>!=<br/>maintenance

<!--
Deploying a demo environment is not the same as maintaining a demo environment.
-->


---
layout: image
image: /images/2019.svg
---

# &nbsp;

<!--
So by 2019, the business needs had caught up with us
again, and we really needed this thing to be working.

**But...** we also finally had time in our roadmap,
and this time we wanted to build something that was easier to maintain in the long run.
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

So, firstly, what got deployed? CLICK Well, everything. All of our apps.

Secondly, the database was populated up front with all of the demo accounts CLICK, so we would call that, like, seed or fixture data.

And then the entire database was reset with every deployment, CLICK so it relied on these short-lived databases.

Then at first we deployed this thing on Sundays, but that got to be too painful so we switched to monthly deployments, and WHEN THAT got too painful, we just started deploying only when we needed to. CLICK So I would call it "push button" deploys, but it was really "push button and cross fingers"

Lastly, who owned it? Well, CLICK us. The engineering team closest to the need for its existence (and most incentivized to do the work). And so, now that we had this list, we started to cross things out.
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
- <span style="opacity:0.5">Populated with **seed/fixture data**</span>
- <span style="opacity:0.5">Relied on **short-lived databases**</span>
- <span style="opacity:0.5">Deployed via **push-button (and 🤞)**</span>
- <span style="opacity:0.5">Owned by **one team**</span>

</div>

<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
First, with this idea of deploying an entire cluster of services.

Because, from a maintainability standpoint, why keep a _bunch_ of apps running if we really only care about one app. The thing we really wanted to demo.

And that got us thinking, because at Betterment we already have a way of running our Rails apps in isolation **from one another**.
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

what webvalve lets us do is define fake versions of all of our external apps,
and it will automatically route all web traffic to those fakes.

It's actually built on top of WebMock, if you're familiar with that gem.
-->

---
layout: two-cols
class: text-center px-10
---

# Without WebValve:

<img src="/images/webvalve-without.png" class="pt-3" />

::right::


# With WebValve:

<v-click>

<img src="/images/webvalve-with.png" class="px-10 pt-20" />

</v-click>

<!--
and so instead of running an entire cluster of applications locally, and connecting to external sandbox APIs and that kind of thing

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
line-height: 140% !important;
padding: 1em !important;
}
</style>

<!--
And these fakes apps are really simple.

They don't have to do everything the real app would,

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
And our VP of Architecture, Sam, summarizes how useful WebValve can be for local development and for testing, & so I'm not gonna cover all of that here.
-->

---
layout: center
class: px-60
---

<div class="text-center mb-2 text-blue-500 text-2xl" style="font-size:1.6em"><strong>https://github.com/Betterment/webvalve</strong></div>

![webvalve readme](/images/webvalve-readme.png)

<style>
  img { border: 4px solid rgba(200, 200, 200, 0.5); }
</style>

<!--
If you're interested, you can find that **and more** on GitHub

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
class: px-40 bg-blue-50
---

![summary page](/images/summary-page.png)

<!--
And so, right off the bat, this was great!

But remember that we were stubbing out all of those collaborating services, so basically all outside HTTP requests.

And so I showed it one of my colleagues who commonly gave client demos, and he clicked around, and he liked what he was seeing.

But then he encountered...
-->

---
layout: center
class: px-20 bg-blue-50
---

![performance page (no graphs)](/images/performance/page-empty-graphs.png)

<!--
...this page, which is supposed to graph the performance history of an account.

And he said, hold on, I can't show this to clients.
-->

---
layout: center
class: px-20 bg-blue-50
---

![empty returns graph](/images/performance/returns-empty.png)

<!--
And I was like, well we don't actually have any performance history, because this is just a demo app, and the history comes from a different backend service, and blah blah blah, developer talk.

And he said, doesn't matter. If a client has to ask why something looks broken, then the demo is already off track.
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
So I walked away from that meeting feeling pretty bummed, because he was right, and I knew I was just making excuses for technical shortcomings.

And, so I started to wonder if this whole WebValve approach was even the right idea.
-->

---



<div grid="~ cols-2 gap-25" m="t-21"><div>

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
<div><div class="bg-blue-50 px-5 pt-18 pb-2 absolute top-0 bottom-0">

![empty graph](/images/performance/returns-empty.png)

</div></div></div>


<style>
pre {
  position:absolute;top:0;bottom:0;left:0;right:0;
  font-size: 85% !important;
  line-height: 145% !important;
  margin:0 !important;
  border-radius: 0 !important;
  padding: 20px !important;
}
</style>


<!--
But I thought about it more. Because, like, most of the application worked
as intended. It was just some of these external service boundaries that didn't
make for a good demo.

And so, I thought, why not, just, make the fake service a little more fake.
-->

---

<div grid="~ cols-2 gap-25"><div>

```ruby {all|7|8|9|10|11|all}
class FakeBalanceService < WebValve::FakeService
  get '/api/daily_returns' do
    date_range = dates(params[:from], params[:to])
    bal = Money.new(1_000_00)
    json(date_range.map.with_index do |date, idx|
      starting_bal = bal
      buys = deposit?(date) ? random_buy : 0
      sells = withdraw?(date) ? random_sell : 0
      mkt_changes = bal * random_market_change
      divs = dividend?(date) ? bal * 0.01 : 0
      fees = fee?(date) ? bal * 0.0025 : 0
      bal += buys - sells + mkt_changes + divs - fees
      {
        date: date.to_s(:iso8601),
        balance_cents: bal.cents,
        starting_balance_cents: starting_bal.cents,
        market_change_amount_cents: mkt_changes.cents,
        dividend_amount_cents: divs.cents,
        fees_cents: fees.cents,
      }
    end)
  end
end
```

</div>
<div><div class="bg-blue-50 px-5 pt-18 pb-2 absolute top-0 bottom-0" v-click-hide>

![empty graph](/images/performance/returns-empty.png)

</div>

<div class="bg-blue-50 px-5 pt-18 pb-2 absolute top-0 bottom-0" v-after>

![graph](/images/performance/returns.png)

</div></div></div>

<style>
pre {
  position:absolute;top:0;bottom:0;left:0;right:0;
  font-size: 85% !important;
  line-height: 145% !important;
  margin:0 !important;
  border-radius: 0 !important;
  padding: 20px !important;
}
</style>

<!--
And so, I wrote a fake stock market simulation.
With buys, and sells, and market changes, and dividends, and fees.

CLICK

And of course, none of this is actually based in any kind of reality.
Like, this is a terrible simulation, and you shouldn't use it for anything.

But it resulted in

CLICK

this graph.

Again, is this real? No, absolutely not. But is it demoable? Maybe.
-->

---
layout: center
class: px-20 bg-blue-50
---

![performance page (with graphs)](/images/performance/page-graphs.png)

<!--
So I went back to my colleague, and he said BREATHE yeah, sure, looks good

And so at that point I decided, okay, we can probably run with this.

And, you know, we did. And there were maybe one or two other places where we had to fill in the gaps like this.

But there was one more big issue, which was that...
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
padding: 10px 200px !important;
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

It can actually UPDATE those tables 
-->

---
layout: center
class: px-50
---

![webvalve stateful fake](/images/webvalve-stateful-fake.png)

<!--
And so now it can remember things!

You could deposit 123 dollars into an account, and then see it actually reflected in the balance for that account.
-->

---
layout: center
class: text-center
---

# RAILS_ENV=**demo**

<img src="/images/app-cluster-after-small.png" class="px-85 mt-10" />

<!--
And so we'd done it. We could **demo** our app in total isolation from any other apps or services.
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
- <span style="opacity:0.5">Populated with **seed/fixture data**</span>
- <span style="opacity:0.5">Relied on **short-lived databases**</span>
- <span style="opacity:0.5">Deployed via **push-button (and 🤞)**</span>
- <span style="opacity:0.5">Owned by **one team**</span>

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
And so, instead of deploying multiple apps, we had...

CLICK

just one app. With stateful fakes.
-->

---
layout: cover
background: /images/iceberg.jpg
class: text-center text-shadow-lg font-mono
---

# "Demoability"
## Observation No. 2

<!--
And we've also made our second observation, in the iceberg of "demoability", which is that...
-->

---
layout: cover
background: /images/iceberg.jpg
class: text-center text-shadow-lg font-mono
---

# an app should (mostly) work in isolation

<!--
An app should mostly work in isolation.

Like, it might need some extra massaging at the system boundaries, but if we want an app to be easily demoable, it should mostly make sense on its own.

And thankfully ours did.
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

- <span style="opacity:0.5">Consisted of ~~**multiple apps/services**~~</span>
- Populated with **seed/fixture data**
- <span style="opacity:0.5">Relied on **short-lived databases**</span>
- <span style="opacity:0.5">Deployed via **push-button (and 🤞)**</span>
- <span style="opacity:0.5">Owned by **one team**</span>

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60" style="opacity:0.5">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
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

- <span style="opacity:0.5">Consisted of ~~**multiple apps/services**~~</span>
- Populated with ~~**seed/fixture data**~~
- <span style="opacity:0.5">Relied on **short-lived databases**</span>
- <span style="opacity:0.5">Deployed via **push-button (and 🤞)**</span>
- <span style="opacity:0.5">Owned by **one team**</span>

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60" style="opacity:0.5">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
So we crossed that out too....

But, then we thought, well, okay, if we're not using seeds or fixture data -- like, if we don't actually populate user accounts ahead of time -- then what do we do?
-->

---
layout: center
class: px-80
---

![login form](/images/log_in.png)

<!--
Like, how else are you going to login?

You'll be faced with this form, and you'll need to enter something, right?

Well the more we thought about this, the more we realized how awkward this must **already** be for our client-facing teams.
-->

---
layout: image
image: /images/sticky-note.jpg
class: bg-contain
style: 'background-size: contain'
---

# &nbsp;

<!--
Like, did they just keep the list of demo logins on a sticky note? 

How did they know that someone else wasn't already using one of the demo accounts?
-->

---
layout: center
class: px-80
---

![login form](/images/log_in.png)

<!--
And so, if it's so awkward, why are we using the login form at all? 

And that was our "ah ha" moment, and we sketched out something totally different on a whiteboard.
-->

---
layout: center
---

![personas whiteboard](/images/personas-whiteboard.png)

<!--
A page where you are presented with, like, 3 different users, each with a sign in button.

And we thought to ourselves, well what if...
-->

---
layout: center
---

![personas whiteboard](/images/personas-whiteboard-button.png)

<!--
...when you click sign in, instead of logging in as a _specific_ user account, it spins out some kind of background process and generates a NEW user for you on the fly.
-->

---
layout: center
---

![personas process](/images/personas-process.png)

<!--
So you'd see a brief loading spinner, but then you'd be dropped straight into a totally fresh dashboard.

This felt way less awkward than the login page and, like, having to use sticky notes.

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
And again, when we looked to our local development environments we saw that we **were already doing this.**

**So, when writing our _tests_,** we were using...
-->

---
layout: center
class: px-40
---

![factory_bot logo](/images/factory_bot.png)

<!--
Factories! At Betterment we use a tool called FactoryBot, by our friends at ThoughtBot.
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
font-size: 140% !important;
line-height: 140% !important;
padding: 1em !important;
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
font-size: 200% !important;
line-height: 140% !important;
padding: 1em !important;
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
And so, great, we could easily wire this up to our sign in button.
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
font-size: 130% !important;
line-height: 140% !important;
padding: 1em !important;
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
font-size: 200% !important;
line-height: 140% !important;
padding: 0.7em !important;
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

  sign_in_as do
    FactoryBot.create(:user, :with_roth_401k)
  end
end
```

<style>
pre {
font-size: 160% !important;
line-height: 140% !important;
padding: 1em !important;
}
</style>

<!--
So to support this, we came up with this quick little domain specific language (or DSL) for defining these, **and we called them "personas"**.

All you had to do was drop your factory code...

CLICK

right in there, and it would take care of the rest.

And, so, we took these persona definitions, and we built...
-->

---
layout: center
---

<video muted>
  <source src="/images/personas-login.mp4" />
</video>

<!--
the actual user interface.

And so we had our persona picker. And we made this replace the login page entirely.
-->

---
layout: center
---

<video muted autoplay>
  <source src="/images/personas-login.mp4" />
</video>

<!--
And it worked!

There's the loading spinner, and that should take us to the dashboard.

Bingo.

But there was one hiccup. This was working for us for a while, but then we deployed a change, and suddenly...
-->

---
layout: center
class: px-15
---

![500](/images/500-error.png)

<!--
...it broke. Darn.

So, this was giving us flashbacks, right?

But then we dug in a bit, and what we found was that...
-->

---
layout: center
class: text-3xl
---

### <span class="text-blue-500 text-5xl leading-relaxed">🚢 deployment 1</span>

<v-clicks>

✅ <strong>user_1</strong>@example.org

✅ <strong>user_2</strong>@example.org

✅ <strong>user_3</strong>@example.org

### <span class="text-blue-500 text-5xl leading-relaxed">🚢 deployment 2</span>

<p>❌ <strong>user_1</strong>@example.org</p>

</v-clicks>

<arrow x1="250" y1="100" x2="250" y2="460" color="#aaa" width="5" />

<style>
p { line-height: 1.3em !important }
</style>

<!--
...after the initial deployment, we could generate user 1, user 2, user 3, and so on, and they'd work just fine.
But when we redeploy, the next user we generate would reset back to user_1.

And this would fail against uniqueness constraints in our database, or uniqueness validations in the models,
because user_1's email (among other things) was already taken.
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
font-size: 150% !important;
line-height: 140% !important;
padding: 1em !important;
}
</style>

<!--
And if you look back at the way that factories are defined,
you see that we rely on this sequence feature to generate unique sequences for us, so unique emails addresses, and so on.

And the problem here is again...
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
it has no memory, this time no LONG TERM memory,

because the sequences reset every time the Ruby process (or the server) restarts.

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
font-size: 140% !important;
line-height: 140% !important;
padding: 10em !important;
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
font-size: 140% !important;
line-height: 140% !important;
padding: 10em !important;
}
</style>

<!--
At first were just like, okay, let's take the maximum value in the table - like SELECT MAX of the column name - and add 1.

And if it's an integer column, or a string with some sort of standard lexographic order, it kinda works? But not really.
-->

---
layout: center
---

```ruby
sequence(:short_id) { |i| 10000009 - i }
```

<v-clicks>

<p class="text-3xl ml-105 pl-10 pb-5 relative font-mono" style="line-height: 1.2em">
  1000000<strong>9</strong><br/>
  1000000<strong>8</strong><br/>
  1000000<strong>7</strong><br/>
  ...
  <arrow x1="20" y1="0" x2="20" y2="140" color="#aaa" width="4" />
</p>

</v-clicks>

<style>
pre {
font-size: 160% !important;
line-height: 140% !important;
padding: 1em !important;
margin-top: 2em !important;
}
</style>

<!--
Because, here's a sequence that goes in...

CLICK

descending order.

CLICK

And here's a sequence where the attribute is actually...

CLICK

ENCRYPTED at rest.

There's just no way with SQL to select for the MAX value in these columns.

There are a few ways to solve for this, and I'd say that we went with the best-worst option. Which is...
-->



---
layout: center
---

```ruby
sequence(:ssn) { |i| i.to_s.rjust(9, '0') }
```

<v-clicks>

<p class="text-3xl ml-7 pl-10 relative font-mono" style="line-height: 1.2em">
  decrypt(<strong>"342lk9s..."</strong>) => 000-00-0000<br/>
  decrypt(<strong>"jf9893d..."</strong>) => 000-00-0001<br/>
  decrypt(<strong>"j52c5ag..."</strong>) => 000-00-0002<br/>
  ...
  <arrow x1="20" y1="0" x2="20" y2="140" color="#aaa" width="4" />
</p>

</v-clicks>

<style>
pre {
font-size: 160% !important;
line-height: 140% !important;
padding: 1em !important;
margin-top: 2em !important;
}
</style>

<!--
Because, here's a sequence that goes in...

CLICK

descending order.

CLICK

And here's a sequence where the attribute is actually...

CLICK

ENCRYPTED at rest.

There's just no way with SQL to select for the MAX value in these columns.

There are a few ways to solve for this, and I'd say that we went with the best-worst option. Which is...
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
      CleverSequence.lookup(klass, name, &block).next
    end
  end
end
```

<style>
pre {
font-size: 140% !important;
line-height: 140% !important;
padding: 10em !important;
}
</style>

<!--
And of course, we called it clever sequence (because clever code isn't necessarily good code, and we wanted to remind ourselves of that)

But it helped us get to a demoable state, and again, that's what mattered.
-->

---
layout: image
image: /images/sales-pitch.jpg
class: text-center
---

<video muted autoplay width=390 class="absolute left-67 top-40">
  <source src="/images/personas-login.mp4" />
</video>

<div v-click style="position:absolute;bottom:40px;left:0;right:0" class="text-3xl">
  <strong>(this is definitely a real demo)</strong>
</div>

<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@xteemu?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Teemu Paananen</a> on <a href="https://unsplash.com/s/photos/pitch?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
And so now it worked for real. CLICK And we could actually start to use it in our real product demos.
-->

---
layout: cover
background: /images/iceberg.jpg
class: text-center text-shadow-lg font-mono
---

# "Demoability"
## Observation No. 3

<!--
And so we had another iceberg reveal. This time, the take-away was...
-->

---
layout: cover
background: /images/iceberg.jpg
class: text-center text-shadow-lg font-mono
---

# Start with the UX

<!--
...that we needed to start with the user experience and work backwards from there.

Our first demo environment was built on the faulty assumption that the login page was the right user experience,
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

- <span style="opacity:0.5">Consisted of ~~**multiple apps/services**~~</span>
- Populated with ~~**seed/fixture data**~~
- <span style="opacity:0.5">Relied on **short-lived databases**</span>
- <span style="opacity:0.5">Deployed via **push-button (and 🤞)**</span>
- <span style="opacity:0.5">Owned by **one team**</span>

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60" style="opacity:0.5">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>
- <span v-click class="pl-70">↱ **personas** <span class="text-xl">(+ factories)</span></span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
And by rethinking that assumption, we were able to do away with seeds and fixtures, in favor of...

CLICK

the new personas framework powered by factories.

And we could've stopped there, right? Like, we had this thing working end-to-end. But we're not done crossing out this list, so we decided to keep going.
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

- <span style="opacity:0.5">Consisted of ~~**multiple apps/services**~~</span>
- <span style="opacity:0.5">Populated with ~~**seed/fixture data**~~</span>
- <span style="opacity:1.0">Relied on **short-lived databases**</span>
- <span style="opacity:0.5">Deployed via **push-button (and 🤞)**</span>
- <span style="opacity:0.5">Owned by **one team**</span>

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60" style="opacity:0.5">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>
- <span class="pl-70" style="opacity:0.5">↱ **personas** <span class="text-xl">(+ factories)</span></span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
So let's look at this short-lived database idea.
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

- <span style="opacity:0.5">Consisted of ~~**multiple apps/services**~~</span>
- <span style="opacity:0.5">Populated with ~~**seed/fixture data**~~</span>
- <span style="opacity:1.0">Relied on ~~**short-lived databases**~~</span>
- <span style="opacity:0.5">Deployed via **push-button (and 🤞)**</span>
- <span style="opacity:0.5">Owned by **one team**</span>

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60" style="opacity:0.5">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>
- <span class="pl-70" style="opacity:0.5">↱ **personas** <span class="text-xl">(+ factories)</span></span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
And this one is really easy to cross out, because...
-->

---
layout: center
class: px-80
---

![short-lived db](/images/short-lived-db.png)

<!--
if you recall, we had this process that would basically destroy and recreate the database every so often.

But the only reason we needed this process was because we had previously relied on demo data being pre-populated with seeds and fixtures, and we wanted to reset that periodically.

But we had personas now!
-->

---
layout: center
class: px-80
---

![long-lived db](/images/long-lived-db.png)

<!--
So if we just... didn't reset the database ever, and kept it around indefinitely,
all of the demo functionality would still work as intended. And it would be easier to maintain, because it had fewer moving parts.
-->

---
layout: center
class: px-30 pb-25
---

![db:migrate](/images/db-migrate.png)

<!--
We just had to make sure that we ran all of the necessary schema migrations over time, just like we do in production.
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

- <span style="opacity:0.5">Consisted of ~~**multiple apps/services**~~</span>
- <span style="opacity:0.5">Populated with ~~**seed/fixture data**~~</span>
- Relied on ~~**short-lived databases**~~
- <span style="opacity:0.5">Deployed via **push-button (and 🤞)**</span>
- <span style="opacity:0.5">Owned by **one team**</span>

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60" style="opacity:0.5">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>
- <span class="pl-70" style="opacity:0.5">↱ **personas** <span class="text-xl">(+ factories)</span></span>
- <span v-click class="pl-45">↱ a **long-lived database**</span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
And so, that was easy. We can go ahead and replace that with

CLICK

a long lived database, that runs schema migrations.
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

- <span style="opacity:0.5">Consisted of ~~**multiple apps/services**~~</span>
- <span style="opacity:0.5">Populated with ~~**seed/fixture data**~~</span>
- <span style="opacity:0.5">Relied on ~~**short-lived databases**~~</span>
- <span style="opacity:1.0">Deployed via ~~**push-button (and 🤞)**~~</span>
- <span style="opacity:0.5">Owned by **one team**</span>

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60" style="opacity:0.5">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>
- <span class="pl-70" style="opacity:0.5">↱ **personas** <span class="text-xl">(+ factories)</span></span>
- <span class="pl-45" style="opacity:0.5">↱ a **long-lived database**</span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
So next up, was the cadence of deployments. And we crossed this out. And if you remember...
-->

---
layout: center
class: px-50 mr-20
---

![pain graph](/images/pain-graph.png)

<!--
I said that the longer the cadence, the more painful it got.

And there's a simple reason for this.

It's because whenever something goes wrong, the way to debug it is to look into every change
that has happened since the last successful deploy.
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
And I'm sure you can see where I'm going with this.

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

This is how we build our production apps at Betterment, so it made sense to just do the same thing for demo.

Of course, with continuous deploys, you need to actually operate and monitor the thing as well, so you actually know when something breaks.
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

we made sure errors would flow into our bugtracker.

And both of these things can then feed into our on call processes for all of our teams.
-->

---
layout: center
---

![ci-cd diagram](/images/ci-cd.png)

<!--
And then the last bit that we were missing, here, was there on the lower left... testing.
-->

---

<div grid="~ cols-2 gap-20" m="t-10"><div>

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

<style>
pre {
  position:absolute;top:0;bottom:0;left:0;right:0;
  font-size: 85% !important;
  line-height: 150% !important;
  margin:0 !important;
  padding: 50px 30px !important;
  border-radius: 0 !important;
}
</style>

<!--
And so we wrote tests and stuck them in our standard test suite!

CLICK

We actually made it possible to toggle the personas mode on and off using an environment variable.

CLICK

And then the test itself would click through an actual product demo, starting with the personas page.

CLICK

And so if a test failed, a developer would see a red PR build, and know that they broke an actual customer demo or sales pitch.

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

- <span style="opacity:0.5">Consisted of ~~**multiple apps/services**~~</span>
- <span style="opacity:0.5">Populated with ~~**seed/fixture data**~~</span>
- <span style="opacity:0.5">Relied on ~~**short-lived databases**~~</span>
- Deployed ~~via **push-button (and 🤞)**~~
- <span style="opacity:0.5">Owned by **one team**</span>

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60" style="opacity:0.5">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>
- <span class="pl-70" style="opacity:0.5">↱ **personas** <span class="text-xl">(+ factories)</span></span>
- <span class="pl-45" style="opacity:0.5">↱ a **long-lived database**</span>
- <span v-click class="pl-40">↱ **continuously**</span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>


<!--
And so instead of push-button deploys...

CLICK

We were deploying continuously, and really benefiting from it, just like in our production environment.
-->

---
layout: cover
background: /images/iceberg.jpg
class: text-center text-shadow-lg font-mono
---

# "Demoability"
## Observation No. 4

<!--
And that's actually the next iceberg observation.
-->

---
layout: cover
background: /images/iceberg.jpg
class: text-center text-shadow-lg font-mono
---

# the demo env<br/>_is_<br/>a production env

<!--
I'd argue that the demo environment _is_ a kind of production environment.

Because, like, if you're running live sales demos in front of real audiences,
then that's a production app, and it deserves production-like uptime guarantees.
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

- <span style="opacity:0.5">Consisted of ~~**multiple apps/services**~~</span>
- <span style="opacity:0.5">Populated with ~~**seed/fixture data**~~</span>
- <span style="opacity:0.5">Relied on ~~**short-lived databases**~~</span>
- <span style="opacity:0.5">Deployed ~~via **push-button (and 🤞)**~~</span>
- Owned by **one team**

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60" style="opacity:0.5">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>
- <span class="pl-70" style="opacity:0.5">↱ **personas** <span class="text-xl">(+ factories)</span></span>
- <span class="pl-45" style="opacity:0.5">↱ a **long-lived database**</span>
- <span class="pl-40" style="opacity:0.5">↱ **continuously**</span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
And so we've made it to this last item in the list. The question of who owns this thing. And...
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

- <span style="opacity:0.5">Consisted of ~~**multiple apps/services**~~</span>
- <span style="opacity:0.5">Populated with ~~**seed/fixture data**~~</span>
- <span style="opacity:0.5">Relied on ~~**short-lived databases**~~</span>
- <span style="opacity:0.5">Deployed ~~via **push-button (and 🤞)**~~</span>
- <span style="opacity:1.0">~~Owned by **one team**~~</span>

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60" style="opacity:0.5">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>
- <span class="pl-70" style="opacity:0.5">↱ **personas** <span class="text-xl">(+ factories)</span></span>
- <span class="pl-45" style="opacity:0.5">↱ a **long-lived database**</span>
- <span class="pl-40" style="opacity:0.5">↱ **continuously**</span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
I think we can cross this out... without any more slides, because we can just look at the things we've done above.
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

- <span style="opacity:1.0">Consisted of ~~**multiple apps/services**~~</span>
- <span style="opacity:0.5">Populated with ~~**seed/fixture data**~~</span>
- <span style="opacity:0.5">Relied on ~~**short-lived databases**~~</span>
- <span style="opacity:0.5">Deployed ~~via **push-button (and 🤞)**~~</span>
- <span style="opacity:0.5">~~Owned by **one team**~~</span>

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60" style="opacity:1.0">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>
- <span class="pl-70" style="opacity:0.5">↱ **personas** <span class="text-xl">(+ factories)</span></span>
- <span class="pl-45" style="opacity:0.5">↱ a **long-lived database**</span>
- <span class="pl-40" style="opacity:0.5">↱ **continuously**</span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>


<!--
So for one, we're using these stateful fakes, which teams already write when developing and testing apps locally.
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

- <span style="opacity:0.5">Consisted of ~~**multiple apps/services**~~</span>
- <span style="opacity:1.0">Populated with ~~**seed/fixture data**~~</span>
- <span style="opacity:0.5">Relied on ~~**short-lived databases**~~</span>
- <span style="opacity:0.5">Deployed ~~via **push-button (and 🤞)**~~</span>
- <span style="opacity:0.5">~~Owned by **one team**~~</span>

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60" style="opacity:0.5">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>
- <span class="pl-70" style="opacity:1.0">↱ **personas** <span class="text-xl">(+ factories)</span></span>
- <span class="pl-45" style="opacity:0.5">↱ a **long-lived database**</span>
- <span class="pl-40" style="opacity:0.5">↱ **continuously**</span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>


<!--
And for the demo personas, we're using factories, which again, teams already produce when writing their tests.
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

- <span style="opacity:0.5">Consisted of ~~**multiple apps/services**~~</span>
- <span style="opacity:0.5">Populated with ~~**seed/fixture data**~~</span>
- <span style="opacity:1.0">Relied on ~~**short-lived databases**~~</span>
- <span style="opacity:0.5">Deployed ~~via **push-button (and 🤞)**~~</span>
- <span style="opacity:0.5">~~Owned by **one team**~~</span>

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60" style="opacity:0.5">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>
- <span class="pl-70" style="opacity:0.5">↱ **personas** <span class="text-xl">(+ factories)</span></span>
- <span class="pl-45" style="opacity:1.0">↱ a **long-lived database**</span>
- <span class="pl-40" style="opacity:0.5">↱ **continuously**</span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
Then we have this long-lived database, that depends just on migrations, and teams are already writing those when they build features.
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

- <span style="opacity:0.5">Consisted of ~~**multiple apps/services**~~</span>
- <span style="opacity:0.5">Populated with ~~**seed/fixture data**~~</span>
- <span style="opacity:0.5">Relied on ~~**short-lived databases**~~</span>
- <span style="opacity:1.0">Deployed ~~via **push-button (and 🤞)**~~</span>
- <span style="opacity:0.5">~~Owned by **one team**~~</span>

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60" style="opacity:0.5">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>
- <span class="pl-70" style="opacity:0.5">↱ **personas** <span class="text-xl">(+ factories)</span></span>
- <span class="pl-45" style="opacity:0.5">↱ a **long-lived database**</span>
- <span class="pl-40" style="opacity:1.0">↱ **continuously**</span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
Plus we're following a CI/CD process that routes any build failures or issues through to the team closest to the change being made.
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

- <span style="opacity:0.5">Consisted of ~~**multiple apps/services**~~</span>
- <span style="opacity:0.5">Populated with ~~**seed/fixture data**~~</span>
- <span style="opacity:0.5">Relied on ~~**short-lived databases**~~</span>
- <span style="opacity:0.5">Deployed ~~via **push-button (and 🤞)**~~</span>
- <span style="opacity:1.0">~~Owned by **one team**~~</span>

</div>

<div class="text-blue-800 absolute left-40 top-0 right-0 bottom-0">

- <span class="pl-60" style="opacity:0.5">↱ **one app** <span class="text-xl">(+ stateful fakes)</span></span>
- <span class="pl-70" style="opacity:0.5">↱ **personas** <span class="text-xl">(+ factories)</span></span>
- <span class="pl-45" style="opacity:0.5">↱ a **long-lived database**</span>
- <span class="pl-40" style="opacity:0.5">↱ **continuously**</span>
- <span style="opacity:1.0" v-click>↱ Maintained by **everyone**</span>

</div>


<div style="position:absolute;right:10px;bottom:10px" class="text-xs">
Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/s/photos/notebook?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
</div>

<!--
And so, the problem of ownership... of who owns this thing... is kind of immaterial, because the real question is who maintains it.

And it's effectively...

CLICK

maintained by everyone!

And, so, this list has gotten kinda messy, so let's just rewrite it....
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
There we go. This was the Demo environment 2.0.

An isolated app, centered around personas, utilizing a long-lived database, and deployed continuously.

And, as a result of all of all of the tools we use in our day-to-day work, was maintained by everyone.
-->

---
layout: cover
background: /images/iceberg.jpg
class: text-center text-shadow-lg font-mono
---

# "Demoability"
## Observation No. 5

<!-- 
And that leads into our final observation, which is simply that...
-->

---
layout: cover
background: /images/iceberg.jpg
class: text-center text-shadow-lg font-mono
---

# Incentives Matter

<!--
like, incentives matter.

It might sound a little obvious, cliche even, but it's actually what this talk has been secretly about all along.
-->

---
layout: center
class: px-60
---

![incentives-0](/images/incentives-0.png)

<!--
Because thinking back to 2016 and that first demo environment...
-->

---
layout: center
class: px-60
---

![incentives-1.5](/images/incentives-1.5.png)

<img src="/images/thoughts/retail.png" style="position:absolute; right: 10px; top: 30px; width: 260px;" />

<!--
We had the team building Betterment's consumer-facing product, focused on their own roadmaps and goals,
and they had no reason to maintain a demo environment.
-->

---
layout: center
class: px-60
---

![incentives-1](/images/incentives-1.png)


<img src="/images/thoughts/retail.png" style="position:absolute; right: 10px; top: 30px; width: 260px;" />
<img src="/images/thoughts/b2b.png" style="position:absolute; bottom: 190px; left: 10px; width: 260px;" />

<!--
Then, we had the B2B engineering team, who owned the demo environment for a consumer product that they weren't really building.
-->

---
layout: center
class: px-60
---

![incentives-2](/images/incentives-2.png)


<img src="/images/thoughts/retail.png" style="position:absolute; right: 10px; top: 30px; width: 260px;" />
<img src="/images/thoughts/b2b.png" style="position:absolute; bottom: 190px; left: 10px; width: 260px;" />
<img src="/images/thoughts/demoers.png" style="position:absolute; top: 30px; left: 310px; width: 260px;" />

<!--
And finally a non-engineering team who desperately needed that demo environment (to give demos), but who quickly learned not to trust it.
-->

---
layout: center
class: px-60
---

![incentives-3](/images/incentives-3.png)

<!--
And so we had three completely misaligned teams with misaligned incentives.
-->

---
layout: center
class: px-60
---

![incentives-0](/images/incentives-0.png)

<!--
But, with this NEW demo environment...
-->

---
layout: center
class: px-60
---

![incentives-4](/images/incentives-4.png)

<!--
...when we meet developers where they are, with tools that they use every day, like webvalve and factory_bot.
-->

---
layout: center
class: px-60
---

![incentives-5](/images/incentives-5.png)

<!--
And when we codify the needs of our stakeholders, with automated tests and alerting, and with abstractions like personas.
-->

---
layout: center
class: px-60
---

![incentives-6](/images/incentives-6.png)

<!--
And then we focus on the user experience for our demo-giving users, and ensure that they have reliable uptime guarantees.
-->

---
layout: center
class: px-60
---

![incentives-7](/images/incentives-7.png)

<!--
We now have a set of teams with the agency, expertise, mutual trust, and incentives to maintain this environment together.
-->

---
layout: image
image: /images/2020.svg
---

# &nbsp;

<!--
So we shipped this in 2020, and as we all know it has been at least 6 years, 7 years maybe, since then. I dunno, I stopped counting.

But to close us out, I wanted to share what we've done in the years since this released.
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
Firstly, we actually ended up launching versions of it for 3 of our customer-facing products.
So each of these is a different Rails app with its own set of stateful fakes and personas.
-->

---
layout: center
---

<video muted autoplay loop>
  <source src="/images/personas-ecosystem.mp4" />
</video>

<!--
Secondly, we also launched a version of this for internal testing purposes. 

Teams have, like, a zillion test personas, which I've scribbled out, so you can't actually see them...

But any Betterment employee has access to this and can test run the app with any persona.
-->

---
layout: center
---

<div style="width: 882px; height: 61px; background-image:url(/images/personas-cli.gif); margin-bottom: -1px" />
<div style="width: 882px; height: 319px; background-image:url(/images/personas-cli.gif); background-position: bottom; margin-top: -1px" />

<!--
And we paired this with a developer CLI so that devs can generate personas in their local development environments.

In fact, this ended up replacing user seeds entirely, which cut down a bunch on the time it takes to reset our local databases.
-->

---
layout: center
---

<video muted autoplay width=222 height=480 style="width:222px;height:480px;">
  <source src="/images/personas-mobile.mp4" />
</video>

<img src="/images/iphone-front.png" class="absolute top-6" style="left:365px; width:251px;" />

<!--
Lastly, we also connected a test build of our **mobile app** to a Rails API backed by the same set of personas.

And so it's the same loading indicator that drops you right into the dashboard.
-->

---
layout: center
class: px-60
---

![incentives-everyone](/images/incentives-everyone.png)

<!--
And so now, talk about aligning incentives

we've been joined by PMs, designers, mobile engineers, and many other stakeholders across the company, all of whom are relying on this new demo environment -- and on this shared language of personas -- to collaborate and iterate on the Betterment product.
-->

---
layout: image
image: /images/demo-mode-usage.svg
---

# &nbsp;

<!--
And the internal usage of these demo apps has really only gone up over time.
-->

---
layout: image
image: /images/2022.svg
---

# &nbsp;

<!--
And so now it's 2022. And as you can see, my disembodied face, along with the rest of me, has made it here to RailsConf Portland.
-->

---
layout: iframe
url: http://localhost:3000/demo/sessions/new
class: bg-blue-50
---

<style>
    iframe {
        --margin: 2em;
        --scale: 0.76;
        width: calc(100% / var(--scale) - var(--margin) * 2) !important;
        height: calc(100% / var(--scale) - var(--margin) * 2) !important;
        position:absolute;
        left: calc(var(--margin) * var(--scale));
        top: calc(var(--margin) * var(--scale));
        transform-origin: 0 0;
        background-color: white;
        transform: scale(var(--scale));
    }
</style>

<!--
And Betterment still has our demo application.
As you can see, not much has changed.

Except, wait a minute, (DEMO DEMO DEMO)

Yes, that's right, this is a live app, embedded right here in my slide deck.

It would be ironic if I gave a talk about giving demos and didn't give at least a quick demo.

So we can click on this "see performance" link, and there's our fake market simulation. And when we log out, we're right back at that splash page.

Now, if this persona picker is something that you would want, for your app...
-->

---
layout: cover
background: /images/demo_mode_fancy.jpg
class: text-center font-mono
---

# gem 'demo_mode'
## github.com/Betterment/demo_mode

<!--
I'm excited to announce ... that
we've **open sourced** it, and the rest of our demo framework.

We've called the gem 'demo_mode'. it's available on Rubygems,
and on GitHub, where you'll instructions for setting it up.
-->

---
layout: center
class: px-40
---

<div class="text-center mb-5 text-blue-500 text-3xl"><strong>https://github.com/Betterment/demo_mode</strong></div>

<video muted autoplay style="border: 4px solid rgba(200, 200, 200, 0.5)">
  <source src="/images/demo_mode-github.mp4" />
</video>

<!--
Basically, it's a mountable Rails engine,
that you just drop into your app, you define a couple personas, and
then you launch the app in "demo mode"

You can pair it with WebValve, if you want, but you don't have to.
And you can use FactoryBot if you want, but you don't have to, if you have other ways of generating user accounts.
-->

---
layout: cover
background: /images/demo_mode_fancy.jpg
class: font-mono
---

# RAILS_ENV=demo

<p style="opacity:1.0">

<span style="opacity:0.5">Presented By:</span> **Nathan Griffith**  
<img src="/images/twitter.png" style="display:inline;width:20px" /> [@smudgethefirst](https://twitter.com/smudgethefirst) <img src="/images/github.png" style="display:inline;width:20px" /> [@smudge](https://github.com/smudge)

</p>

<span style="opacity:0.5">Slides and Errata:</span>  
**https://ngriffith.com/railsconf-2022**

=========================================

<span style="opacity:0.5">Referenced Projects:</span>  
https://github.com/Betterment/demo_mode  
https://github.com/Betterment/webvalve  
https://github.com/thoughtbot/factory_bot  
https://github.com/bblimke/webmock  

=========================================

<p style="opacity:0.5">

Slides made with [**Slidev**](https://sli.dev/) and [**Excalidraw**](https://excalidraw.com/)  

</p>

<QrCode :value="'https://ngriffith.com/railsconf-2022'" :size="350" margin="1" level="M" style="position:absolute; right:1.2em; bottom:1.2em; width: 7em; height: 7em; opacity:0.8" />

<!--
And that's all I have for you!

I've posted a copy of these slides at the link on _this_ slide.

And if you enjoyed this talk, and want to chat more, or if you're interested in learning more about demo_mode, or webvalve, or any of our other open source gems, come find me afterwards, or reach out to me online!

Thank you!

(time for questions?)

REPEAT THE QUESTION
-->
