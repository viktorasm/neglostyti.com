---
title: Maya compiler versions
slug: maya-compiler-versions
date: 2018-04-15
type: post
---

Working on ngSkinTools.com plugin, one complication I face almost constantly is properly compiling C++ plugin for multiple Maya and operating system combinations. While I often hear from other plugin developers that it does not matter much and using latest compiler works, that's not the usual case for me.

Some examples:

* File saving/loading on Windows will crash because of [MPxData](http://help.autodesk.com/view/MAYAUL/2017/ENU/?guid=__cpp_ref_class_m_px_data_html) API. Solution: stick to recommended compiler version for each specific Maya release. 
    
* Compiling Linux binaries on something like Ubuntu with newer CLib will not load the plugin for users that stick to Autodesk's recommended CentOS version. Solution: build on CentOS 6.5 VM.

The only way that precise compiler and library versions are reported by Autodesk is through  [Cyrille Fauvel's blog](http://around-the-corner.typepad.com/adn/cyrille-fauvel.html): see [the post for Maya 2018](http://around-the-corner.typepad.com/adn/2018/02/compiler-versions-for-maya-2018.html). 

Also, I was really missing an overview of C++11 and C++14 support.

With the above in mind, I came up with this spreadsheet. Mostly just a summary of Cyrille's published info, and some analysis on C++ features as reported by each specific compiler. 

[Open in google spreadsheets for easier viewing](https://docs.google.com/spreadsheets/d/1spyonFkqO7CsTaCE7rdpsoBBhnlSB-9kJca869i2YGc/edit?usp=sharing)

<iframe style="width: 100%; height: 400px" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTiO9Ii6brQf3thxa4o3Xgi4kPnnoTuiRUFtho0NxcEs40zpI5jVjp_z5dMxTdtg85kjb_We5-aM-gQ/pubhtml?widget=false&amp;headers=false&amp;chrome=false"></iframe>
 
 
