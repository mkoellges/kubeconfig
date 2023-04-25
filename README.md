# kubeconfig

 repo helping us to manage a share a cluster

## How to use it

* `git clone` the repo
* run ./helper-script.sh to create your team's directory with namespace files
* push it to the repo and create a MR
* we will use the "Run Pipeline" button putting your team's variable:
`TEAM: name`
* config files will be ready to download after pipeline is successfully finished

## Caveeats

* do not use `Service: LoadBalancer`! expose applications with `Ingress` resource
* you can use `storageClass: openebs-jiva-default`
