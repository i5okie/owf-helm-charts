{{/*
Expand the name of the chart.
*/}}
{{- define "global.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "global.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "global.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "endorser-service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "endorser-service.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "endorser-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "endorser-service.labels" -}}
helm.sh/chart: {{ include "endorser-service.chart" . }}
{{ include "endorser-service.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "endorser-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "endorser-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Returns a secret if it already in Kubernetes, otherwise it creates it randomly.

Usage:
{{ include "getOrGeneratePass" (dict "Namespace" .Release.Namespace "Kind" "Secret" "Name" (include "endorser-service.databaseSecretName" .) "Key" "mongodb-root-password" "Length" 32) }}

*/}}
{{- define "getOrGeneratePass" }}
{{- $len := (default 16 .Length) | int -}}
{{- $obj := (lookup "v1" .Kind .Namespace .Name).data -}}
{{- if $obj }}
{{- index $obj .Key -}}
{{- else if (eq (lower .Kind) "secret") -}}
{{- randAlphaNum $len | b64enc -}}
{{- else -}}
{{- randAlphaNum $len -}}
{{- end -}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "endorser-service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "endorser-service.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the api secret to use
*/}}
{{- define "endorser-service.apiSecretName" -}}
{{- if (empty .Values.api.secret.existingSecret) }}
    {{- printf "%s-%s" .Release.Name "api" | trunc 63 | trimSuffix "-" }}
{{- else -}}
    {{- .Values.api.secret.existingSecret }}
{{- end -}}
{{- end }}

{{/* Define AcaPy base name */}}
{{- define "endorser-service.acapy.name" -}}
{{- default "acapy" .Values.acapy.nameOverride -}}
{{- end -}}

{{/*
Create a default fully qualified acapy name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "endorser-service.acapy.fullname" -}}
{{- printf "%s-%s" (include "global.fullname" .) (include "endorser-service.acapy.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the acapy secret name
*/}}
{{- define "endorser-service.acapy.secretName" -}}
    {{- if .Values.acapy.secrets.api.existingSecret -}}
        {{- .Values.acapy.secrets.api.existingSecret -}}
    {{- else -}}
          {{- printf "%s-%s-api" (include "global.fullname" .) (include "endorser-service.acapy.name" .) | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
{{- end -}}

{{/*
generate hosts if not overriden
*/}}
{{- define "endorser-service.acapy.host" -}}
    {{- printf "%s-%s%s" (include "global.fullname" .) (include "endorser-service.acapy.name" .) .Values.global.ingressSuffix -}}
{{- end -}}

{{/*
Create URL based on hostname and TLS status
*/}}
{{- define "endorser-service.acapy.agentUrl" -}}
{{- if .Values.useHTTPS -}}
{{- printf "https://%s" (include "endorser-service.acapy.host" .) }}
{{- else -}}
{{- printf "http://%s" (include "endorser-service.acapy.host" .) }}
{{- end -}}
{{- end }}

{{/*
generate admin url (internal)
*/}}
{{- define "endorser-service.acapy.adminUrl" -}}
    http://{{ include "endorser-service.acapy.fullname" . }}:{{ .Values.acapy.service.ports.admin }}
{{- end -}}

{{/*
Generate hosts for acapy admin if not overriden
*/}}
{{- define "endorser-service.acapy.adminHost" -}}
   {{- printf "%s-%s-admin%s" (include "global.fullname" .) (include "endorser-service.acapy.name" .) .Values.global.ingressSuffix -}}
{{- end -}}

{{/* AcaPy Postgres service name (uses nameOverride if set) */}}
{{- define "endorser-service.acapy.postgresqlServiceName" -}}
{{- $pgName := default "postgresql" .Values.acapy.postgresql.nameOverride -}}
{{- printf "%s-%s" .Release.Name $pgName -}}
{{- end -}}

{{/* API DB host/port from bitnami postgresql subchart or external */}}
{{- define "endorser-service.db.host" -}}
{{- if .Values.externalDatabase.enabled -}}
{{- .Values.externalDatabase.host -}}
{{- else -}}
{{- printf "%s-postgresql" .Release.Name -}}
{{- end -}}
{{- end -}}

{{/* Name of the secret containing DB credentials for API */}}
{{- define "endorser-service.db.secretName" -}}
{{- if .Values.externalDatabase.enabled -}}
	{{- if .Values.externalDatabase.existingSecret -}}
{{- .Values.externalDatabase.existingSecret -}}
	{{- else -}}
{{- "" -}}
	{{- end -}}
{{- else -}}
	{{- if .Values.postgresql.auth.existingSecret -}}
{{- .Values.postgresql.auth.existingSecret -}}
	{{- else -}}
{{- printf "%s-postgresql" .Release.Name -}}
	{{- end -}}
{{- end -}}
{{- end -}}

{{/* Keys for user/admin password within the DB secret */}}
{{- define "endorser-service.db.userPasswordKey" -}}
{{- if .Values.externalDatabase.enabled -}}
{{- default "password" .Values.externalDatabase.secretKeys.userPasswordKey -}}
{{- else -}}
password
{{- end -}}
{{- end -}}

{{- define "endorser-service.db.adminPasswordKey" -}}
{{- if .Values.externalDatabase.enabled -}}
{{- default "postgres-password" .Values.externalDatabase.secretKeys.adminPasswordKey -}}
{{- else -}}
postgres-password
{{- end -}}
{{- end -}}

{{- define "endorser-service.db.port" -}}
{{- if .Values.externalDatabase.enabled -}}
{{- .Values.externalDatabase.port -}}
{{- else -}}
5432
{{- end -}}
{{- end -}}

{{/* Determine DB admin username */}}
{{- define "endorser-service.db.adminUser" -}}
{{- if .Values.externalDatabase.enabled -}}
	{{- if .Values.externalDatabase.adminUsername -}}
{{- .Values.externalDatabase.adminUsername -}}
	{{- else -}}
{{- .Values.externalDatabase.username | default "postgres" -}}
	{{- end -}}
{{- else -}}
	{{- if hasKey .Values.postgresql.auth "enablePostgresUser" -}}
		{{- if .Values.postgresql.auth.enablePostgresUser -}}
postgres
		{{- else -}}
{{- .Values.postgresql.auth.username | default "endorser" -}}
		{{- end -}}
	{{- else -}}
postgres
	{{- end -}}
{{- end -}}
{{- end -}}
