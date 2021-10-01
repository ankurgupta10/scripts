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

$WShell = New-Object -com "Wscript.Shell"

$index = 0
while ($true)
{
  
  # Sleep
  Start-Sleep -Seconds 270
  
  # Press ScrollLock / NUMLOCK / CAPSLOCK key
  $WShell.sendkeys("{NUMLOCK}")
  $WShell.sendkeys("{NUMLOCK}")
}
