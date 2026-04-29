---
theme: league
---
<!-- .slide: data-auto-animate -->
# The Middle Path

notes:
Okay, so my talk is titled the middle path.

---
<!-- .slide: data-auto-animate -->
# The Middle Path
## (with Claude Cowork)

notes:
With Claude Cowork.

---

![[the-middle-path-with-claude-cowork/claude-desktop-chat-tab.png]]

notes:
So if you open the Claude desktop app, you get Chat.

---

![[the-middle-path-with-claude-cowork/claude-desktop-code-tab.png]]

notes:
And you get the 'code' tab, if you don't want to use the CLI.
I still use the CLI but I've heard that the GitHub integration is pretty good here.
But we're not here to talk about that.

---

![[the-middle-path-with-claude-cowork/claude-desktop-cowork-tab.png]]

notes:
- but have you ever wondered what you can do with this _middle_ tab?
- I wasn't sure, and everything I'd read and heard said it was basically a worse version of the other two.
- But then I tried it, and I really liked it, so I wanted to share what worked for me!

---

![[the-middle-path-with-claude-cowork/cowork-new-project-dialog.png]]

notes:
- Set up a project designed to handle planning work. This sets up a local folder for you and it sandboxes the agents within that folder.

---

![[the-middle-path-with-claude-cowork/cowork-jira-triage-prompt.png]]

notes:
- Then I asked it to connect to Jira and triage my outstanding tasks.

---

![[the-middle-path-with-claude-cowork/cowork-sequencing-plan.png]]

notes:
- It immediately identified my top priority ticket.
- Amazing!
- Okay but, if you were gonna say, great now go implement that, stop.


---
<!-- .slide: data-auto-animate -->

## Don't: ask Cowork to implement

notes:
This is important.
I asked Cowork to produce a fix, and while it worked I walked away.
I got back and, because it's in a sandbox and wasn't able to run git commands, it had downloaded every file individually from `rake_stats` over HTTP. It then recondstructed a _fake_ git repository by hand in order to create a new commit, also by hand.

Not only did it burn like $20 in tokens, the files it produced could not actually be read by the real `git`.

So don't do that. Instead....

---
<!-- .slide: data-auto-animate -->

## Don't: ask Cowork to implement  
## Do: ask Cowork to plan

notes:
Ask cowork to plan. it's really good at sequencing the work, but it's not going to give you good local implementation decisions. hand that work off to Claude Code or other agents.

---

![[the-middle-path-with-claude-cowork/cowork-plan-request.png]]

notes:
So let's do that -- let's ask it to plan an implementation for the Jira ticket.

---

![[the-middle-path-with-claude-cowork/cowork-plan-output.png]]

notes:
It connected to both Glean and Jira and gathered what it needed to produce a plan.

---
<!-- .slide: data-auto-animate -->

```ruby
def path_regex
  regex_parts = path.split('*').map { |p| Regexp.escape(p) }
  Regexp.new(regex_parts.join('[\^\\/]+'))
end
```

notes:
It also0 identified the upstream code that needed to change

---
<!-- .slide: data-auto-animate -->

```ruby
def path_regex
  pattern = ''
  i = 0
  chars = path.chars
  while i < chars.length
    if chars[i] == '*' && chars[i + 1] == '*'
      pattern += '.*'
      i += 2
    elsif chars[i] == '*'
      pattern += '[\^/]+'
      i += 1
    else
      pattern += Regexp.escape(chars[i])
      i += 1
    end
  end
  Regexp.new("^#{pattern}$")
end
```

notes:
But like I said earlier, it proposed a kind of gnarly fix, and so I walked it back from that.

---
<!-- .slide: data-auto-animate -->

```ruby
def path_regex
  escaped = path.split('**').map do |segment|
    segment.split('*').map { |s| Regexp.escape(s) }.join('[\^/]+')
  end.join('.*')
 
  anchored = path.start_with?('/')
  prefix   = anchored ? '^' : '(?:^|/)'
  Regexp.new("#{prefix}#{escaped}$")
end
```

notes:
In a claude code context, I was able to produce a much more targeted fix.

It did require a bit of hand-off work, but this was acutally perfect, because it allowed me to automate the busy work and focus on the exact deliverable.

---

![[the-middle-path-with-claude-cowork/github-pr-description.png]]

notes:
- I personally still write my own PR descriptions, but more as proof to myself that I understand what I'm submitting for review.

---

![[the-middle-path-with-claude-cowork/cowork-close-jira-ticket.png]]

notes:
What I don't need to do ever again is log into Jira. (I think that's my goal now -- treat Jira as a database and never open the webapp again.)

---

### Claude Code + CLIs/MCPs?

notes:
- So why do this instead of asking claude code?
- Well claude code can definitely do this on a case by case basis. But claude code is also designed for task execution, not context management across a bunch of MCP connectors.
- Meanhwile, Cowork is designed to deal with context management. Everything it does is pre-prompted to treat working context as ephemeral and write memory files when it needs.

---

![[the-middle-path-with-claude-cowork/cowork-project-overview.png]]

notes:
So it's basically be an organization layer on top of your work. It burns more tokens for any given task, but it also manages memory and context across prompts, and it's really good at maintaining broad, situational awareness without degrading.

I even have it producing daily and weekly recaps over there in the "schduled" section.

---

![[the-middle-path-with-claude-cowork/obsidian-plan-view.png]]

notes:
And, finally, because it's writing markdown files, this means I can open up its entire brain in Obsidian and see what it's doing, or even overwrite its memories if I want to.

---

# Fin.
