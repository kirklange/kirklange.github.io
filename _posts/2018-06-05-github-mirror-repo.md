---
published:  true
layout:     post
title:      Mirror Your GitLab Repos on GitHub
date:       2018-06-05 21:00
author:     Kirk Lange
summary:    Leaving GitHub but still want to keep your repos up-to-date?
categories: how-to
thumbnail:  fab fa-gitlab
redditurl:  7deu8p
twitterurl: 961084879432597504
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
maybe the GitHub vs GitLab discussion will become a religious debate like tabs
vs spaces &mdash; the last thing I'd want to get into while networking.

After sleeping on it, I decided the best solution would be to have GitHub
mirror all my GitLab repositories. But how?! (Unlike GitLab, GitHub does not
have a "Mirror Repository" option when creating a new project.)

# Solution

As it turns out, git allows you to push to multiple URLs simply by adding
one line to your `.git/config`! Here is the relevant excerpt from this
website's repo.

```
[remote "origin"]
    url = git@gitlab.com:kirklange/kirklange.gitlab.io.git
    url = git@github.com:kirklange/kirklange.github.io.git
    fetch = +refs/heads/*:refs/remotes/origin/*
```

Notice how there are two URLs. Whenever you execute `git push` or `git pull`,
it does so for each one. Even if you are pushing to two remote repos that
aren't in sync, git will account for this and push to what is necessary for
each repo. In other words, if you've only been pushing to GitLab since you
switched, your GitHub repo will catch up like nothing ever happened. (Your
green squares should even sync up!)

Alternately, you can run this command instead of modifying `.git/config`
directly. It does the exact same thing.

```
git remote set-url origin --add user@example.com:my/repo.git
```

If you *don't* need the ability to pull from your secondary repo, you'll want
your `.git/config` to be of this format.

```
[remote "origin"]
    url = git@gitlab.com:kirklange/kirklange.gitlab.io.git
    fetch = +refs/heads/*:refs/remotes/origin/*
    pushurl = git@gitlab.com:kirklange/kirklange.gitlab.io.git
    pushurl = git@github.com:kirklange/kirklange.github.io.git
```

In fact, it's probably best to not pull from your secondary repo in order to
avoid the headache of having to merge the two. Afterall, the goal here is only
to have the GitHub repo act as a mirror.

# Disclaimer

Fine, this is technically not "mirroring", but until Microsoft catches up to
GitLab, this is the best we can do. Please let me know if you have a better
solution. Thanks!

# Source

* <a href="https://stackoverflow.com/questions/849308" target="_blank">Stack Overflow: pull/push from multiple remote locations</a>
