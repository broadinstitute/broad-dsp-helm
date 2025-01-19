# install-secrets-manager

## Chart Details
This chart will install a custom CRD [secrets-manger](https://github.com/tuenti/secrets-manager)
## Installing the Chart

To install the chart with the release name `my-release`, the crd deploy is recommended to be done manually as helmv3 will mess it up from time to time :

```bash
kubectl apply -f https://raw.githubusercontent.com/tuenti/secrets-manager/master/config/crd/bases/secrets-manager.tuenti.io_secretdefinitions.yaml

$ helm install --name my-release datarepo-helm/install-secrets-manager
```

## Deleting the Charts

Delete the Helm deployment

```
$ helm delete my-release
```

## Build an Image
[secrets-manger](https://github.com/tuenti/secrets-manager) does not have an official image yet but you can build your own by running
```
curl -O https://raw.githubusercontent.com/tuenti/secrets-manager/master/Dockerfile

docker build . --tag secrets-manager:v1.0.2
```

Then you can overwrite the image repository and version field in the values.yaml

## Parameters

The following tables lists the configurable parameters of the install-secrets-manager chart and their default values.

|                   Parameter                   |                                                                                Description                                                                                |                            Default                            |
|-----------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|
| `installcrd.install`                        | This will install the charts version of the crd.yaml. It is reccomended you kubectl apply -f crd.yaml instead                                                                                                                                              | `false`                                                         |
| `image.repository`                        | The repository of the docker image for secret-manger. There is no official image so you must build your own.                                                                                                                                              | `nil`                                                         |
| `image.version`                        | The docker image tag for the version of the container you would like kubernetes to pull down                                                                                                                                              | `nil`                                                         |
| `vaultLocation`                        | URI path to your vault instance registry                                                                                                                                              | `nil`                                                         |
| `vaultAppRolePath`                        | Path of the Vault AppRole authentication backend                                                                                                                                              | `approle`                                                         |
| `vaultVersion`                        | vault key value version registry                                                                                                                                              | `kv2`                                                         |
| `serviceAccount.create`                        | If the kubernetes cluster has RBAC enabled and requires a Service account be created registry                                                                                                                                              | `false`                                                         |
| `serviceAccount.name`                        | If empty a random name will be created or if fill a specific name will be used registry                                                                                                                                              | `nil`                                                         |
| `rbac.create`                        | boolean to enable rbac permissions for kubernetes cluster registry                                                                                                                                              | `false`                                                         |
| `secretsgeneric.roleId`                        | plain text approle field to create app roleID kubernetes secret registry                                                                                                                                              | `nil`                                                         |
| `secretsgeneric.secretId`                        | plain text approle field to create app secretID kubernetes secret                                                                                                                                              | `nil`                                                         |
| `existingSecret`                        |  If using a pre existing kubernetes secret fill in this field key                                                                                                                                               | `nil`                                                         |
| `existingRoleIdKey`                        | If using a pre existing kubernetes secret fill in this field with a kube secret key for roleID                                                                                                                                               | `nil`                                                         |
| `existingSecretIdKey`                        | If using a pre existing kubernetes secret fill in this field with a kube secret key for secretID                                                                                                                                               | `nil`                                                         |
