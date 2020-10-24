function New-Password([string] $pwdValue) {
	(new-object net.NetworkCredential("",$pwdValue)).securepassword
}

function Set-DefaultPass([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(1)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(0) # choose minikube env
	$global:inputs.enqueue(0) # choose minikube context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue(1) # skip tool orchestration
	$global:inputs.enqueue(1) # skip external db
	$global:inputs.enqueue(0) # skip backup
	$global:inputs.enqueue(0) # choose default deployment options
	$global:inputs.enqueue('ca.crt')  # specify cluster cert
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd confirm
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd confirm
	$global:inputs.enqueue(0) # specify db replicas
	$global:inputs.enqueue(0) # choose default cacerts
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue(1) # skip private reg
	$global:inputs.enqueue(0) # choose default Docker images
	$global:inputs.enqueue(0) # skip ingress
	$global:inputs.enqueue(0) # use local accounts
	$global:inputs.enqueue(1) # skip cpu reservation
	$global:inputs.enqueue(1) # skip memory reservation
	$global:inputs.enqueue(1) # skip storage reservation
	$global:inputs.enqueue(0) # use default volume sizes
	$global:inputs.enqueue('default') # storage class name
	$global:inputs.enqueue($saveOption) # next step save option
}

function Set-UseToolOrchestrationAndSubordinateDatabasePass([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(1)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(0) # choose minikube env
	$global:inputs.enqueue(0) # choose minikube context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue(0) # choose tool orchestration
	$global:inputs.enqueue(1) # skip external db
	$global:inputs.enqueue(0) # skip backup
	$global:inputs.enqueue(0) # choose default deployment options
	$global:inputs.enqueue('ca.crt')  # specify cluster cert
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue('cdx-svc') # specify namespace
	$global:inputs.enqueue('codedx-tool-orchestration')  # specify release name
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd confirm
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd confirm
	$global:inputs.enqueue(1) # specify db replicas
	$global:inputs.enqueue(0) # choose default cacerts
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue((New-Password 'my-tool-service-password')) # specify tool service pwd
	$global:inputs.enqueue((New-Password 'my-tool-service-password')) # specify tool service pwd confirm
	$global:inputs.enqueue((New-Password 'my-minio-password')) # specify MinIO pwd
	$global:inputs.enqueue((New-Password 'my-minio-password')) # specify MinIO pwd confirm
	$global:inputs.enqueue(2) # specify tool service replicas
	$global:inputs.enqueue(1) # skip private reg
	$global:inputs.enqueue(0) # choose default Docker images
	$global:inputs.enqueue(0) # skip ingress
	$global:inputs.enqueue(0) # use local accounts
	$global:inputs.enqueue(1) # skip cpu reservation
	$global:inputs.enqueue(1) # skip memory reservation
	$global:inputs.enqueue(1) # skip storage reservation
	$global:inputs.enqueue(0) # use default volume sizes
	$global:inputs.enqueue('default') # storage class name
	$global:inputs.enqueue($saveOption) # next step save option
}

function Set-ExternalDatabasePass([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(1)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(0) # choose minikube env
	$global:inputs.enqueue(0) # choose minikube context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue(1) # skip tool orchestration
	$global:inputs.enqueue(0) # skip external db
	$global:inputs.enqueue(0) # skip backup
	$global:inputs.enqueue(0) # choose default deployment options
	$global:inputs.enqueue('ca.crt')  # specify cluster cert
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue('my-external-db-host') # specify external db host
	$global:inputs.enqueue(3306) # specify external db port
	$global:inputs.enqueue('codedxdb') # specify external db name
	$global:inputs.enqueue('codedx')   # specify external db username
	$global:inputs.enqueue((New-Password 'codedx-db-password'))  # specify codedx db pwd
	$global:inputs.enqueue((New-Password 'codedx-db-password')) # specify codedx db pwd confirm
	$global:inputs.enqueue(0) # choose TLS db connection
	$global:inputs.enqueue('db-ca.crt') # specify external db username
	$global:inputs.enqueue('cacerts') # specify cacerts file
	$global:inputs.enqueue((New-Password 'changeit')) # specify cacerts file password
	$global:inputs.enqueue(1) # skip changing cacerts password
	$global:inputs.enqueue(1) # skip extra certificates
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue(1) # skip private reg
	$global:inputs.enqueue(0) # choose default Docker images
	$global:inputs.enqueue(0) # skip ingress
	$global:inputs.enqueue(0) # use local accounts
	$global:inputs.enqueue(1) # skip cpu reservation
	$global:inputs.enqueue(1) # skip memory reservation
	$global:inputs.enqueue(1) # skip storage reservation
	$global:inputs.enqueue(0) # use default volume sizes
	$global:inputs.enqueue('default') # storage class name
	$global:inputs.enqueue($saveOption) # next step save option
}

function Set-ClassicLoadBalancerIngressPass([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(1)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(2) # choose EKS env
	$global:inputs.enqueue(1) # choose EKS context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue(1) # skip tool orchestration
	$global:inputs.enqueue(1) # skip external db
	$global:inputs.enqueue(0) # skip backup
	$global:inputs.enqueue(0) # choose default deployment options
	$global:inputs.enqueue('ca.crt')  # specify cluster cert
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd confirm
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd confirm
	$global:inputs.enqueue(0) # specify db replicas
	$global:inputs.enqueue(0) # choose default cacerts
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue(1) # skip private reg
	$global:inputs.enqueue(0) # choose default Docker images
	$global:inputs.enqueue(6) # choose AWS Classic Load Balancer ingress
	$global:inputs.enqueue('arn:value') # specify AWS Certificate ARN
	$global:inputs.enqueue(0) # use local accounts
	$global:inputs.enqueue(1) # skip cpu reservation
	$global:inputs.enqueue(1) # skip memory reservation
	$global:inputs.enqueue(1) # skip storage reservation
	$global:inputs.enqueue(0) # use default volume sizes
	$global:inputs.enqueue('default') # storage class name
	$global:inputs.enqueue(1) # skip node selectors
	$global:inputs.enqueue(1) # skip pod tolerations
	$global:inputs.enqueue($saveOption) # next step save option
}

function Set-ClassicLoadBalancerIngressGitOpsPass([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(0)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(2) # choose EKS env
	$global:inputs.enqueue(1) # choose EKS context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue('adm')                # specify sealed-secrets namespace
	$global:inputs.enqueue('sealed-secrets')     # specify sealed-secrets controller
	$global:inputs.enqueue('sealed-secrets.pem') # specify sealed-secrets cert
	$global:inputs.enqueue(1) # skip tool orchestration
	$global:inputs.enqueue(1) # skip external db
	$global:inputs.enqueue(0) # skip backup
	$global:inputs.enqueue(0) # choose default deployment options
	$global:inputs.enqueue('ca.crt')  # specify cluster cert
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd confirm
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd confirm
	$global:inputs.enqueue(0) # specify db replicas
	$global:inputs.enqueue('cacerts') # specify cacerts file
	$global:inputs.enqueue((New-Password 'changeit')) # specify cacerts file password
	$global:inputs.enqueue(1) # skip changing cacerts password
	$global:inputs.enqueue(1) # skip extra certificates
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue(1) # skip private reg
	$global:inputs.enqueue(0) # choose default Docker images
	$global:inputs.enqueue(6) # choose AWS Classic Load Balancer ingress
	$global:inputs.enqueue('arn:value') # specify AWS Certificate ARN
	$global:inputs.enqueue(0) # use local accounts
	$global:inputs.enqueue(1) # skip cpu reservation
	$global:inputs.enqueue(1) # skip memory reservation
	$global:inputs.enqueue(1) # skip storage reservation
	$global:inputs.enqueue(0) # use default volume sizes
	$global:inputs.enqueue('default') # storage class name
	$global:inputs.enqueue(1) # skip node selectors
	$global:inputs.enqueue(1) # skip pod tolerations
	$global:inputs.enqueue($saveOption) # next step save option
}

function Set-ClassicLoadBalancerIngressGitOpsNoTLSPass([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(0)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(2) # choose EKS env
	$global:inputs.enqueue(1) # choose EKS context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue('adm')                # specify sealed-secrets namespace
	$global:inputs.enqueue('sealed-secrets')     # specify sealed-secrets controller
	$global:inputs.enqueue('sealed-secrets.pem') # specify sealed-secrets cert
	$global:inputs.enqueue(1) # skip tool orchestration
	$global:inputs.enqueue(1) # skip external db
	$global:inputs.enqueue(0) # skip backup
	$global:inputs.enqueue(2) # choose other deployment options
	$global:inputs.enqueue(0) # choose PSPs
	$global:inputs.enqueue(0) # choose Network Policies
	$global:inputs.enqueue(1) # skip TLS
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd confirm
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd confirm
	$global:inputs.enqueue(0) # specify db replicas
	$global:inputs.enqueue(0) # choose default cacerts
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue(1) # skip private reg
	$global:inputs.enqueue(0) # choose default Docker images
	$global:inputs.enqueue(6) # choose AWS Classic Load Balancer ingress
	$global:inputs.enqueue('arn:value') # specify AWS Certificate ARN
	$global:inputs.enqueue(0) # use local accounts
	$global:inputs.enqueue(1) # skip cpu reservation
	$global:inputs.enqueue(1) # skip memory reservation
	$global:inputs.enqueue(1) # skip storage reservation
	$global:inputs.enqueue(0) # use default volume sizes
	$global:inputs.enqueue('default') # storage class name
	$global:inputs.enqueue(1) # skip node selectors
	$global:inputs.enqueue(1) # skip pod tolerations
	$global:inputs.enqueue($saveOption) # next step save option
}

function Set-NodeSelectorAndPodTolerationsPass([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(1)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(2) # choose EKS env
	$global:inputs.enqueue(1) # choose EKS context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue(1) # skip tool orchestration
	$global:inputs.enqueue(1) # skip external db
	$global:inputs.enqueue(0) # skip backup
	$global:inputs.enqueue(0) # choose default deployment options
	$global:inputs.enqueue('ca.crt')  # specify cluster cert
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd confirm
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd confirm
	$global:inputs.enqueue(0) # specify db replicas
	$global:inputs.enqueue(0) # choose default cacerts
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue(1) # skip private reg
	$global:inputs.enqueue(0) # choose default Docker images
	$global:inputs.enqueue(6) # choose AWS Classic Load Balancer ingress
	$global:inputs.enqueue('arn:value') # specify AWS Certificate ARN
	$global:inputs.enqueue(0) # use local accounts
	$global:inputs.enqueue(1) # skip cpu reservation
	$global:inputs.enqueue(1) # skip memory reservation
	$global:inputs.enqueue(1) # skip storage reservation
	$global:inputs.enqueue(0) # use default volume sizes
	$global:inputs.enqueue('default') # specify storage class name
	$global:inputs.enqueue(0) # choose node selectors
	$global:inputs.enqueue('alpha.eksctl.io/nodegroup-name') # specify node selector key (code dx app)
	$global:inputs.enqueue('codedx-nodes') # specify node selector value (code dx app)
	$global:inputs.enqueue('alpha.eksctl.io/nodegroup-name') # specify node selector key (master db)
	$global:inputs.enqueue('codedx-nodes') # specify node selector value (master db)
	$global:inputs.enqueue(0) # choose pod tolerations
	$global:inputs.enqueue('host') # specify pod tolerations key (code dx app)
	$global:inputs.enqueue('codedx-web') # specify pod tolerations value (code dx app)
	$global:inputs.enqueue('') # skip pod tolerations key (master db)
	$global:inputs.enqueue(0) # choose/confirm skip pod tolerations (master db)
	$global:inputs.enqueue($saveOption) # next step save option
}

function Set-RecommendedResourcesPass([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(1)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(0) # choose minikube env
	$global:inputs.enqueue(0) # choose minikube context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue(1) # skip tool orchestration
	$global:inputs.enqueue(1) # skip external db
	$global:inputs.enqueue(0) # skip backup
	$global:inputs.enqueue(0) # choose default deployment options
	$global:inputs.enqueue('ca.crt')  # specify cluster cert
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd confirm
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd confirm
	$global:inputs.enqueue(0) # specify db replicas
	$global:inputs.enqueue(0) # choose default cacerts
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue(1) # skip private reg
	$global:inputs.enqueue(0) # choose default Docker images
	$global:inputs.enqueue(0) # skip ingress
	$global:inputs.enqueue(0) # use local accounts
	$global:inputs.enqueue(0) # choose cpu recommended
	$global:inputs.enqueue(0) # choose memory recommended
	$global:inputs.enqueue(0) # choose storage recommended
	$global:inputs.enqueue(0) # use default volume sizes
	$global:inputs.enqueue('default') # storage class name
	$global:inputs.enqueue($saveOption) # next step save option
}

function Set-AllNodeSelectorAndPodTolerationsPass([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(1)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(2) # choose EKS env
	$global:inputs.enqueue(1) # choose EKS context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue(0) # choose tool orchestration
	$global:inputs.enqueue(1) # skip external db
	$global:inputs.enqueue(0) # skip backup
	$global:inputs.enqueue(0) # choose default deployment options
	$global:inputs.enqueue('ca.crt')  # specify cluster cert
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue('cdx-svc') # specify namespace
	$global:inputs.enqueue('codedx-tool-orchestration')  # specify release name
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd confirm
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd confirm
	$global:inputs.enqueue(1) # specify db replicas
	$global:inputs.enqueue(0) # choose default cacerts
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue((New-Password 'my-tool-service-password')) # specify tool service pwd
	$global:inputs.enqueue((New-Password 'my-tool-service-password')) # specify tool service pwd confirm
	$global:inputs.enqueue((New-Password 'my-minio-password')) # specify MinIO pwd
	$global:inputs.enqueue((New-Password 'my-minio-password')) # specify MinIO pwd confirm
	$global:inputs.enqueue(2) # specify tool service replicas
	$global:inputs.enqueue(1) # skip private reg
	$global:inputs.enqueue(0) # choose default Docker images
	$global:inputs.enqueue(6) # choose AWS Classic Load Balancer ingress
	$global:inputs.enqueue('arn:value') # specify AWS Certificate ARN
	$global:inputs.enqueue(0) # use local accounts
	$global:inputs.enqueue(1) # skip cpu reservation
	$global:inputs.enqueue(1) # skip memory reservation
	$global:inputs.enqueue(1) # skip storage reservation
	$global:inputs.enqueue(0) # use default volume sizes
	$global:inputs.enqueue('default') # specify storage class name
	$global:inputs.enqueue(0) # choose node selectors
	$global:inputs.enqueue('alpha.eksctl.io/nodegroup-name') # specify node selector key (code dx app)
	$global:inputs.enqueue('codedx-nodes-1') # specify node selector value (code dx app)
	$global:inputs.enqueue('alpha.eksctl.io/nodegroup-name') # specify node selector key (master db)
	$global:inputs.enqueue('codedx-nodes-2') # specify node selector value (master db)
	$global:inputs.enqueue('alpha.eksctl.io/nodegroup-name') # specify node selector key (subordinate db)
	$global:inputs.enqueue('codedx-nodes-3') # specify node selector value (subordinate db)
	$global:inputs.enqueue('alpha.eksctl.io/nodegroup-name') # specify node selector key (tool service)
	$global:inputs.enqueue('codedx-nodes-4') # specify node selector value (tool service)
	$global:inputs.enqueue('alpha.eksctl.io/nodegroup-name') # specify node selector key (MinIO)
	$global:inputs.enqueue('codedx-nodes-5') # specify node selector value (MinIO)
	$global:inputs.enqueue('alpha.eksctl.io/nodegroup-name') # specify node selector key (workflow controller)
	$global:inputs.enqueue('codedx-nodes-6') # specify node selector value (workflow controller)
	$global:inputs.enqueue('alpha.eksctl.io/nodegroup-name') # specify node selector key (tools)
	$global:inputs.enqueue('codedx-nodes-7') # specify node selector value (tools)
	$global:inputs.enqueue(0) # choose pod tolerations
	$global:inputs.enqueue('host') # specify pod tolerations key (code dx app)
	$global:inputs.enqueue('codedx-web') # specify pod tolerations value (code dx app)
	$global:inputs.enqueue('host') # specify pod tolerations key (master db)
	$global:inputs.enqueue('master-db') # specify pod tolerations value (master db)
	$global:inputs.enqueue('host') # specify pod tolerations key (subordinate db)
	$global:inputs.enqueue('subordinate-db') # specify pod tolerations value (subordinate db)
	$global:inputs.enqueue('host') # specify pod tolerations key (tool service)
	$global:inputs.enqueue('tool-service') # specify pod tolerations value (tool service)
	$global:inputs.enqueue('host') # specify pod tolerations key (MinIO)
	$global:inputs.enqueue('minio') # specify pod tolerations value (MinIO)
	$global:inputs.enqueue('host') # specify pod tolerations key (workflow controller)
	$global:inputs.enqueue('workflow-controller') # specify pod tolerations value (workflow controller)
	$global:inputs.enqueue('host') # specify pod tolerations key (tools)
	$global:inputs.enqueue('tools') # specify pod tolerations value (tools)
	$global:inputs.enqueue($saveOption) # next step save option
}

function Set-NginxLetsEncryptWithLoadBalancerIpPass([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(1)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(1) # choose AKS env
	$global:inputs.enqueue(0) # choose minikube context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue(0) # skip tool orchestration
	$global:inputs.enqueue(1) # skip external db
	$global:inputs.enqueue(0) # skip backup
	$global:inputs.enqueue(0) # choose default deployment options
	$global:inputs.enqueue('ca.crt')  # specify cluster cert
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue('cdx-svc') # specify namespace
	$global:inputs.enqueue('codedx-tool-orchestration')  # specify release name
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd confirm
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd confirm
	$global:inputs.enqueue(1) # specify db replicas
	$global:inputs.enqueue(0) # choose default cacerts
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue((New-Password 'my-tool-service-password')) # specify tool service pwd
	$global:inputs.enqueue((New-Password 'my-tool-service-password')) # specify tool service pwd confirm
	$global:inputs.enqueue((New-Password 'my-minio-password')) # specify MinIO pwd
	$global:inputs.enqueue((New-Password 'my-minio-password')) # specify MinIO pwd confirm
	$global:inputs.enqueue(2) # specify tool service replicas
	$global:inputs.enqueue(1) # skip private reg
	$global:inputs.enqueue(0) # choose default Docker images
	$global:inputs.enqueue(2) # choose NGINX and Let's Encrypt ingress with LoadBalancer IP
	$global:inputs.enqueue('nginx') # specify nginx namespace
	$global:inputs.enqueue('10.0.0.1') # specify IP address
	$global:inputs.enqueue('cert-manager') # specify let's encrypt namespace
	$global:inputs.enqueue(0) # choose staging clusterissuer
	$global:inputs.enqueue('support@codedx.com') # specify email contact
	$global:inputs.enqueue('codedx.com') # specify Code Dx DNS name
	$global:inputs.enqueue(0) # use local accounts
	$global:inputs.enqueue(0) # choose recommended custom
	$global:inputs.enqueue(0) # choose recommended custom
	$global:inputs.enqueue(0) # choose recommended custom
	$global:inputs.enqueue(0) # choose recommended volume sizes
	$global:inputs.enqueue('default') # storage class name
	$global:inputs.enqueue(1) # skip node selectors
	$global:inputs.enqueue(1) # skip pod tolerations
	$global:inputs.enqueue($saveOption) # next step save option
}

function Set-NginxLetsEncryptWithoutLoadBalancerIpPass([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(1)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(1) # choose AKS env
	$global:inputs.enqueue(0) # choose minikube context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue(0) # skip tool orchestration
	$global:inputs.enqueue(1) # skip external db
	$global:inputs.enqueue(0) # skip backup
	$global:inputs.enqueue(0) # choose default deployment options
	$global:inputs.enqueue('ca.crt')  # specify cluster cert
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue('cdx-svc') # specify namespace
	$global:inputs.enqueue('codedx-tool-orchestration')  # specify release name
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd confirm
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd confirm
	$global:inputs.enqueue(1) # specify db replicas
	$global:inputs.enqueue(0) # choose default cacerts
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue((New-Password 'my-tool-service-password')) # specify tool service pwd
	$global:inputs.enqueue((New-Password 'my-tool-service-password')) # specify tool service pwd confirm
	$global:inputs.enqueue((New-Password 'my-minio-password')) # specify MinIO pwd
	$global:inputs.enqueue((New-Password 'my-minio-password')) # specify MinIO pwd confirm
	$global:inputs.enqueue(2) # specify tool service replicas
	$global:inputs.enqueue(1) # skip private reg
	$global:inputs.enqueue(0) # choose default Docker images
	$global:inputs.enqueue(1) # choose NGINX and Let's Encrypt ingress
	$global:inputs.enqueue('nginx') # specify nginx namespace
	$global:inputs.enqueue('cert-manager') # specify let's encrypt namespace
	$global:inputs.enqueue(0) # choose staging clusterissuer
	$global:inputs.enqueue('support@codedx.com') # specify email contact
	$global:inputs.enqueue('codedx.com') # specify Code Dx DNS name
	$global:inputs.enqueue(0) # use local accounts
	$global:inputs.enqueue(0) # choose recommended custom
	$global:inputs.enqueue(0) # choose recommended custom
	$global:inputs.enqueue(0) # choose recommended custom
	$global:inputs.enqueue(0) # choose recommended volume sizes
	$global:inputs.enqueue('default') # storage class name
	$global:inputs.enqueue(1) # skip node selectors
	$global:inputs.enqueue(1) # skip pod tolerations
	$global:inputs.enqueue($saveOption) # next step save option
}

function Set-DockerImageNamesAndPrivateRegistryPass([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(1)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(0) # choose minikube env
	$global:inputs.enqueue(0) # choose minikube context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue(0) # choose tool orchestration
	$global:inputs.enqueue(1) # skip external db
	$global:inputs.enqueue(0) # skip backup
	$global:inputs.enqueue(0) # choose default deployment options
	$global:inputs.enqueue('ca.crt')  # specify cluster cert
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue('cdx-svc') # specify namespace
	$global:inputs.enqueue('codedx-tool-orchestration')  # specify release name
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd confirm
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd confirm
	$global:inputs.enqueue(1) # specify db replicas
	$global:inputs.enqueue(0) # choose default cacerts
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue((New-Password 'my-tool-service-password')) # specify tool service pwd
	$global:inputs.enqueue((New-Password 'my-tool-service-password')) # specify tool service pwd confirm
	$global:inputs.enqueue((New-Password 'my-minio-password')) # specify MinIO pwd
	$global:inputs.enqueue((New-Password 'my-minio-password')) # specify MinIO pwd confirm
	$global:inputs.enqueue(2) # specify tool service replicas
	$global:inputs.enqueue(0) # choose private reg
	$global:inputs.enqueue('private-reg') # skip reg k8s name
	$global:inputs.enqueue('private-reg-host') # skip reg host name
	$global:inputs.enqueue('private-reg-username') # skip reg username
	$global:inputs.enqueue((New-Password 'private-reg-password')) # specify reg pwd
	$global:inputs.enqueue((New-Password 'private-reg-password')) # specify reg pwd confirm
	$global:inputs.enqueue(1) # choose Docker images
	$global:inputs.enqueue('codedx-tomcat') # specify tomcat name
	$global:inputs.enqueue('codedx-tools') # specify tools name
	$global:inputs.enqueue('codedx-toolsmono') # specify toolsmono name
	$global:inputs.enqueue('codedx-toolservice') # specify toolservice name
	$global:inputs.enqueue('codedx-sendresults') # specify sendresults name
	$global:inputs.enqueue('codedx-senderrorresults') # specify senderrorresults name
	$global:inputs.enqueue('codedx-newanalysis') # specify newanalysis name
	$global:inputs.enqueue('codedx-cleanup') # specify cleanup name
	$global:inputs.enqueue(0) # skip ingress
	$global:inputs.enqueue(0) # use local accounts
	$global:inputs.enqueue(1) # skip cpu reservation
	$global:inputs.enqueue(1) # skip memory reservation
	$global:inputs.enqueue(1) # skip storage reservation
	$global:inputs.enqueue(0) # use default volume sizes
	$global:inputs.enqueue('default') # storage class name
	$global:inputs.enqueue($saveOption) # next step save option
}

function Set-ConfigCertsPass([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(1)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(0) # choose minikube env
	$global:inputs.enqueue(0) # choose minikube context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue(1) # skip tool orchestration
	$global:inputs.enqueue(1) # skip external db
	$global:inputs.enqueue(0) # skip backup
	$global:inputs.enqueue(0) # choose default deployment options
	$global:inputs.enqueue('ca.crt')  # specify cluster cert
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd confirm
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd confirm
	$global:inputs.enqueue(0) # specify db replicas
	$global:inputs.enqueue(1) # choose default cacerts

	$global:inputs.enqueue('cacerts') # specify cacerts file
	$global:inputs.enqueue((New-Password 'changeit')) # specify cacerts file pwd
	$global:inputs.enqueue(0) # choose change cacerts file pwd
	$global:inputs.enqueue((New-Password 'changed')) # specify new cacerts file pwd
	$global:inputs.enqueue((New-Password 'changed')) # specify new cacerts file pwd confirm
	$global:inputs.enqueue(0) # choose extra certificates
	$global:inputs.enqueue('extra1.pem') # specify extra certificate 1
	$global:inputs.enqueue('extra2.pem') # specify extra certificate 2
	$global:inputs.enqueue('') # specify end of extra certificates
	$global:inputs.enqueue(0) # specify end of extra certificates confirm

	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue(1) # skip private reg
	$global:inputs.enqueue(0) # choose default Docker images
	$global:inputs.enqueue(0) # skip ingress
	$global:inputs.enqueue(0) # use local accounts
	$global:inputs.enqueue(1) # skip cpu reservation
	$global:inputs.enqueue(1) # skip memory reservation
	$global:inputs.enqueue(1) # skip storage reservation
	$global:inputs.enqueue(0) # use default volume sizes
	$global:inputs.enqueue('default') # storage class name
	$global:inputs.enqueue($saveOption) # next step save option
}

function Set-UseCustomResourcesPass([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(1)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(0) # choose minikube env
	$global:inputs.enqueue(0) # choose minikube context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue(0) # choose tool orchestration
	$global:inputs.enqueue(1) # skip external db
	$global:inputs.enqueue(0) # skip backup
	$global:inputs.enqueue(0) # choose default deployment options
	$global:inputs.enqueue('ca.crt')  # specify cluster cert
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue('cdx-svc') # specify namespace
	$global:inputs.enqueue('codedx-tool-orchestration')  # specify release name
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd confirm
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd confirm
	$global:inputs.enqueue(1) # specify db replicas
	$global:inputs.enqueue(0) # choose default cacerts
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue((New-Password 'my-tool-service-password')) # specify tool service pwd
	$global:inputs.enqueue((New-Password 'my-tool-service-password')) # specify tool service pwd confirm
	$global:inputs.enqueue((New-Password 'my-minio-password')) # specify MinIO pwd
	$global:inputs.enqueue((New-Password 'my-minio-password')) # specify MinIO pwd confirm
	$global:inputs.enqueue(2) # specify tool service replicas
	$global:inputs.enqueue(1) # skip private reg
	$global:inputs.enqueue(0) # choose default Docker images
	$global:inputs.enqueue(0) # skip ingress
	$global:inputs.enqueue(0) # use local accounts
	$global:inputs.enqueue(2) # choose custom cpu reservation
	$global:inputs.enqueue('1001m')
	$global:inputs.enqueue('1002m')
	$global:inputs.enqueue('1003m')
	$global:inputs.enqueue('1004')
	$global:inputs.enqueue('1005')
	$global:inputs.enqueue('1006')
	$global:inputs.enqueue(2) # choose custom memory reservation
	$global:inputs.enqueue('501')
	$global:inputs.enqueue('502')
	$global:inputs.enqueue('503')
	$global:inputs.enqueue('504Mi')
	$global:inputs.enqueue('505Mi')
	$global:inputs.enqueue('506Mi')
	$global:inputs.enqueue(2) # choose custom storage reservation
	$global:inputs.enqueue('1025')
	$global:inputs.enqueue('1026Mi')
	$global:inputs.enqueue('1027')
	$global:inputs.enqueue('1028Mi')
	$global:inputs.enqueue('1029Mi')
	$global:inputs.enqueue('1030')
	$global:inputs.enqueue(1) # choose default volume sizes
	$global:inputs.enqueue(20)
	$global:inputs.enqueue(25)
	$global:inputs.enqueue(30)
	$global:inputs.enqueue(35)
	$global:inputs.enqueue('default') # storage class name
	$global:inputs.enqueue($saveOption) # next step save option
}

function Set-UseSamlPass([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(1)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(0) # choose minikube env
	$global:inputs.enqueue(0) # choose minikube context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue(1) # skip tool orchestration
	$global:inputs.enqueue(1) # skip external db
	$global:inputs.enqueue(0) # skip backup
	$global:inputs.enqueue(0) # choose default deployment options
	$global:inputs.enqueue('ca.crt')  # specify cluster cert
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd confirm
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd confirm
	$global:inputs.enqueue(0) # specify db replicas
	$global:inputs.enqueue(0) # choose default cacerts
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue(1) # skip private reg
	$global:inputs.enqueue(0) # choose default Docker images
	$global:inputs.enqueue(0) # skip ingress
	$global:inputs.enqueue(1) # use SAML accounts
	$global:inputs.enqueue('codedx.com') # specify DNS name
	$global:inputs.enqueue('idp-metadata.xml') # specify IdP metadata
	$global:inputs.enqueue('codedxclient') # specify SAML application name
	$global:inputs.enqueue((New-Password 'my-keystore-password')) # specify keystore pwd
	$global:inputs.enqueue((New-Password 'my-keystore-password')) # specify keystore pwd confirm
	$global:inputs.enqueue((New-Password 'my-private-key-password')) # specify private key pwd
	$global:inputs.enqueue((New-Password 'my-private-key-password')) # specify private key pwd confirm
	$global:inputs.enqueue(0) # continue past instructions
	$global:inputs.enqueue(1) # skip cpu reservation
	$global:inputs.enqueue(1) # skip memory reservation
	$global:inputs.enqueue(1) # skip storage reservation
	$global:inputs.enqueue(0) # use default volume sizes
	$global:inputs.enqueue('default') # storage class name
	$global:inputs.enqueue($saveOption) # next step save option
}

function Set-SomeDockerImageNames([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(1)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(0) # choose minikube env
	$global:inputs.enqueue(0) # choose minikube context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue(0) # choose tool orchestration
	$global:inputs.enqueue(1) # skip external db
	$global:inputs.enqueue(0) # skip backup
	$global:inputs.enqueue(0) # choose default deployment options
	$global:inputs.enqueue('ca.crt')  # specify cluster cert
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue('cdx-svc') # specify namespace
	$global:inputs.enqueue('codedx-tool-orchestration')  # specify release name
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd confirm
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd confirm
	$global:inputs.enqueue(1) # specify db replicas
	$global:inputs.enqueue(0) # choose default cacerts
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue((New-Password 'my-tool-service-password')) # specify tool service pwd
	$global:inputs.enqueue((New-Password 'my-tool-service-password')) # specify tool service pwd confirm
	$global:inputs.enqueue((New-Password 'my-minio-password')) # specify MinIO pwd
	$global:inputs.enqueue((New-Password 'my-minio-password')) # specify MinIO pwd confirm
	$global:inputs.enqueue(2) # specify tool service replicas
	$global:inputs.enqueue(1) # skip private reg
	$global:inputs.enqueue(1) # choose Docker images
	$global:inputs.enqueue('codedx-tomcat') # specify tomcat name
	$global:inputs.enqueue('') # skip tools name
	$global:inputs.enqueue(0) # skip confirm tools name
	$global:inputs.enqueue('codedx-toolsmono') # specify toolsmono name
	$global:inputs.enqueue('codedx-toolservice') # specify toolservice name
	$global:inputs.enqueue('codedx-sendresults') # specify sendresults name
	$global:inputs.enqueue('codedx-senderrorresults') # specify senderrorresults name
	$global:inputs.enqueue('codedx-newanalysis') # specify newanalysis name
	$global:inputs.enqueue('codedx-cleanup') # specify cleanup name
	$global:inputs.enqueue(0) # skip ingress
	$global:inputs.enqueue(0) # use local accounts
	$global:inputs.enqueue(1) # skip cpu reservation
	$global:inputs.enqueue(1) # skip memory reservation
	$global:inputs.enqueue(1) # skip storage reservation
	$global:inputs.enqueue(0) # use default volume sizes
	$global:inputs.enqueue('default') # storage class name
	$global:inputs.enqueue($saveOption) # next step save option
}

function Set-PassWithDefaultResourceReservations([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(1)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(0) # choose minikube env
	$global:inputs.enqueue(0) # choose minikube context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue(0) # choose tool orchestration
	$global:inputs.enqueue(1) # skip external db
	$global:inputs.enqueue(0) # skip backup
	$global:inputs.enqueue(0) # choose default deployment options
	$global:inputs.enqueue('ca.crt')  # specify cluster cert
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue('cdx-svc') # specify namespace
	$global:inputs.enqueue('codedx-tool-orchestration')  # specify release name
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd confirm
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd confirm
	$global:inputs.enqueue(1) # specify db replicas
	$global:inputs.enqueue(0) # choose default cacerts
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue((New-Password 'my-tool-service-password')) # specify tool service pwd
	$global:inputs.enqueue((New-Password 'my-tool-service-password')) # specify tool service pwd confirm
	$global:inputs.enqueue((New-Password 'my-minio-password')) # specify MinIO pwd
	$global:inputs.enqueue((New-Password 'my-minio-password')) # specify MinIO pwd confirm
	$global:inputs.enqueue(2) # specify tool service replicas
	$global:inputs.enqueue(1) # skip private reg
	$global:inputs.enqueue(0) # choose default Docker images
	$global:inputs.enqueue(0) # skip ingress
	$global:inputs.enqueue(0) # use local accounts
	$global:inputs.enqueue(0) # choose default cpu reservation
	$global:inputs.enqueue(0) # choose default memory reservation
	$global:inputs.enqueue(0) # choose default storage reservation
	$global:inputs.enqueue(0) # choose default sizes
	$global:inputs.enqueue('default') # storage class name
	$global:inputs.enqueue($saveOption) # next step save option
}

function Set-PassWithCustomAcceptingDefaultResourceReservations([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(1)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(0) # choose minikube env
	$global:inputs.enqueue(0) # choose minikube context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue(0) # choose tool orchestration
	$global:inputs.enqueue(1) # skip external db
	$global:inputs.enqueue(0) # skip backup
	$global:inputs.enqueue(0) # choose default deployment options
	$global:inputs.enqueue('ca.crt')  # specify cluster cert
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue('cdx-svc') # specify namespace
	$global:inputs.enqueue('codedx-tool-orchestration')  # specify release name
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd confirm
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd confirm
	$global:inputs.enqueue(1) # specify db replicas
	$global:inputs.enqueue(0) # choose default cacerts
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue((New-Password 'my-tool-service-password')) # specify tool service pwd
	$global:inputs.enqueue((New-Password 'my-tool-service-password')) # specify tool service pwd confirm
	$global:inputs.enqueue((New-Password 'my-minio-password')) # specify MinIO pwd
	$global:inputs.enqueue((New-Password 'my-minio-password')) # specify MinIO pwd confirm
	$global:inputs.enqueue(2) # specify tool service replicas
	$global:inputs.enqueue(1) # skip private reg
	$global:inputs.enqueue(0) # choose default Docker images
	$global:inputs.enqueue(0) # skip ingress
	$global:inputs.enqueue(0) # use local accounts
	$global:inputs.enqueue(2) # choose custom cpu reservation
	$global:inputs.enqueue('') # accept and confirm default
	$global:inputs.enqueue(0)
	$global:inputs.enqueue('') # accept and confirm default
	$global:inputs.enqueue(0)
	$global:inputs.enqueue('') # accept and confirm default
	$global:inputs.enqueue(0)
	$global:inputs.enqueue('') # accept and confirm default
	$global:inputs.enqueue(0)
	$global:inputs.enqueue('') # accept and confirm default
	$global:inputs.enqueue(0)
	$global:inputs.enqueue('') # accept and confirm default
	$global:inputs.enqueue(0)
	$global:inputs.enqueue(2) # choose custom memory reservation
	$global:inputs.enqueue('') # accept and confirm default
	$global:inputs.enqueue(0)
	$global:inputs.enqueue('') # accept and confirm default
	$global:inputs.enqueue(0)
	$global:inputs.enqueue('') # accept and confirm default
	$global:inputs.enqueue(0)
	$global:inputs.enqueue('') # accept and confirm default 
	$global:inputs.enqueue(0)
	$global:inputs.enqueue('') # accept and confirm default 
	$global:inputs.enqueue(0)
	$global:inputs.enqueue('') # accept and confirm default
	$global:inputs.enqueue(0)
	$global:inputs.enqueue(2) # choose custom storage reservation
	$global:inputs.enqueue('') # accept and confirm default
	$global:inputs.enqueue(0)
	$global:inputs.enqueue('') # accept and confirm default
	$global:inputs.enqueue(0)
	$global:inputs.enqueue('') # accept and confirm default
	$global:inputs.enqueue(0)
	$global:inputs.enqueue('') # accept and confirm default
	$global:inputs.enqueue(0)
	$global:inputs.enqueue('') # accept and confirm default
	$global:inputs.enqueue(0)
	$global:inputs.enqueue('') # accept and confirm default
	$global:inputs.enqueue(0)
	$global:inputs.enqueue(0) # choose default sizes
	$global:inputs.enqueue('default') # storage class name
	$global:inputs.enqueue($saveOption) # next step save option
}

function Set-DefaultPassWithVelero([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(1)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(0) # choose minikube env
	$global:inputs.enqueue(0) # choose minikube context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue(1) # skip tool orchestration
	$global:inputs.enqueue(1) # skip external db
	$global:inputs.enqueue(1)           # choose Velero plug-in
	$global:inputs.enqueue('velerons')  # specify Velero namespace
	$global:inputs.enqueue('0 4 * * *') # specify backup schedule
	$global:inputs.enqueue('32m')       # specify database backup timeout
	$global:inputs.enqueue('24h')       # specify backup TTL
	$global:inputs.enqueue(0) # choose default deployment options
	$global:inputs.enqueue('ca.crt')  # specify cluster cert
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd confirm
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd confirm
	$global:inputs.enqueue(0) # specify db replicas
	$global:inputs.enqueue(0) # choose default cacerts
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue(1) # skip private reg
	$global:inputs.enqueue(0) # choose default Docker images
	$global:inputs.enqueue(0) # skip ingress
	$global:inputs.enqueue(0) # use local accounts
	$global:inputs.enqueue(1) # skip cpu reservation
	$global:inputs.enqueue(1) # skip memory reservation
	$global:inputs.enqueue(1) # skip storage reservation
	$global:inputs.enqueue(0) # use default volume sizes
	$global:inputs.enqueue('default') # storage class name
	$global:inputs.enqueue($saveOption) # next step save option
}

function Set-DefaultPassWithVeleroRestic([int] $saveOption) {
	$global:inputs = new-object collections.queue
	$global:inputs.enqueue($null) # welcome
	$global:inputs.enqueue(1)     # skip GitOps
	$global:inputs.enqueue(0)     # prereqs
	$global:inputs.enqueue($TestDrive) # workdir
	$global:inputs.enqueue(0) # choose minikube env
	$global:inputs.enqueue(0) # choose minikube context
	$global:inputs.enqueue(0) # select context
	$global:inputs.enqueue(0) # choose default port
	$global:inputs.enqueue(1) # skip tool orchestration
	$global:inputs.enqueue(1) # skip external db
	$global:inputs.enqueue(2)           # choose Velero Restic
	$global:inputs.enqueue('velero-ns') # specify Velero namespace
	$global:inputs.enqueue('0 5 * * *') # specify backup schedule
	$global:inputs.enqueue('33m')       # specify database backup timeout
	$global:inputs.enqueue('25h')       # specify backup TTL
	$global:inputs.enqueue(0) # choose default deployment options
	$global:inputs.enqueue('ca.crt')  # specify cluster cert
	$global:inputs.enqueue('cdx-app') # specify namespace
	$global:inputs.enqueue('codedx')  # specify release name
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd
	$global:inputs.enqueue((New-Password 'my-root-db-password')) # specify root db pwd confirm
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd
	$global:inputs.enqueue((New-Password 'my-replication-db-password')) # specify replication pwd confirm
	$global:inputs.enqueue(0) # specify db replicas
	$global:inputs.enqueue(0) # choose default cacerts
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd
	$global:inputs.enqueue((New-Password 'my-codedx-password')) # specify cdx pwd confirm
	$global:inputs.enqueue(1) # skip private reg
	$global:inputs.enqueue(0) # choose default Docker images
	$global:inputs.enqueue(0) # skip ingress
	$global:inputs.enqueue(0) # use local accounts
	$global:inputs.enqueue(1) # skip cpu reservation
	$global:inputs.enqueue(1) # skip memory reservation
	$global:inputs.enqueue(1) # skip storage reservation
	$global:inputs.enqueue(0) # use default volume sizes
	$global:inputs.enqueue('default') # storage class name
	$global:inputs.enqueue($saveOption) # next step save option
}
