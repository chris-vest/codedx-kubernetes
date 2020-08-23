<#PSScriptInfo
.VERSION 1.0.2
.GUID 9b147f81-cb5d-4f13-830c-f0eb653520a7
.AUTHOR Code Dx
#>

<# 
.DESCRIPTION 
This script contains helpers for Code Dx adminstration-related tasks.
#>


param(
	[string] $kubeContext = 'eks',
	[string] $codedxNamespace = 'cdx-app',
	[string] $codedxReleaseName = 'codedx',
	[string] $codedxBaseUrl = '',
	[bool]   $codedxSkipCertificateCheck = $false,
	[string] $codedxAdminApiKey = '',
	[string] $toolOrchestrationNamespace = 'cdx-svc',
	[string] $toolOrchestrationReleaseName = 'codedx-tool-orchestration'
)

$ErrorActionPreference = 'Stop'
Set-PSDebug -Strict

'../setup/core/common/codedx.ps1' | ForEach-Object {
	$path = join-path $PSScriptRoot $_
	if (-not (Test-Path $path)) {
		Write-Error "Unable to find file script dependency at $path. Please download the entire codedx-kubernetes GitHub repository and rerun the downloaded copy of this script."
	}
	. $path
}

function Write-Choices($decisionList) {
	Write-Host "`n---"
	Write-Host "What do you want to do?"

	$lastId = $null
	$decisionList | ForEach-Object {

		$id = $_.id
		if ($lastId -ne $id[0]) {
			Write-Host
		}

		Write-Host "  $($id):" $_.name
		$lastId = $id[0]
	}
	Write-Host "---`n"
}

function Get-Confirmation([string] $confirmation) {
	(Read-Host -prompt "Are you sure? Enter '$confirmation' to proceed") -eq $confirmation
}

function Test-AppCommandPath([string] $commandName) {

	$command = Get-Command $commandName -Type Application -ErrorAction SilentlyContinue
	$null -ne $command
}

function Test-Vim() {
	Test-AppCommandPath 'vim'
}

function Test-Argo() {
	Test-AppCommandPath 'argo'
}

