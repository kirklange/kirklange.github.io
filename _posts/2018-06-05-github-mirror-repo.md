---
published:  true
layout:     post
title:      Mirror Your GitLab Repos on GitHub
date:       2018-06-05 21:00
author:     Kirk Lange
summary:    Leaving GitHub but still want to keep your repos up-to-date?
categories: how-to
thumbnail:  fab fa-gitlab
redditurl:  
twitterurl:
tags:
 - gitlab
 - github
 - git
 - mirror
 - repo
 - repository
 - microsoft
---

As I was migrating from GitHub to GitLab on Monday, I began to imagine the
awkward conversation I would have if I was ever in a Microsoft interview. Heck,
the GitHub vs GitLab discussion could become a religious debate like tabs vs
spaces depending on who you talk to &mdash; the last thing I'd want to get into
while networking.

After sleeping on it, I decided the best solution would be to have GitHub
mirror all my GitLab repositories. That way, anyone I'm showing my code to can
use their prefered platform and I don't have to risk getting into an argument.
Only problem is, unlike GitLab, GitHub does not have a "Mirror Repository"
option when creating a new project... Time for a work-around!

# Solution

As it turns out, git allows you to push to multiple URLs simply by adding
one line to your `.git/config`! Here is the relevant excerpt from
<a target="_blank" href="https://gitlab.com/kirklange/kirklange.gitlab.io">
this website's repo</a>.

```
[remote "origin"]
    url = git@gitlab.com:kirklange/kirklange.gitlab.io.git
    fetch = +refs/heads/*:refs/remotes/origin/*
    pushurl = git@gitlab.com:kirklange/kirklange.gitlab.io.git
    pushurl = git@github.com:kirklange/kirklange.github.io.git
```

Whenever you execute `git push`, it pushes to each `pushurl`. Even if you are
pushing to two remote repos that aren't in sync, git will account for this and
push what is necessary to each repo. In other words, if you've only been
pushing to GitLab since you switched, your GitHub repo will catch up like
nothing ever happened. (Even your green squares should sync up!)

If you also want the ability to *pull* from your secondary repo, you'll want
your `.git/config` to be of this format.

```
[remote "origin"]
    url = git@gitlab.com:kirklange/kirklange.gitlab.io.git
    url = git@github.com:kirklange/kirklange.github.io.git
    fetch = +refs/heads/*:refs/remotes/origin/*
```

However, it's probably best not to pull from your secondary repo as to
mitigate the chances of having to tediously merge the two. Afterall, the goal
here is only to have the GitHub repo act as a mirror.

# Disclaimer

Fine, this is technically not "mirroring", but until Microsoft catches up to
GitLab and earns our trust (if at all), this is the best we can do. Please let
me know if you have a better solution. If anything comes up, I'll make sure to
update this post and give credit. Thanks!

# Source

* <a href="https://stackoverflow.com/questions/849308" target="_blank">Stack Overflow: pull/push from multiple remote locations</a>
