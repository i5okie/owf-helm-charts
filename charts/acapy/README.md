# acapy

![Version: 0.3.0](https://img.shields.io/badge/Version-0.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.3.1](https://img.shields.io/badge/AppVersion-1.3.1-informational?style=flat-square)

A Helm chart for ACA-Py - A Cloud Agent - Python

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| esune | <emiliano.sune@quartech.com> | <https://github.com/esune> |
| i5okie | <ivan.polchenko@quartech.com> | <https://github.com/i5okie> |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami/ | common | 2.31.3 |
| https://charts.bitnami.com/bitnami/ | postgresql | 15.5.38 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| "argfile.yml".admin-insecure-mode | bool | `false` |  |
| "argfile.yml".auto-accept-invites | bool | `true` |  |
| "argfile.yml".auto-accept-requests | bool | `true` |  |
| "argfile.yml".auto-create-revocation-transactions | bool | `false` |  |
| "argfile.yml".auto-ping-connection | bool | `true` |  |
| "argfile.yml".auto-promote-author-did | bool | `true` |  |
| "argfile.yml".auto-provision | bool | `true` |  |
| "argfile.yml".auto-request-endorsement | bool | `false` |  |
| "argfile.yml".auto-respond-credential-offer | bool | `true` |  |
| "argfile.yml".auto-respond-credential-proposal | bool | `false` |  |
| "argfile.yml".auto-respond-credential-request | bool | `false` |  |
| "argfile.yml".auto-respond-messages | bool | `true` |  |
| "argfile.yml".auto-respond-presentation-proposal | bool | `true` |  |
| "argfile.yml".auto-respond-presentation-request | bool | `false` |  |
| "argfile.yml".auto-store-credential | bool | `true` |  |
| "argfile.yml".auto-verify-presentation | bool | `false` |  |
| "argfile.yml".auto-write-transactions | bool | `false` |  |
| "argfile.yml".emit-new-didcomm-mime-type | bool | `true` |  |
| "argfile.yml".emit-new-didcomm-prefix | bool | `true` |  |
| "argfile.yml".endorser-alias | string | `"endorser"` |  |
| "argfile.yml".endorser-protocol-role | string | `"author"` |  |
| "argfile.yml".genesis-transactions-list | string | `"/tmp/ledgers.yml"` |  |
| "argfile.yml".log-level | string | `"info"` |  |
| "argfile.yml".monitor-ping | bool | `false` |  |
| "argfile.yml".multitenant | bool | `false` |  |
| "argfile.yml".multitenant-admin | bool | `false` |  |
| "argfile.yml".notify-revocation | bool | `false` |  |
| "argfile.yml".preserve-exchange-records | bool | `true` |  |
| "argfile.yml".public-invites | bool | `false` |  |
| "argfile.yml".read-only-ledger | bool | `true` |  |
| "argfile.yml".requests-through-public-did | bool | `false` |  |
| "argfile.yml".wallet-local-did | bool | `true` |  |
| "argfile.yml".wallet-name | string | `"askar-wallet"` |  |
| "argfile.yml".wallet-storage-type | string | `"postgres_storage"` |  |
| "argfile.yml".wallet-type | string | `"askar"` |  |
| "argfile.yml".webhook-url | string | `"{{- printf \"%s/webhooks\" (include \"acapy.agent.url\" .) }}"` |  |
| "ledgers.yml"[0].endorser_alias | string | `"bcovrin-test-endorser"` |  |
| "ledgers.yml"[0].endorser_did | string | `"DfQetNSm7gGEHuzfUvpfPn"` |  |
| "ledgers.yml"[0].genesis_url | string | `"http://test.bcovrin.vonx.io/genesis"` |  |
| "ledgers.yml"[0].id | string | `"bcovrin-test"` |  |
| "ledgers.yml"[0].is_production | bool | `true` |  |
| "ledgers.yml"[0].is_write | bool | `true` |  |
| "plugin-config.yml" | object | `{}` |  |
| adminUrl | string | `""` |  |
| affinity | object | `{}` |  |
| agentUrl | string | `""` |  |
| automountServiceAccountToken | bool | `false` |  |
| autoscaling.behavior.scaleDown.policies[0].periodSeconds | int | `300` |  |
| autoscaling.behavior.scaleDown.policies[0].type | string | `"Pods"` |  |
| autoscaling.behavior.scaleDown.policies[0].value | int | `1` |  |
| autoscaling.behavior.scaleDown.selectPolicy | string | `"Max"` |  |
| autoscaling.behavior.scaleDown.stabilizationWindowSeconds | int | `120` |  |
| autoscaling.behavior.scaleUp.policies | list | `[]` |  |
| autoscaling.behavior.scaleUp.selectPolicy | string | `"Max"` |  |
| autoscaling.behavior.scaleUp.stabilizationWindowSeconds | int | `60` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `10` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| commonAnnotations | object | `{}` |  |
| commonLabels | object | `{}` |  |
| containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| containerSecurityContext.enabled | bool | `true` |  |
| containerSecurityContext.privileged | bool | `false` |  |
| containerSecurityContext.readOnlyRootFilesystem | bool | `true` |  |
| containerSecurityContext.runAsGroup | int | `1001` |  |
| containerSecurityContext.runAsNonRoot | bool | `true` |  |
| containerSecurityContext.runAsUser | int | `1001` |  |
| containerSecurityContext.seLinuxOptions | object | `{}` |  |
| containerSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| extraArgs | list | `[]` |  |
| extraDeploy | list | `[]` |  |
| extraEnvVars | list | `[]` |  |
| extraEnvVarsCM | string | `""` |  |
| extraEnvVarsSecret | string | `""` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| global.compatibility.openshift.adaptSecurityContext | string | `"auto"` |  |
| global.defaultStorageClass | string | `""` |  |
| global.imagePullSecrets | list | `[]` |  |
| global.imageRegistry | string | `""` |  |
| global.security.allowInsecureImages | bool | `false` |  |
| image.digest | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.pullSecrets | list | `[]` |  |
| image.registry | string | `"ghcr.io"` |  |
| image.repository | string | `"openwallet-foundation/acapy-agent"` |  |
| image.tag | string | `"py3.12-1.3.1"` |  |
| ingress.admin.annotations | object | `{}` |  |
| ingress.admin.enabled | bool | `false` |  |
| ingress.admin.extraHosts | list | `[]` |  |
| ingress.admin.extraPaths | list | `[]` |  |
| ingress.admin.extraRules | list | `[]` |  |
| ingress.admin.extraTls | list | `[]` |  |
| ingress.admin.hostname | string | `"admin.acapy.local"` |  |
| ingress.admin.ingressClassName | string | `""` |  |
| ingress.admin.path | string | `"/"` |  |
| ingress.admin.pathType | string | `"ImplementationSpecific"` |  |
| ingress.admin.secrets | list | `[]` |  |
| ingress.admin.selfSigned | bool | `false` |  |
| ingress.admin.tls | bool | `false` |  |
| ingress.agent.annotations | object | `{}` |  |
| ingress.agent.enabled | bool | `false` |  |
| ingress.agent.extraHosts | list | `[]` |  |
| ingress.agent.extraPaths | list | `[]` |  |
| ingress.agent.extraRules | list | `[]` |  |
| ingress.agent.extraTls | list | `[]` |  |
| ingress.agent.hostname | string | `"acapy.local"` |  |
| ingress.agent.ingressClassName | string | `""` |  |
| ingress.agent.path | string | `"/"` |  |
| ingress.agent.pathType | string | `"ImplementationSpecific"` |  |
| ingress.agent.publicScheme | string | `"https"` |  |
| ingress.agent.secrets | list | `[]` |  |
| ingress.agent.selfSigned | bool | `false` |  |
| ingress.agent.tls | bool | `false` |  |
| initContainers | list | `[]` |  |
| kubeVersion | string | `""` |  |
| livenessProbe.failureThreshold | int | `6` |  |
| livenessProbe.httpGet.path | string | `"/status/live"` |  |
| livenessProbe.httpGet.port | string | `"admin"` |  |
| livenessProbe.initialDelaySeconds | int | `30` |  |
| livenessProbe.periodSeconds | int | `20` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `10` |  |
| multitenancyConfiguration.json | string | `""` |  |
| multitenancyConfiguration.wallet_type | string | `"single-wallet-askar"` |  |
| nameOverride | string | `""` |  |
| namespaceOverride | string | `""` |  |
| networkPolicy.addExternalClientAccess | bool | `true` |  |
| networkPolicy.allowExternal | bool | `true` |  |
| networkPolicy.allowExternalEgress | bool | `true` |  |
| networkPolicy.enabled | bool | `true` |  |
| networkPolicy.extraEgress | list | `[]` |  |
| networkPolicy.extraIngress | list | `[]` |  |
| networkPolicy.ingressNSMatchLabels | object | `{}` |  |
| networkPolicy.ingressNSPodMatchLabels | object | `{}` |  |
| networkPolicy.ingressPodMatchLabels | object | `{}` |  |
| nodeAffinityPreset.key | string | `""` |  |
| nodeAffinityPreset.type | string | `""` |  |
| nodeAffinityPreset.values | list | `[]` |  |
| nodeSelector | object | `{}` |  |
| persistence.accessModes[0] | string | `"ReadWriteMany"` |  |
| persistence.annotations | object | `{}` |  |
| persistence.enabled | bool | `true` |  |
| persistence.existingClaim | string | `""` |  |
| persistence.size | string | `"1Gi"` |  |
| persistence.storageClass | string | `""` |  |
| podAffinityPreset | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podAntiAffinityPreset | string | `"soft"` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.enabled | bool | `true` |  |
| podSecurityContext.fsGroup | int | `1001` |  |
| podSecurityContext.fsGroupChangePolicy | string | `"Always"` |  |
| podSecurityContext.supplementalGroups | list | `[]` |  |
| podSecurityContext.sysctls | list | `[]` |  |
| postgresql.architecture | string | `"standalone"` |  |
| postgresql.auth.database | string | `""` |  |
| postgresql.auth.enablePostgresUser | bool | `true` |  |
| postgresql.auth.existingSecret | string | `""` |  |
| postgresql.auth.username | string | `"acapy"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.image.registry | string | `"docker.io"` |  |
| postgresql.image.repository | string | `"bitnamilegacy/postgresql"` |  |
| postgresql.image.tag | string | `"16.4.0-debian-12-r14"` |  |
| postgresql.primary.containerSecurityContext.enabled | bool | `false` |  |
| postgresql.primary.extendedConfiguration | string | `"max_connections = 500\n"` |  |
| postgresql.primary.persistence.enabled | bool | `true` |  |
| postgresql.primary.persistence.size | string | `"1Gi"` |  |
| postgresql.primary.podSecurityContext.enabled | bool | `false` |  |
| postgresql.primary.resources | object | `{}` |  |
| postgresql.primary.resourcesPreset | string | `"nano"` |  |
| readinessProbe.failureThreshold | int | `6` |  |
| readinessProbe.httpGet.path | string | `"/status/ready"` |  |
| readinessProbe.httpGet.port | string | `"admin"` |  |
| readinessProbe.initialDelaySeconds | int | `5` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| resourcesPreset | string | `"none"` |  |
| secrets.api.existingSecret | string | `""` |  |
| secrets.api.retainOnUninstall | bool | `true` |  |
| secrets.api.secretKeys.adminApiKey | string | `"adminApiKey"` |  |
| secrets.api.secretKeys.jwtKey | string | `"jwt"` |  |
| secrets.api.secretKeys.walletKey | string | `"walletKey"` |  |
| secrets.api.secretKeys.webhookapiKey | string | `"webhookapi"` |  |
| secrets.seed.enabled | bool | `true` |  |
| secrets.seed.existingSecret | string | `""` |  |
| secrets.seed.retainOnUninstall | bool | `true` |  |
| secrets.seed.secretKeys.seed | string | `"seed"` |  |
| service.annotations | object | `{}` |  |
| service.clusterIP | string | `""` |  |
| service.externalTrafficPolicy | string | `"Cluster"` |  |
| service.extraPorts | list | `[]` |  |
| service.loadBalancerIP | string | `""` |  |
| service.loadBalancerSourceRanges | list | `[]` |  |
| service.nodePorts.admin | string | `""` |  |
| service.nodePorts.http | string | `""` |  |
| service.nodePorts.ws | string | `""` |  |
| service.ports.admin | int | `8022` |  |
| service.ports.http | int | `8021` |  |
| service.ports.ws | int | `8023` |  |
| service.sessionAffinity | string | `"None"` |  |
| service.sessionAffinityConfig | object | `{}` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automountServiceAccountToken | bool | `false` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |
| topologySpreadConstraints | list | `[]` |  |
| updateStrategy.type | string | `"RollingUpdate"` |  |
| walletStorageConfig.json | string | `""` |  |
| walletStorageConfig.max_connections | int | `10` |  |
| walletStorageConfig.url | string | `""` |  |
| walletStorageConfig.wallet_scheme | string | `"DatabasePerWallet"` |  |
| walletStorageCredentials.account | string | `"acapy"` |  |
| walletStorageCredentials.admin_account | string | `"postgres"` |  |
| walletStorageCredentials.admin_password | string | `""` |  |
| walletStorageCredentials.existingSecret | string | `""` |  |
| walletStorageCredentials.json | string | `""` |  |
| walletStorageCredentials.secretKeys.adminPasswordKey | string | `"postgres-password"` |  |
| walletStorageCredentials.secretKeys.userPasswordKey | string | `"password"` |  |
| websockets.enabled | bool | `false` |  |
| websockets.publicUrl | string | `""` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
