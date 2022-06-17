#Requires -Version 7
function Remove-DwImportUser {
    <#
        .SYNOPSIS
        Deletes a user in the import API.

        .DESCRIPTION
        Deletes a user in the import API.
        Takes the ImportId and Username as an input.

        .PARAMETER Instance

        Dashworks instance. For example, https://myinstance.dashworks.app:8443

        .PARAMETER APIKey

        Dashworks API Key.

        .PARAMETER Username

        Username for the user to be removed.

        .PARAMETER ImportId

        ImportId for the user.

        .EXAMPLE
        PS> Remove-DwImportUser -ImportId 1 -Username "w123abc" -Instance "https://myinstance.dashworks.app:8443" -APIKey "xxxxx"

    #>

    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Instance,
        [Parameter(Mandatory=$true)]
        [string]$APIKey,
        [parameter(Mandatory=$true)]
        [string]$Username,
        [parameter(Mandatory=$true)]
        [int]$ImportId
    )

    $uri = "{0}/apiv2/imports/devices/{1}/items/{2}" -f $Instance, $ImportId, $Username
    $headers = @{'x-api-key' = $APIKey}

    try {
        if ($PSCmdlet.ShouldProcess($Username)) {
            $result = Invoke-WebRequest -Uri $uri -Method DELETE -Headers $headers
            return $result
        }
    }
    catch {
        Write-Error $_
    }

}