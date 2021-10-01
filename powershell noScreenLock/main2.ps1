Add-Type -AssemblyName System.Windows.Forms
Add-Type -Name ConsoleUtils -Namespace WPIA -MemberDefinition @'
   [DllImport("Kernel32.dll")]
   public static extern IntPtr GetConsoleWindow();
   [DllImport("user32.dll")]
   public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'@

Add-Type @'
using System;
using System.Diagnostics;
using System.Runtime.InteropServices;

namespace PInvoke.Win32 {

    public static class UserInput {

        [DllImport("user32.dll", SetLastError=false)]
        private static extern bool GetLastInputInfo(ref LASTINPUTINFO plii);

        [StructLayout(LayoutKind.Sequential)]
        private struct LASTINPUTINFO {
            public uint cbSize;
            public int dwTime;
        }

        public static DateTime LastInput {
            get {
                DateTime bootTime = DateTime.UtcNow.AddMilliseconds(-Environment.TickCount);
                DateTime lastInput = bootTime.AddMilliseconds(LastInputTicks);
                return lastInput;
            }
        }

        public static TimeSpan IdleTime {
            get {
                return DateTime.UtcNow.Subtract(LastInput);
            }
        }

        public static int LastInputTicks {
            get {
                LASTINPUTINFO lii = new LASTINPUTINFO();
                lii.cbSize = (uint)Marshal.SizeOf(typeof(LASTINPUTINFO));
                GetLastInputInfo(ref lii);
                return lii.dwTime;
            }
        }
    }
}
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
  Start-Sleep -Seconds 5
  "Idle for " + [PInvoke.Win32.UserInput]::IdleTime | Out-File -FilePath f1.txt -Append
  
  # Press ScrollLock / NUMLOCK / CAPSLOCK key
  #$WShell.sendkeys("{CAPSLOCK}")
  #$WShell.sendkeys("{NUMLOCK}")
  #"Last input " + [PInvoke.Win32.UserInput]::LastInput | Out-File -FilePath f1.txt -Append
  $timestamp = Get-Date -Format "dddd yyyy/MM/dd HH:mm:ss"
  #"S-"+$timestamp  | Out-File -FilePath f.txt -Append
  #$WShell.sendkeys("{NUMLOCK}")
}