# Sensor Registry r4 aport

This is the postmarketOS v26.06 aport used for
`sns-reg-0.1_git20250706-r4` and its `sns-reg-systemd` subpackage.

The six patches extend public `sns-reg` commit
`4d238e5f0baba3fb77456fe2bffbf8e8f18a71a0` with robust parsing, MSM8953
registry maps, padding-key bounds protection and a root-only runtime service.

No phone registry is included. At runtime the service converts the registry
already present on that handset into a root-only file under `/run`.
