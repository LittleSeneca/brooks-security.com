---
title: "Running a POC"
weight: 2
---

# How I run a POC

I have run technical evaluations from both ends: for prospects at Syxsense, and on the buying side at AvatarFleet, deciding whether a vendor's tool was going to survive our environment.

Most of the ones I have watched go badly did not go badly on the technology. They went badly because the evaluation started before anyone agreed what would count as success, and a few weeks in nobody could say whether it had worked. So the part I care most about happens before anything gets installed.

## Agreeing what "yes" looks like

I want three to five criteria written down, each specific enough that the customer and I can look at the same result and agree on whether it happened. Something with a system name and a threshold in it, rather than "improves our security posture."

That is harder than it sounds, and it is where discovery gets tested for real. A customer who cannot describe what would make them buy usually has not finished deciding internally, and running an evaluation into that burns a month. When I hit it I would rather go back to discovery than start the clock, though I will admit that is an easier position to hold when the pipeline is healthy than when it is not.

I also want to know who signs off besides my champion. In security tooling that list is longer than the champion tends to think: their security team, whoever owns budget, and some vendor-risk process that has not come up yet.

## While it runs

New requirements surface once people have hands on the product. I write them down and sort them into either this evaluation or the conversation after it. The point is not to refuse them, it is to stop the thing we agreed to be measured on from quietly changing underneath us.

I would rather test against their real environment than a clean one, even when that makes the POC look worse in week one. A tool that works on sample data and falls over on their actual log volume has not proven anything yet.

And I try to say early when something is not going to work, which costs less than it feels like it does at the time.

## The security review

This is where my background is most useful, and I would guess it is the part of a security sales cycle most SEs enjoy least.

Enterprise deals stall in vendor risk more often than they stall on features. A questionnaire arrives, or a request for a SOC 2 report and a penetration test summary, or a question about exactly what data leaves the customer's tenancy and where it lands. If the SE cannot engage with that substantively it goes into a queue, and the deal goes quiet for reasons that never show up in the CRM.

I have run that process from the other side: written the policies, built the controls, produced the evidence package, and taken a SOC 2 Type 2 through with no adverse findings. So I can usually tell a genuine blocker from a question the customer's template asks every vendor regardless of fit. That conversation goes faster when the person having it has filled the form out themselves.

## Closing it out

A short written result against each criterion, in language my champion can forward internally without editing it first. Including whatever did not work, because that surfaces whether I raise it or not, and I would rather it surfaced while I am in the room.

Then a clean handoff: what was configured, what was a POC shortcut that needs redoing for production, and what the first month should look like.

---

None of this is novel and most experienced SEs run some version of it. The part I would argue for is doing the criteria work properly even when everyone is impatient to start, because that is the step that gets skipped and it is the one that decides how the rest goes.
