
function Remove-DwAPIDeviceFeedData {

    <#
    .Synopsis
    Removes all device feed data by id or name.

    .Description
    Takes either a feedId or a feed name for a device feed and removes the data from that feed from the system.

    .Parameter APIUri
    The URI to the Dashworks instance being examined.

    .Parameter APIKey
    The APIKey for a user with access to the required resources.

    .Parameter FeedName
    The name of the feed to be searched for and the data removed.

    .Parameter FeedId
    The id of the device feed to have its data removed.

    .Outputs
    None.

    .Example
    # Remove the device feed data for feed id 3.
    Remove-DwAPIDeviceFeedData -APIUri $uriRoot -APIKey $APIKey -FeedId 3

    .Example
    # Remove the device data for the feed named "Testing Feed".
    Remove-DwAPIDeviceFeedData -APIUri $uriRoot -APIKey $APIKey -FeedName "Testing Feed"
    
    #>

    Param (
        [parameter(Mandatory=$True)]
        [string]$APIUri,
        
        [Parameter(Mandatory=$True)]
        [PSObject]$APIKey,

        [parameter(Mandatory=$False)]
        [string[]]$FeedName = $null,

        [parameter(Mandatory=$False)]
        [string[]]$FeedId
    )

    if (-not $FeedId)
    {
        if (-not $FeedName)
        {
            return 'Device feed not found by name or ID'
        }

        $FeedId = Get-DwAPIDeviceFeed -FeedName $FeedName -ApiKey $APIKey
    }

    if (-not $FeedId)
    {
        return 'Device feed not found by name or ID'
    }

    $Deleteheaders = 
    @{
        "X-API-KEY" = "$APIKey"
        "accept" = "*/*"
    }

    $uri = "$APIUri/apiv2/imports/devices/$FeedId/items"

    Invoke-RestMethod -Headers $Deleteheaders -Uri $uri -Method 'Delete' | Out-null
}