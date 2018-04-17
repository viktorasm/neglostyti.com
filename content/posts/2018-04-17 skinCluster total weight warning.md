---
title: skinCluster & "The weight total would have exceeded 1.0" warning
slug: skincluster-weight-total-warning
date: 2018-04-17
type: post
---

When programmatically setting weights on Maya's skinCluster, you might encounter a warning:

```text
# Warning: Some weights could not be set to the specified value. The weight total would have exceeded 1.0. # 
```


So, clearly a bug in your code, right? This is what I was assuming, until the obvious hit me: "ok, let's find out the actual thresholds first".


Behold, a test harness:

```python
from maya import cmds

def test(testValue, expectationOk):
    cmds.file(new=True, force=True)
    p = cmds.polyPlane()[0]
    cmds.select(cl=True)
    j = cmds.joint()
    sc = cmds.skinCluster(j,p)[0]
    
    print "testing value: %03.19f" % testValue
    print "threshold is %03.19f" % abs(1.0-testValue)
    
    if expectationOk:
        print "expecting no warning..."
    else:
        print "expecting a warning..."
        
    cmds.skinPercent(sc, p+'.vtx[0]', transformValue=[(j, testValue)])
    print "---"

test(1.000000000000000000, True)    
test(1.000000000099999897, True)
test(1.000000000099999898, False)
test(0.999999999900000048, True)
test(0.999999999900000047, False)
```

The above code is pretty simple:

1. Create a simple scene: a mesh, one joint, bind to skin cluster;
2. Pick a random weight (near `1.0`) and set that on one vertex.
3. Depending how far from `1.0` it's been chosen, Maya will either produce the warning or not.
4. Play a little game finding the limits of when the warning is produced and when it is not.

Output produced was:

```text
testing value: 1.0000000000000000000
threshold is 0.0000000000000000000
expecting no warning...
---
testing value: 1.0000000000999997862
threshold is 0.0000000000999997862
expecting no warning...
---
testing value: 1.0000000001000000083
threshold is 0.0000000001000000083
expecting a warning...
# Warning: Some weights could not be set to the specified value. The weight total would have exceeded 1.0. # 
---
testing value: 0.9999999999000001027
threshold is 0.0000000000999998973
expecting no warning...
---
testing value: 0.9999999998999999917
threshold is 0.0000000001000000083
expecting a warning...
# Warning: Some weights could not be set to the specified value. The weight total would have exceeded 1.0. # 
---
```   

I'd say it's safe to assume that pseudo-formula Maya is using to produce the warning is:

```python
if abs(1.0-actual_sum_of_weights)>=0.0000000001:
  produce_a_warning()
```

Sounds like a pretty rough limit. Slightly higher errors should definitely not make a difference for mesh deformation.

Solution? Probably easiest is just to disable normalization in the skinCluster, if your weights setting code already takes care of that.

```$xslt
setAttr "skinCluster1.normalizeWeights" 0;
```
 
For now I guess I'll add an assertion checking the weights ngSkinTools is producing and see if I can tweak normalization algorithm to be a bit more precise.