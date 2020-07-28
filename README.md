
# Deploy Code Dx on Kubernetes

Running guided-setup.ps1 is the recommended way to deploy Code Dx on Kubernetes (requires [PowerShell Core 7](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7)). The script will help you specify the correct setup.ps1 script parameters for installing Code Dx on your Kubernetes cluster.

## Prerequisites

Code Dx supports a minimum Kubernetes version of 1.14 if you're not using AWS EKS; otherwise, the minimum Kubernetes version is 1.16.

You must run guided-setup.ps1 from a system with administrative access to your cluster. Copy the following prerequisite programs to directories that are included in your PATH environment variable:

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [PowerShell Core 7](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [openssl](https://www.openssl.org/)
- [keytool](https://adoptopenjdk.net/) - The keytool application is bundled with the Java JRE.
- [helm v3.1+](https://github.com/helm/helm/releases/tag/v3.2.4) - Download the Helm release for your platform and extract helm (or helm.exe).

Make sure that you can run PowerShell Core scripts by switching your [PowerShell Execution Policy](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies) to RemoteSigned (recommended) or Unsigned.

>Note: On Windows, you must run the `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned` command from an elevated/administrator Command Prompt.

## Download Guided Setup

With prerequisites installed, open a Command Prompt/Terminal window and clone this repository on your system by running the following command from the directory where you want to store the codedx-kubernetes files:

```
git clone https://github.com/codedx/codedx-kubernetes.git -b feature/guide
```

## Run Guided Setup

To run the guided setup script after cloning the codedx-kubernetes repository, change directory to codedx-kubernetes, and use pwsh to run guided-setup.ps1:

```
cd codedx-kubernetes
pwsh ./guided-setup.ps1
```

The guided setup script checks to see whether your system meets the prerequisites before gathering configuration data with a [series of steps](#guided-setup-steps) to help you specify the setup.ps1 parameters necessary to deploy Code Dx in your Kubernetes environment. If you want to use LDAP for authentication, refer to the [LDAP configuration instructions](./setup/core/docs/auth/use-ldap.md) before starting the guided setup. 

At the conclusion of the guided setup, you can either run the generated setup commands or save the commands to run them later (recommended).

>Note: You can find a description of each setup command parameter [here](./setup/core#setup-script).

## Data Migration

If you are migrating from a Code Dx system created by the Code Dx Installer to a Code Dx Kubernetes deployment, follow the [data migration steps](./setup/core/docs/config/migrate-data.md) to move your data to Kubernetes.

## Guided Setup Steps

Below is a graph that shows every step of the guided setup script - you only have to visit the steps that apply to your Code Dx deployment.

![Guided Setup Steps](./images/guided-setup.svg)
