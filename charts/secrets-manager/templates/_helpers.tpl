{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "secrets-manager.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "secrets-manager.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "secrets-manager.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "secrets-manager.labels" -}}
helm.sh/chart: {{ include "secrets-manager.chart" . }}
{{ include "secrets-manager.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "secrets-manager.selectorLabels" -}}
app.kubernetes.io/name: {{ include "secrets-manager.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "secrets-manager.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "secrets-manager.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
{{/*
Check if any type of credentials are defined
*/}}
{{- define "secrets-manager.hasCredentials" -}}
{{ or .Values.secretsgeneric.roleId ( or .Values.existingSecret .Values.existingRoleIdKey .Values.existingSecretIdKey ) -}}
{{- end -}}
{{/*
Generate the secret name for secret
*/}}
{{- define "secrets-manager.secretName" -}}
{{ default (include "secrets-manager.fullname" .) .Values.existingSecret }}
{{- end -}}
{{/*
Generate existingRoleIdKey key name in the secret
*/}}
{{- define "secrets-manager.secretKeyRoleId" -}}
{{ default "role_id" .Values.existingRoleIdKey }}
{{- end -}}
{{/*
Generate existingSecretIdKey key name in the secret
*/}}
{{- define "secrets-manager.secretKeySecretId" -}}
{{ default "secret_id" .Values.existingSecretIdKey }}
{{- end -}}
