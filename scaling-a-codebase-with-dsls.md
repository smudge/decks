<!-- DESIGNED FOR 'remark' -->
<!-- drop this into remarkjs.com/remarkise -->

# Scaling a Codebase with DSLs

by Nathan Griffith  
@smudge on github

---

What's a DSL?

???

Specifically talking about _internal_ DSLs, the things that look like...

---

[ActiveRecord example with has_many, belongs_to, validates, etc]

???

this, or...

---

[Routes example, with Rails.application.routes.draw, etc]

???

this.

---


Mix the "how" and "why" a bit,
because how to implement depends on what it is,
and what it is depends on why it exists - it exists to help your team:
- build thing faster
- avoid pitfalls and gotchas
- improve conceptual compression

and it works best with:
- well-explored problems
- repeated _structure_ in absence of 



Types of directives 

attribute-wrappers & method-definers
- these often overlap, but they enhance an object with new behaviors

type_cast_attr,
monetize_attr
steady_state
belongs_to

delegate_validations
persist_with
has_many



schemas
schema.rb
routes.rb
