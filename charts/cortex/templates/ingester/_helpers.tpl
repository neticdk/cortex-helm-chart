{{/*
Create a fully qualified ingester name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "cortex-ingester.fullname" -}}
{{- if .Values.ingester.fullnameOverride -}}
{{- .Values.ingester.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name "ingester" | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name "ingester" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified ingester name for zone aware deployment.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "cortex-ingester.fullname-zone-aware" -}}
{{- if .Values.ingester.fullnameOverride -}}
{{- printf "%s-%s" .Values.ingester.fullnameOverride .AvailabilityCell | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s-%s" .Release.Name "ingester" .AvailabilityCell | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s-%s" .Release.Name $name "ingester" .AvailabilityCell | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a headless qualified ingester service name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "cortex-ingester.headlessname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name "ingester-headless" | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name "ingester-headless" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create a headless qualified ingester service name for zone-aware deployment.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "cortex-ingester.headlessname-zone-aware" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s-%s" .Release.Name "ingester-headless" .AvailabilityCell | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s-%s" .Release.Name $name "ingester-headless" .AvailabilityCell | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}


{{/*
cortex-ingester common labels
*/}}
{{- define "cortex-ingester.labels" -}}
{{ include "cortex-ingester.matchLabels" . }}
{{ include "cortex.metaLabels" . }}
{{- end -}}

{{/*
cortex-ingester selector labels
*/}}
{{- define "cortex-ingester.matchLabels" -}}
app.kubernetes.io/component: ingester
{{ include "cortex.matchLabels" . }}
{{- end -}}
