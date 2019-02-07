---
title: Mirror influences in Maya rigs
slug: mirror-influences-maya-rigs
type: post
date: 2019-02-07
---

*TLDR version: if you're building animation or rigging tools for Maya, and you're interested in ways how people building rigs map their left and right joints, here's a summary of various ways spotted in the wild.*


One thing I wanted to fix quite a while in ngSkinTools is how left side influences are matched to corresponding right side influences and vice versa. Standard Maya weight mirroring tools simply match by joint position, so I felt pretty good about also giving the option to matchg by name: e.g. if you have `L_clavicle` and `R_clavicle`, you just say *"I'm using a L_, R_ as prefixes"*, ngSkinTools drop the prefixes and finds two joints named as "clavicle". 

A bit later an option to match by suffixes was also added, because some people like `clavicle_L` better than `clavicle_R`. Only recently I discovered that there's also naming schemes like `leg_L0_3_jnt` (looking at you, [mGear](http://www.mgear-framework.com/)!).

This all is enough to get this itch that relying on a naming convention is not the most reliable thing one would end up doing, so I mobilized my Twitter swarm of field professionals (see [full thread](https://twitter.com/viktorasm/status/1092688447955976193)) and this is what came out, sorted from most common:

1. Naming convention:
    * Suffixes seem to be most common (`_L, _l, _lf, _R, _r, _rt`)
    * Prefixes (`L_, R_, lf_, rt_`)
    * In rare cases, "center" gets it's own prefix (`C_`) - could be a great way to distinguish between center and asymmetric (only present on one side of the rig) joints 
    * Middle of the name - not that common, but mGear seems to do that as well as few other cases I've seen
    
2. Joint labeling. In joint's "Attribute editor" UI you can find a "Joint labeling" section where you can specify joint side, but most importantly, setting "Type" to "Other", you can specify a custom label:
   ```
   setAttr "leg_L0_2_jnt.side" 1;
   setAttr "leg_L0_2_jnt.type" 18;
   setAttr -type "string" leg_L0_2_jnt.otherType "leg_2_jnt";
   ```
   Later pairs can be matched by having same custom label. 
   
   This isn't a very universal panacea as you can only do this for joints, but not other parts in your rig.
   
3. Attribute connections. So far the most robust option in my opinion to have unambiguous links exactly the way you want. You if don't trust me, listen to [Siew Yi Liang](https://twitter.com/ylsiew/status/1093417883760115712):

   > Message connections. Relying on naming conventions is a surefire way to increase your support burden with the number of degenerate cases that occur.

   So far I've seen/heard:
    * Each joint has a custom attribute added (e.g. "oppositeJoint"), and a connection is created to that from an opposite joint message attribute, e.g.: `L_joint.message -> R_joint.oppositeJoint`;
    * "Hub" nodes providing links to left and right joints;
    
4. Metadata
   
   * Custom string attributes stating the name of the opposite joint (slight twist on message attribute)
   * JSON/XML metadata on a central location (scene, rig root) - a twist on hub nodes with message connections. 
    
4. Namespaces. A variation on a naming convention: `L_arm:_upper_1_JNT`
    

I intend to keep expanding the list - would be nice to hear what measures others are taking. Let me know!