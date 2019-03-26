## NAME
Get-vCenterNICs

## SYNOPSIS
Exporte la liste des VMs d'un vCenter ainsi que toutes les NICs associées.


## SYNTAX
`Get-vCenterNICs -vCenterHostName <String> -Credential <PSCredential> [<CommonParameters>]`

`Get-vCenterNICs -vCenterHostName <String> -Username <String> -Password <SecureString> [<CommonParameters>]`


## DESCRIPTION
Exporte la liste des VMs d'un vCenter ainsi que toutes les NICs associées
Requiert un usager ayant des droits en Read sur le vCenter au complet.


## PARAMETERS
    -vCenterHostName <String>
        Spécifie le nom du vCenter. Une addresse IP n'est pas suffisante

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Credential <PSCredential>
        Fournis les informations de connexion au vCenter de manière sécuritaire.
        Utiliser la commande Get-Credential pour entrer les informations de connexion

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Username <String>
        Passe le nom d'usager du compte en plain-text.
        Utiliser avec le paramêtre "Password"

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Password <SecureString>
        Passe le mot de passe du compte en plain-text.
        Requiert un object de type SecureString. Utiliser la syntaxe suivante pour l'obtenir:
            "M0tDeP@sse" | Convertto-SecureString -AsPlainText -Force
        Attention! Cette méthode n'est pas sécuritaire et devrait être évitée à tout prix.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS
Aucun Input. La commande n'accepte pas de paramêtre pas la Pipeline.


## OUTPUTS
L'objet retourné est de type PSCustomObject et définit la liste des VMs ainsi que toutes les NICs associées à chaque d'elles.

## Examples
-------------------------- EXAMPLE 1 --------------------------

PS>$Creds = Get-Credential

PS> Get-vCenterNICs -vCenterHostname vcenter.ad.synovatec.com -Credential $Creds




-------------------------- EXAMPLE 2 --------------------------

PS>Get-vCenterNICs -vCenterHostname vcenter.ad.synovatec.com -Username fboisvert -Password ("P@ssw0rd" | Convertto-SecureString -AsPlainText -Force)







## RELATED LINKS
Get-vCenterNICs

https://github.com/fboisvert/SynInternals/blob/master/Public/Get-vCenterNICs.md