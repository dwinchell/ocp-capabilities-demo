# A Demo of OpenShift Container Platform Capabilities

## Setup

```
./setup.sh
```

## Zero Downtime Deployments

```
oc patch deployment/bogohttp --patch '{"spec": {"template": {"spec": {"containers": [{"name": "bogohttp", "image": "quay.io/dwinchell_redhat/bogohttp:v2.0.ppcle64"}]}}}}'
```


