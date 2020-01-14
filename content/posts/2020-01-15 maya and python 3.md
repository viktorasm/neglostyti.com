---
title: Maya and Python 3
slug: maya-python-3
type: post
date: 2020-01-15
---

It's happening!

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Hey Pat, we put out a preview release to our beta community of Maya on Python 3. Check it out! :)</p>&mdash; TJ Galda (@tjgalda) <a href="https://twitter.com/tjgalda/status/1207458575435452416?ref_src=twsrc%5Etfw">December 19, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 

So.. the time has come for all who dish out large quantities of Python on Maya to start rejoicing (and worrying) about Python 3. Some of you, including myself, who will have to support few past versions of Maya on the same codebase simultaneously, probably scratching their heads now. It's not a transition period of few months, it's literally years of production. ngSkinTools, for example, still has Maya 2015 and 2016 users when Maya 2020 is already out.


Let's see what we have here:
* We probably want to support at least Maya 2017;
* Python is 2.7.x since at least Maya 2014, so.. at least Python 2.6 is out of the question;
* `six` is included only from Maya 2018


So where do we start