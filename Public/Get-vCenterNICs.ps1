function Get-vCenterNICs {
    <#
    .SYNOPSIS

    Exporte la liste des VMs d'un vCenter ainsi que toutes les NICs associées.

    .DESCRIPTION

    Exporte la liste des VMs d'un vCenter ainsi que toutes les NICs associées
    Requiert un usager ayant des droits en Read sur le vCenter au complet.
    Appendre "| Format-Table" pour obtenir les résultats dans une belle liste exportable.

    .PARAMETER vCenterHostname
    Spécifie le nom du vCenter. Une addresse IP n'est pas suffisante

    .PARAMETER Credential
    Fournis les informations de connexion au vCenter de manière sécuritaire.
    Utiliser la commande Get-Credential pour entrer les informations de connexion

    .PARAMETER Username
    Passe le nom d'usager du compte en plain-text.
    Utiliser avec le paramêtre "Password"

    .PARAMETER Password
    Passe le mot de passe du compte en plain-text.
    Requiert un object de type SecureString. Utiliser la syntaxe suivante pour l'obtenir:
        "M0tDeP@sse" | Convertto-SecureString -AsPlainText -Force
    Attention! Cette méthode n'est pas sécuritaire et devrait être évitée à tout prix.

    .INPUTS

    Aucun Input. La commande n'accepte pas de paramêtre pas la Pipeline.

    .OUTPUTS

    L'objet retourné est de type PSCustomObject et définit la liste des VMs ainsi que toutes les NICs associées à chaque d'elles.

    .EXAMPLE

    PS> $Creds = Get-Credential
    PS> Get-vCenterNICs -vCenterHostname vcenter.ad.synovatec.com -Credential $Creds | ft

    .EXAMPLE

    PS> Get-vCenterNICs -vCenterHostname vcenter.ad.synovatec.com -Username fboisvert -Password ("P@ssw0rd" | Convertto-SecureString -AsPlainText -Force) | ft


    .LINK

    Get-vCenterNICs
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(mandatory=$true)][string]$vCenterHostName,
        [Parameter(mandatory=$true,ParameterSetName="Creds")][PSCredential]$Credential,
        [Parameter(mandatory=$true,ParameterSetName="Username")][String]$Username,
        [Parameter(mandatory=$true,ParameterSetName="Username")][SecureString]$Password
    )
    
    begin {
        #Check les dépendances
#        if ((Get-Module -Name vmware.powercli -ListAvailable).version.major -lt 11) {
#            Throw "Cette commande requiert le module VMware.PowerCLI à la version 11. Le module peut être téléchargé à partir de `"https://www.powershellgallery.com/packages/VMware.PowerCLI`".`nVous pouvez aussi utiliser la commande `"Install-Module -Name VMWare.PowerCLI -Scope CurrentUser`" pour en faire le téléchargement et l'installation."
#        }
#        else{
#            Import-Module VMware.PowerCLI | Out-Null
#        }
        
        #Configure l'environnement PowerCli pour éviter les erreurs
#        if(Get-PowerCLIConfiguration){
#            Set-PowerCLIConfiguration -InvalidCertificateAction Ignore | Out-Null
#        }

        #Crée l'objet Credentials si les paramêtres Username/Password sont utilisés
        if($PSCmdlet.ParameterSetName -eq "Username"){
            $Credential = New-Object System.Management.Automation.PSCredential ($Username, $Password) | Out-Null
        }

        #Initiation de la connexion au vCenter
        Connect-VIServer -Server $vCenterHostName -Credential $Credential | Out-Null

    }
    
    process {
        $VMs = Get-VM

        foreach($VM in $VMs){
            
            $Nics = Get-NetworkAdapter -VM $VM.Name
            
            foreach($Nic in $Nics){
                $Output = New-Object -TypeName PSObject
                $Output | Add-Member -MemberType NoteProperty -Name "VMName" -Value $VM.Name
                $Output | Add-Member -MemberType NoteProperty -Name "VMNicName" -Value $nic.Name
                $output | Add-Member -MemberType NoteProperty -Name "VMNicType" -Value $nic.Type
                $output | Add-Member -MemberType NoteProperty -Name "VMNicNetworkName" -Value $nic.NetworkName
                $output | Add-Member -MemberType NoteProperty -Name "VMNicMacAddress" -Value $nic.MacAddress
            }
            $Output
        }
    }
    
    end {
        Disconnect-VIServer -Confirm $false
    }
}