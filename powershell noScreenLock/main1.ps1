Add-Type -AssemblyName System.Windows.Forms
Add-Type -Name ConsoleUtils -Namespace WPIA -MemberDefinition @'
   [DllImport("Kernel32.dll")]
   public static extern IntPtr GetConsoleWindow();
   [DllImport("user32.dll")]
   public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'@

# Hide Powershell window
$hWnd = [WPIA.ConsoleUtils]::GetConsoleWindow()
[WPIA.ConsoleUtils]::ShowWindow($hWnd, 0)

Clear-Host

param($sleep = 240) # Seconds
$plusOrMinus = 1 # Mouse position increment or decrement
$WShell = New-Object -com "Wscript.Shell"

$index = 0
while ($true)
{
  
  # Move mouse
  #$p = [System.Windows.Forms.Cursor]::Position
  #$x = $p.X + $plusOrMinus
  #$y = $p.Y + $plusOrMinus
  #[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
  #$plusOrMinus *= -1
  
  # Sleep
  Start-Sleep -Seconds 270
  
  # Press ScrollLock / NUMLOCK / CAPSLOCK key
  #$WShell.sendkeys("{CAPSLOCK}")
  $WShell.sendkeys("{NUMLOCK}")
  $timestamp = Get-Date -Format "dddd yyyy/MM/dd HH:mm:ss"
  "S-"+$timestamp  | Out-File -FilePath f.txt -Append
  $WShell.sendkeys("{NUMLOCK}")
}