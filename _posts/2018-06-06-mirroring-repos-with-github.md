---
published:  true
layout:     post
title:      Mirroring Repos with GitHub
date:       2018-06-06 13:00
author:     Kirk Lange
summary:    Leaving GitHub but still want to keep your repos up-to-date?
categories: how-to
thumbnail:  far fa-clone
redditurl:  github/comments/8p4ign
twitterurl: 1004476754029760512
tags:
 - gitlab
 - github
 - git
 - mirror
 - repo
 - repository
 - microsoft
---

As I was migrating from GitHub to GitLab on Monday[*](#addendum), I began to
imagine the awkward conversation I would have if I was ever in a Microsoft
interview. Heck, the GitHub vs GitLab discussion feels like it's on its way to
becoming a religious debate like tabs vs spaces &mdash; the last thing I'd want
to get into while networking.

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
GitLab in terms of its extra features, this is the best we can do. Please let
me know if you have a better solution. If anything comes up, I'll make sure to
update this post and give credit. Thanks!

# Source

* <a href="https://stackoverflow.com/questions/849308" target="_blank">Stack Overflow: pull/push from multiple remote locations</a>

<br>
# *Addendum
*<small>The real reason I switched to GitLab (for now).</small>*

I don't give a damn whether GitLab is hosted on Azure or Google Cloud. I am
well aware that Microsoft isn't going to claim my code and that they don't care
about my rushed AI class project that is in freakin' C89 for no good reason.
What I care about most is how easily I can host, share, document, and test my
projects.

In the past couple of years, I've been moving away from Microsoft software in
general, going from Visual C++, Visual Studio, and Windows, to GNU, Vim, and
(at least on my laptop) Ubuntu. The aquisition prompted me to revisit GitLab
because I wasn't sure whether Microsoft would move the platform in a direction
that I would be interested in. Earlier this year, a classmate introduced me to
GitLab but I brushed it off because I didn't understand all that it had to
offer.

After importing a couple projects to GitLab and tinkering around a bit, I was
pleasantly surprised. A couple pet peeves I had with GitHub like pull request
permissions and of course the ability to host private repositories were solved
with GitLab. Additionally, having CI built right in to GitLab is pretty nice
since I use it extensively to run unit and cross-platform compatability tests.
That is not to say that GitLab doesn't have its own issues. I definitely may
find more in the future as it's only my 3rd day using GitLab, but I figure
where's the harm in trying it out for a couple weeks?

Thanks to the fact that I'm pushing all my repo changes to both GitHub and
GitLab, I can easily switch my main platform at will. If GitLab has another
<a target="_blank" href="https://about.gitlab.com/2017/02/10/postmortem-of-database-outage-of-january-31/">database outage</a>,
no big deal, most of what I care about is probably still on my local machine or
on GitHub. If Microsoft ruins GitHub for me, also no big deal. The more options
the better, for both me and the people I am sharing my code with.
