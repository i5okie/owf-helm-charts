# vc-authn-oidc

![Version: 0.4.6](https://img.shields.io/badge/Version-0.4.6-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.3.1](https://img.shields.io/badge/AppVersion-2.3.1-informational?style=flat-square)

A Helm chart to deploy ACAPy VC-AuthN on OpenShift

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| esune | <emiliano.sune@quartech.com> | <https://github.com/esune> |
| i5okie | <ivan.polchenko@quartech.com> | <https://github.com/i5okie> |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 2.x.x |
| https://charts.bitnami.com/bitnami | mongodb | 16.4.1 |
| https://openwallet-foundation.github.io/helm-charts/ | acapy | 0.2.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| acapy."argfile.yml".admin-insecure-mode | bool | `false` |  |
| acapy."argfile.yml".auto-accept-invites | bool | `true` |  |
| acapy."argfile.yml".auto-accept-requests | bool | `true` |  |
| acapy."argfile.yml".auto-ping-connection | bool | `true` |  |
| acapy."argfile.yml".auto-provision | bool | `true` |  |
| acapy."argfile.yml".auto-respond-credential-offer | bool | `true` |  |
| acapy."argfile.yml".auto-respond-messages | bool | `true` |  |
| acapy."argfile.yml".auto-verify-presentation | bool | `true` |  |
| acapy."argfile.yml".genesis-transactions-list | string | `"/tmp/ledgers.yml"` |  |
| acapy."argfile.yml".log-level | string | `"info"` |  |
| acapy."argfile.yml".monitor-ping | bool | `true` |  |
| acapy."argfile.yml".multitenant | bool | `false` |  |
| acapy."argfile.yml".multitenant-admin | bool | `false` |  |
| acapy."argfile.yml".public-invites | bool | `true` |  |
| acapy."argfile.yml".read-only-ledger | bool | `true` |  |
| acapy."argfile.yml".wallet-local-did | bool | `true` |  |
| acapy."argfile.yml".wallet-name | string | `"askar-wallet"` |  |
| acapy."argfile.yml".wallet-storage-type | string | `"postgres_storage"` |  |
| acapy."argfile.yml".wallet-type | string | `"askar"` |  |
| acapy."ledgers.yml" | string | `"- id: BCovrinTest\n  is_production: true\n  genesis_url: \"http://test.bcovrin.vonx.io/genesis\"\n- id: SovrinStagingNet\n  is_production: true\n  genesis_url: \"https://raw.githubusercontent.com/sovrin-foundation/sovrin/stable/sovrin/pool_transactions_sandbox_genesis\"\n- id: CANdyDev\n  is_production: true\n  genesis_url: \"https://raw.githubusercontent.com/ICCS-ISAC/dtrust-reconu/main/CANdy/dev/pool_transactions_genesis\"\n- id: CANdyTest\n  is_production: true\n  is_write: true\n  genesis_url: \"https://raw.githubusercontent.com/ICCS-ISAC/dtrust-reconu/main/CANdy/test/pool_transactions_genesis\""` |  |
| acapy.adminUrl | string | `""` |  |
| acapy.agentUrl | string | `""` |  |
| acapy.autoscaling.enabled | bool | `true` |  |
| acapy.autoscaling.maxReplicas | int | `100` |  |
| acapy.autoscaling.minReplicas | int | `1` |  |
| acapy.autoscaling.stabilizationWindowSeconds | int | `300` |  |
| acapy.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| acapy.autoscaling.targetMemoryUtilizationPercentage | string | `""` |  |
| acapy.enabled | bool | `true` |  |
| acapy.image.pullPolicy | string | `"IfNotPresent"` |  |
| acapy.image.pullSecrets | list | `[]` |  |
| acapy.image.registry | string | `"ghcr.io"` |  |
| acapy.image.repository | string | `"openwallet-foundation/acapy-agent"` |  |
| acapy.image.tag | string | `"py3.12-1.3.1"` |  |
| acapy.ingress.admin.enabled | bool | `false` |  |
| acapy.ingress.admin.hostname | string | `"admin.vc-authn-oidc-acapy.local"` |  |
| acapy.ingress.agent.enabled | bool | `false` |  |
| acapy.ingress.agent.hostname | string | `"vc-authn-oidc-acapy.local"` |  |
| acapy.ingress.agent.publicScheme | string | `"https"` |  |
| acapy.networkPolicy.allowExternal | bool | `false` |  |
| acapy.networkPolicy.enabled | bool | `true` |  |
| acapy.networkPolicy.ingressNSMatchLabels."network.openshift.io/policy-group" | string | `"ingress"` |  |
| acapy.postgresql.commonLabels."app.kubernetes.io/role" | string | `"wallet"` |  |
| acapy.replicaCount | int | `1` |  |
| acapy.resources.limits | object | `{}` |  |
| acapy.resources.requests.cpu | string | `"250m"` |  |
| acapy.resources.requests.memory | string | `"384Mi"` |  |
| acapy.secrets.api.existingSecret | string | `""` |  |
| acapy.secrets.api.retainOnUninstall | bool | `true` |  |
| acapy.secrets.api.secretKeys.adminApiKey | string | `"adminApiKey"` |  |
| acapy.secrets.api.secretKeys.jwtKey | string | `"jwt"` |  |
| acapy.secrets.api.secretKeys.walletKey | string | `"walletKey"` |  |
| acapy.secrets.api.secretKeys.webhookapiKey | string | `"webhookapi"` |  |
| acapy.secrets.seed.existingSecret | string | `""` |  |
| acapy.secrets.seed.retainOnUninstall | bool | `true` |  |
| acapy.secrets.seed.secretKeys.seed | string | `"seed"` |  |
| acapy.service.ports.admin | int | `8022` |  |
| acapy.service.ports.http | int | `8021` |  |
| acapy.service.ports.ws | int | `8023` |  |
| acapy.serviceAccount.annotations | object | `{}` |  |
| acapy.serviceAccount.automountServiceAccountToken | bool | `true` |  |
| acapy.serviceAccount.create | bool | `false` |  |
| acapy.serviceAccount.name | string | `""` |  |
| acapyTenancyMode | string | `"single"` |  |
| affinity | object | `{}` |  |
| auth.api.existingSecret | string | `""` |  |
| auth.token.privateKey.existingSecret | string | `""` |  |
| auth.token.privateKey.filename | string | `"jwt-token.pem"` |  |
| autoscaling.enabled | bool | `true` |  |
| autoscaling.maxReplicas | int | `2` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.stabilizationWindowSeconds | int | `300` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| autoscaling.targetMemoryUtilizationPercentage | string | `""` |  |
| cleanup.cronjob.enabled | bool | `false` |  |
| cleanup.cronjob.failedJobsHistoryLimit | int | `3` |  |
| cleanup.cronjob.nodeSelector | object | `{}` |  |
| cleanup.cronjob.resources.limits.cpu | string | `"100m"` |  |
| cleanup.cronjob.resources.limits.memory | string | `"128Mi"` |  |
| cleanup.cronjob.resources.requests.cpu | string | `"50m"` |  |
| cleanup.cronjob.resources.requests.memory | string | `"64Mi"` |  |
| cleanup.cronjob.retryDelaySeconds | int | `10` |  |
| cleanup.cronjob.schedule | string | `"0 * * * *"` |  |
| cleanup.cronjob.successfulJobsHistoryLimit | int | `3` |  |
| cleanup.cronjob.timeoutSeconds | int | `300` |  |
| cleanup.cronjob.tolerations | list | `[]` |  |
| containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| containerSecurityContext.enabled | bool | `false` |  |
| containerSecurityContext.privileged | bool | `false` |  |
| containerSecurityContext.readOnlyRootFilesystem | bool | `true` |  |
| containerSecurityContext.runAsGroup | int | `1001` |  |
| containerSecurityContext.runAsNonRoot | bool | `true` |  |
| containerSecurityContext.runAsUser | int | `1001` |  |
| containerSecurityContext.seLinuxOptions | object | `{}` |  |
| containerSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| controller.cameraRedirectUrl | string | `"wallet_howto"` |  |
| controller.customHtmlConfigMapName | string | `""` |  |
| controller.presentationExpireTime | int | `300` |  |
| controller.sessionTimeout.config[0] | string | `"expired"` |  |
| controller.sessionTimeout.config[1] | string | `"failed"` |  |
| controller.sessionTimeout.config[2] | string | `"abandoned"` |  |
| controller.sessionTimeout.duration | int | `86400` |  |
| controller.templateDirectory | string | `"/app/controller-config/templates"` |  |
| controller.useConnectionBasedVerification | bool | `true` |  |
| controller.userVariableSubsitution | string | `"# This is a default placeholder Python file\n# Add any extensions to user variables here. Example below:\n\n# def sub_days_plus_one(days: str) -> int:\n# \"\"\"Strings like '$sub_days_plus_one_4' will be replaced with the\n# final number incremented by one. In this case 5.\n# $sub_days_plus_one_4 -> 5\n# $sub_days_plus_one_10 -> 11\"\"\"\n# return int(days) + 1\n\n# variable_substitution_map.add_variable_substitution(\n#     r\"\\$sub_days_plus_one_(\\d+)\", sub_days_plus_one\n# )"` |  |
| database.existingSecret | string | `""` |  |
| fullnameOverride | string | `""` |  |
| global.compatibility.openshift.adaptSecurityContext | string | `"auto"` |  |
| global.defaultStorageClass | string | `""` |  |
| global.imagePullSecrets | list | `[]` |  |
| global.imageRegistry | string | `""` |  |
| global.ingressSuffix | string | `".example.com"` |  |
| global.security.allowInsecureImages | bool | `false` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.pullSecrets | list | `[]` |  |
| image.registry | string | `"ghcr.io"` |  |
| image.repository | string | `"openwallet-foundation/acapy-vc-authn-oidc"` |  |
| image.tag | string | `""` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `true` |  |
| ingress.tls | list | `[]` |  |
| invitationLabel | string | `"VC-AuthN"` |  |
| logLevel | string | `"INFO"` |  |
| mongodb.arbiter.enabled | bool | `false` |  |
| mongodb.architecture | string | `"replicaset"` |  |
| mongodb.auth.databases[0] | string | `"vcauthn"` |  |
| mongodb.auth.enabled | bool | `true` |  |
| mongodb.auth.existingSecret | string | `"{{ include \"global.fullname\" . }}"` |  |
| mongodb.auth.usernames[0] | string | `"vcauthn"` |  |
| mongodb.commonLabels."app.kubernetes.io/role" | string | `"database"` |  |
| mongodb.containerSecurityContext.enabled | bool | `false` |  |
| mongodb.hidden.enabled | bool | `false` |  |
| mongodb.image.pullPolicy | string | `"IfNotPresent"` |  |
| mongodb.image.registry | string | `"docker.io"` |  |
| mongodb.image.repository | string | `"bitnamilegacy/mongodb"` |  |
| mongodb.image.tag | string | `"8.0.4-debian-12-r4"` |  |
| mongodb.metrics.enabled | bool | `false` |  |
| mongodb.persistence.enabled | bool | `true` |  |
| mongodb.persistence.storageClass | string | `"default"` |  |
| mongodb.podSecurityContext.enabled | bool | `false` |  |
| mongodb.serviceAccount.create | bool | `false` |  |
| nameOverride | string | `""` |  |
| networkPolicy.enabled | bool | `true` |  |
| networkPolicy.ingress.enabled | bool | `true` |  |
| networkPolicy.ingress.namespaceSelector | object | `{}` |  |
| networkPolicy.ingress.podSelector | object | `{}` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext.enabled | bool | `false` |  |
| podSecurityContext.fsGroup | int | `1001` |  |
| podSecurityContext.fsGroupChangePolicy | string | `"Always"` |  |
| podSecurityContext.supplementalGroups | list | `[]` |  |
| podSecurityContext.sysctls | list | `[]` |  |
| replicaCount | int | `1` |  |
| resources.limits | object | `{}` |  |
| resources.requests.cpu | string | `"10m"` |  |
| resources.requests.memory | string | `"128Mi"` |  |
| service.port | int | `5000` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automountServiceAccountToken | bool | `true` |  |
| serviceAccount.create | bool | `false` |  |
| serviceAccount.name | string | `""` |  |
| setNonRevoked | bool | `true` |  |
| tolerations | list | `[]` |  |
| useHTTPS | bool | `true` |  |
| useOobLocalDIDService | bool | `false` |  |
| walletDeepLinkPrefix | string | `"bcwallet://aries_proof-request"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
