---
title: Mirror influences in Maya rigs
slug: mirror-influences-maya-rigs
type: post
date: 2019-02-07
---


*TLDR version: if you're building animation or rigging tools for Maya, and you're interested in ways how people setup rigs to map their left and right joints, here's a summary of various ways spotted in the wild.*


One thing I wanted to fix for quite a while in ngSkinTools is how left side influences are matched to corresponding right side influences and vice versa. Standard Maya weight mirroring tools simply match by joint position, so I felt pretty good about also giving the option to match by name: if you have `L_clavicle` and `R_clavicle`, you just say *"I'm using L\_, R\_ as prefixes"*, ngSkinTools drops these prefixes and finds two joints named as "clavicle". 

A bit later an option to match by suffixes was also added, because some people like `clavicle_L` better than `L_clavicle`. And only recently I discovered that there's also naming schemes like `leg_L0_3_jnt` (looking at you, [mGear](http://www.mgear-framework.com/)!).

This all is enough to get this itch that relying on a naming convention is not the most reliable thing one would end up doing. I mobilized my Twitter swarm of field professionals asking what they do about this topic, and below is what came out of this (you can also see the [full thread here](https://twitter.com/viktorasm/status/1092688447955976193)).



## Naming convention

Coming up with a special name structure seems to be most prevalent, probably driven by the fact that you have to rename those `joint01`, `joint02` anyway.

Suffixes (`_L, _l, _lf, _R, _r, _rt`) or prefixes  (`L_, R_, lf_, rt_`) seem to be most common, but middle of the name isn't that rare (`leg_L0_3_jnt`, `arm_L_01_bnd`) as well.

In rare cases, "center" gets it's own prefix (`C_`) - could be a great way to distinguish between center and asymmetric (only present on one side of the rig) joints.

As a slight variation of naming convention, namespace could be used: `L_arm:_upper_1_JNT`. The person that gave this example said this is done to make renaming of modules easier (an prefix is a part of module name).
 
    
## Joint labeling

In joint's "Attribute editor" UI you can find a "Joint labeling" section where you can specify joint side, but most importantly, setting "Type" to "Other", you can specify a custom label:

```
setAttr "leg_L0_2_jnt.side" 1;
setAttr "leg_L0_2_jnt.type" 18;
setAttr -type "string" leg_L0_2_jnt.otherType "leg_2_jnt";
```

Later pairs can be matched by having same custom label. This isn't a very universal panacea as you can only do this for joints, but not other parts in your rig.
   
## Attribute connections

So far the most robust option in my opinion to have unambiguous links exactly the way you want. If you don't trust me, listen to [Siew Yi Liang](https://twitter.com/ylsiew/status/1093417883760115712):

> Message connections. Relying on naming conventions is a surefire way to increase your support burden with the number of degenerate cases that occur.

So far I've seen/heard:

* Each joint has a custom attribute added (e.g. "oppositeJoint"), and a connection is created to that from an opposite joint message attribute, e.g.: `L_joint.message -> R_joint.oppositeJoint`;
* "Hub" nodes providing links to left and right joints.
    
## Metadata

 
* Custom string attributes stating the name of the opposite joint (slight twist on message attribute)
* JSON/XML metadata on a central location (scene, rig root) - a twist on hub nodes with message connections. 
    

  
## Summary

I intend to expand the list as I find more examples. Let me know if you've come up with other creative ways or variations of the above!

