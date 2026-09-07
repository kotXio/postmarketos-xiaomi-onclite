# Tests

`onclite-usb-gadget-lifecycle-phase3b-test.sh` exercises the published
dispatcher and lifecycle helper against a synthetic configfs, role-switch and
UDC tree. It covers normal DEVICE binding, HOST refusal, the delayed role race
and DEVICE recovery without touching a phone.

Run it against a pmaports tree after applying
[`../patches/pmaports/`](../patches/pmaports/):

```sh
./tests/onclite-usb-gadget-lifecycle-phase3b-test.sh /path/to/pmaports
```