$choices = @(

	@{id="A1"; name='Show All Workflows';
		action={
			argo -n $toolOrchestrationNamespace list
		};
		valid = {$toolOrchestrationNamespace -ne '' -and (Test-Argo)}
	}

	@{id="A2"; name='Show All Workflow Details';
		action={
			argo -n $toolOrchestrationNamespace list -o name | ForEach-Object {
				write-host "`n--------$_--------" -fore red
				argo -n $toolOrchestrationNamespace get $_
			}
		};
		valid = {$toolOrchestrationNamespace -ne '' -and (Test-Argo)}
	}

	@{id="A3"; name='Show Running Workflows';
		action={
			argo -n $toolOrchestrationNamespace list --running
		};
		valid = {$toolOrchestrationNamespace -ne '' -and (Test-Argo)}
	}

	@{id="A4"; name='Show Running Workflow Details';
		action={
			argo -n $toolOrchestrationNamespace list --running -o name | ForEach-Object {
				write-host "`n--------$_--------" -fore red
				argo -n $toolOrchestrationNamespace get $_
			}
		};
		valid = {$toolOrchestrationNamespace -ne '' -and (Test-Argo)}
	}

	@{id="A5"; name='Show Workflow Detail';
		action={
			$workflowName = read-host -prompt 'Enter workflow ID'
			argo -n $toolOrchestrationNamespace get $workflowName
		};
		valid = {$toolOrchestrationNamespace -ne '' -and (Test-Argo)}
	}

	@{id="C1"; name='Get Code Dx Namespace Pods';
		action={
			kubectl -n $codedxNamespace get pod -o wide
		};
		valid = {$codedxNamespace -ne ''}
	}

	@{id="C2"; name='Watch Code Dx Namespace Pods (Ctrl+C to quit - script restart required)';
		action={
			kubectl -n $codedxNamespace get pod -o wide -w
		};
		valid = {$codedxNamespace -ne ''}
	}

	@{id="C3"; name='Describe Code Dx Pod';
		action={
			kubectl -n $codedxNamespace -l app=codedx describe pod
		};
		valid = {$codedxNamespace -ne ''}
	}

	@{id="C4"; name='Get Code Dx Projects';
		action={
			(Invoke-RestMethod -SkipCertificateCheck:$codedxSkipCertificateCheck -Headers @{"API-Key"=$codedxAdminApiKey} -Uri "$codedxBaseUrl/api/projects").projects
		};
		valid = {$codedxAdminApiKey -ne '' -and $codedxBaseUrl -ne ''}
	}

	@{id="D1"; name='Delete *all* Code Dx Projects';
		action={
			if (Get-Confirmation $codedxAdminApiKey) {
				(Invoke-RestMethod -SkipCertificateCheck:$codedxSkipCertificateCheck -Headers @{"API-Key"=$codedxAdminApiKey} -Uri "$codedxBaseUrl/api/projects").projects.id | ForEach-Object {
					if ($null -ne $_) {
						Invoke-RestMethod -SkipCertificateCheck:$codedxSkipCertificateCheck -Headers @{"API-Key"=$codedxAdminApiKey} -Method Delete -Uri "$codedxBaseUrl/api/projects/$_"
					}
				}
			}
		};
		valid = {$codedxAdminApiKey -ne '' -and $codedxBaseUrl -ne ''}
	}

	@{id="D2"; name='Delete Code Dx Deployment';
		action={
			if (Get-Confirmation $codedxReleaseName) {
				helm delete -n $codedxNamespace $codedxReleaseName
			}
		};
		valid = {$codedxNamespace -ne '' -and $codedxReleaseName -ne ''}
	}

	@{id="D3"; name='Delete Tool Orchestration Deployment';
		action={
			if (Get-Confirmation $toolOrchestrationReleaseName) {
				helm delete -n $toolOrchestrationNamespace $toolOrchestrationReleaseName
			}
		};
		valid = {$toolOrchestrationNamespace -ne '' -and $toolOrchestrationReleaseName -ne ''}
	}

	@{id="H1"; name='Show All Helm Depoloyments';
		action={
			helm list --all-namespaces
		};
		valid = {$toolOrchestrationNamespace -ne ''}
	}

	@{id="K1"; name='Get All Pods';
		action={
			kubectl get pod -A -o wide
		};
		valid = {$true}
	}

	@{id="L1"; name='Show Code Dx Log';
		action={
			$podName = kubectl -n $codedxNamespace get pod -l app=codedx -o name
			kubectl -n $codedxNamespace logs $podName
		};
		valid = {$codedxNamespace -ne ''}
	}

	@{id="L2"; name='Open Code Dx Log in vim';
		action={
			$podName = kubectl -n $codedxNamespace get pod -l app=codedx -o name
			kubectl -n $codedxNamespace logs $podName | vim -
		};
		valid = {$codedxNamespace -ne '' -and (Test-Vim)}
	}

	@{id="L3"; name='Show Code Dx Log (ERRORs)';
		action={
			$podName = kubectl -n $codedxNamespace get pod -l app=codedx -o name
			kubectl -n $codedxNamespace logs $podName | Select-String '^ERROR\s'
		};
		valid = {$codedxNamespace -ne ''}
	}

	@{id="L4"; name='Show Code Dx Log (Last 10 Minutes)';
		action={
			$podName = kubectl -n $codedxNamespace get pod -l app=codedx -o name
			kubectl -n $codedxNamespace logs --since=10m $podName
		};
		valid = {$codedxNamespace -ne ''}
	}

	@{id="L5"; name='Show Tool Orchestration Log(s)';
		action={
			kubectl -n $toolOrchestrationNamespace get pod -l component=service -o name | ForEach-Object {
				write-host "`n--------$_--------" -fore red
				kubectl -n $toolOrchestrationNamespace logs $_
			}
		};
		valid = {$toolOrchestrationNamespace -ne ''}
	}

	@{id="L6"; name='Open Tool Orchestration Log(s) in vim';
		action={
			kubectl -n $toolOrchestrationNamespace get pod -l component=service -o name | ForEach-Object {
				write-host "`n--------$_--------" -fore red
				kubectl -n $toolOrchestrationNamespace logs $_ | vim -
			}
		};
		valid = {$toolOrchestrationNamespace -ne '' -and (Test-Vim)}
	}

	@{id="L7"; name='Show Tool Orchestration Log(s) (Last 10 Minutes)';
		action={
			kubectl -n $toolOrchestrationNamespace get pod -l component=service -o name | ForEach-Object {
				write-host "`n--------$_--------" -fore red
				kubectl -n $toolOrchestrationNamespace logs --since=10m $_
			}
		};
		valid = {$toolOrchestrationNamespace -ne ''}
	}

	@{id="L8"; name='Show Tool Orchestration log(s) (HTTP Status Code 500)';
		action={
			kubectl -n $toolOrchestrationNamespace get pod -l component=service -o name | ForEach-Object {
				write-host "`n--------$_--------" -fore red
				kubectl -n $toolOrchestrationNamespace logs $_ | Select-String 'Status Code: 500' -SimpleMatch
			}
		};
		valid = {$toolOrchestrationNamespace -ne ''}
	}

	@{id="L9"; name='Show Auto Scaler Log';
		action={
			$name = kubectl -n kube-system get deployment cluster-autoscaler -o name
			if ($null -eq $name) {
				write-host 'Cannot find cluster-autoscaler deployment!'
			} else {
				kubectl -n kube-system logs deployment/cluster-autoscaler
			}
		}
		valid={$true}
	}

	@{id="M1"; name='Describe MinIO Pod';
		action={
			kubectl -n $toolOrchestrationNamespace describe pod -l app.kubernetes.io/name=minio
		};
		valid = {$toolOrchestrationNamespace -ne ''}
	}

	@{id="M2"; name='Port-Forward MinIO Pod (Ctrl+C to quit - script restart required)';
		action={
			$minIOPodName = kubectl -n $toolOrchestrationNamespace get pod -l app.kubernetes.io/name=minio -o name
			if ($null -eq $minIOPodName) {
				Write-Host 'Cannot find MinIO pod!'
			} else {
				Write-Host 'Configuring localhost to port-forward to MinIO using http://localhost:9000...'
				kubectl -n $toolOrchestrationNamespace port-forward $minIOPodName 9000
			}
		};
		valid = {$toolOrchestrationNamespace -ne ''}
	}

	@{id="N1"; name='Get Nodes';
		action={
			kubectl get node
		};
		valid = {$true}
	}

	@{id="R1"; name='Replace Code Dx Pod';
		action={
			$deploymentName = Get-CodeDxChartFullName $codedxReleaseName
			kubectl -n $codedxNamespace scale --replicas=0 "deployment/$deploymentName"
			kubectl -n $codedxNamespace scale --replicas=1 "deployment/$deploymentName"
		};
		valid = {$codedxNamespace -ne ''}
	}

	@{id="R2"; name='Replace Tool Orchestration Pod(s)';
		action={
			$podNames = kubectl -n $toolOrchestrationNamespace get pod -l component=service -o name

			$deploymentName = Get-CodeDxToolOrchestrationChartFullName $toolOrchestrationReleaseName
			kubectl -n $toolOrchestrationNamespace scale --replicas=0 "deployment/$deploymentName"
			kubectl -n $toolOrchestrationNamespace scale --replicas=$($podNames.count) "deployment/$deploymentName"
		};
		valid = {$toolOrchestrationNamespace -ne '' -and $toolOrchestrationReleaseName -ne ''}
	}

	@{id="T1"; name='Get Tool Orchestration Namespace Pods';
		action={
			kubectl -n $toolOrchestrationNamespace get pod -o wide
		};
		valid = {$toolOrchestrationNamespace -ne ''}
	}

	@{id="T2"; name='Watch Tool Orchestration Namespace Pods (Ctrl+C to quit - script restart required)';
		action={
			kubectl -n $toolOrchestrationNamespace get pod -o wide -w
		};
		valid = {$toolOrchestrationNamespace -ne ''}
	}

	@{id="T3"; name='Describe Tool Orchestration Pod(s)';
		action={
			kubectl -n $toolOrchestrationNamespace describe pod -l component=service
		};
		valid = {$toolOrchestrationNamespace -ne ''}
	}


	@{id="T4"; name='Describe Resource Requirement(s)';
		action={
			kubectl -n $toolOrchestrationNamespace describe cm cdx-toolsvc
		};
		valid = {$toolOrchestrationNamespace -ne ''}
	}
)

