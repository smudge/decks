def will_this_work?
  # I think so, but first:
  safety.preheat!

  # okay, now we're good:
  if safety.preheated? && readiness.ensured?

    # We need to run this line so that the
    # backend system hears us coming
    fi_fi_fo_fum!

    # okay, now we're ready
    result = ask_the_internt('what is the result?')

    if result.good?
      # this is what happens most of the time
      return humanize(result)

    elsif result.bad?
      # I think this happens only when the internet
      # is having a bad day

      return "having a bad day"
    end
  end
rescue ThisShouldNotHappenException
  logger.log("this should not have happened")
  raise
end
