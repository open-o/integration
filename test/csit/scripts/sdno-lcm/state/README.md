README: Script usage
====================

I. Service State
---

### I.1 service_state.sh
A script to check service state. For given uuid (network service id) there is four different states:

 | action\state     | lifecycleState | actionState |
 |:----------------:|:--------------:|:-----------:|
 | __Creation__     | *created*      | *none*      |
 | __Instantiation__| *deployed*     | *deploying* |
 | __Terminate__    | *created*      | *normal*    |
 | __Delete__       | *null*         | *null*      |

the script output are `lifecycleState.actionState={created.none or deployed.deploying or created.normal or null.null}`

### I.2 Usage
` service_state.sh <MSB_ADDR[ipv4:port]> <NSINSTANCEID[uuid]>`