kubectl config use-context $kubeContext
if ($LASTEXITCODE -ne 0) {
	Write-Host "Failed to switch to '$kubeContext' kube context."
	Write-Host 'Run kubectl config get-contexts to see whether you are connected to your EKS cluster.'
	Write-Host "You must have a context named '$kubeContext' or you must run this program with a different '-kubeContext' parameter value."
	Write-Host "You can also rename your current EKS context to '$kubeContext' by running kubectl config rename-context."
	exit 2
}

$cmdCount = $choices.count
$choices = $choices | Where-Object { & $_.valid } | Sort-Object -Property id
$missingCmds = $cmdCount -ne $choices.count

$choices = $choices + @{id="QA"; name='Quit'; action={ exit }} 

$choice = ''
$awaitingChoice = $false
while ($true) {

	if (-not $awaitingChoice) {
		Write-Choices $choices
		$awaitingChoice = $true
	}

	if ($missingCmds) {
		Write-Host "Note: The specified script parameter values made one or more actions unavailable.`n"
		$missingCmds=$false
	}

	if ('' -eq $choice) {
		$choice = read-host -prompt 'Enter code (e.g., C1)'
	}

	$action = $choices | Where-Object {
		$_.id -eq $choice
	}

	if ($null -eq $action) {
		$choice = ''
		Write-Host 'Try again by specifying a choice from the above list (enter QA to quit)'
		continue
	}

	Write-Host "`n$($action.name)...`n"
	& $action.action
	Write-Host "`n---"

	$choice = Read-Host 'Specify another command or press Enter to continue...'
	if ('' -ne $choice -and ($choices | select-object -ExpandProperty id) -notcontains $choice) {
		Write-Host 'Invalid choice'
		$choice = ''
	}

	$awaitingChoice = '' -ne $choice
}
