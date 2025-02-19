# * FUNCTIONS
function Clear-CommandHistory {
  $null > (Get-PSReadlineOption).HistorySavePath
}

function Get-CurrentUsers {
  param (
    # * Computer Name, IP Address, or URL you'd like to ping (default is localhost)
    [Parameter (Mandatory = $false)]
    [string]
    $ComputerName = "localhost"
  )

  # * variables
  $computer = $ComputerName
  $user = @()

  # * main
  if ($computer -eq "localhost") {
    $computer = HOSTNAME.EXE
  }

  Write-Host "`nComputerName: $computer"
  $user = (&"query" user /SERVER:$computer) -replace "^[\s]USERNAME[\s]+SESSIONNAME.*$", "" -replace "[\s]{2,}", "," -replace ">", "" | ConvertFrom-Csv -Delimiter "," -Header "Username", "SessionName", "Id", "State", "IdleTime", "LogonTime"
  for ($i = 0; $i -lt $user.Count; $i++) {
    if ($null -eq $user[$i].LogonTime) {
      $user[$i].LogonTime = $user[$i].IdleTime
      $user[$i].IdleTime = $user[$i].State
      $user[$i].State = $user[$i].Id
      $user[$i].Id = $user[$i].SessionName
      $user[$i].SessionName = ""
    }
  }
  Write-Output $user
}

function better_clear {
  & $PROFILE
}

# * ALIASES
Set-Alias -Name bclear -Value better_clear

# * STARTUP
Invoke-Expression (&starship init powershell)
Set-Location $HOME
Clear-Host
fastfetch.exe --config $HOME\.config\fastfetch.jsonc