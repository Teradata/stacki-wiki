## enable host channel

### Usage

`stack enable host channel {channel} [host ...]`

### Description

Enables forwarding of a Message Queue channel for a given
        host.  By default only the 'alert' channel is forwarded from
        all nodes.

### Arguments

* `[channel]`
* `{host}`

   Zero, one or more host names. If no host names are supplied, the
        channel is enabled on all hosts.


### Examples

* `stack enable host channel backend-0-0 channel=debug`

   Enable forwarding of the debug channel from backend-0-0.



