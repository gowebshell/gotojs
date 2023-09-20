$configFiles = Get-ChildItem "C:\inetpub\temp\appPools" -Recurse -Include *.config


$modules = @(
    @{
        Name = "ScriptModule-2.0"
        Image = "%windir%\Microsoft.NET\Framework\v2.0.50727\mscorst.dll"
        PreCondition = "bitness32"
    },
    @{
        Name = "IsapiCacheModule"
        Image = "%windir%\Microsoft.NET\Framework64\v2.0.50727\mscorst64.dll"
        PreCondition = "bitness64"
    }
)

foreach ($configFile in $configFiles) {

    [xml]$configXml = Get-Content -Path $configFile.FullName


    foreach ($module in $modules) {
        $moduleName = $module.Name
        $imagePath = $module.Image
        $preCondition = $module.PreCondition


        $existingModule = $configXml.SelectSingleNode("//add[@name='$moduleName']")
        if ($existingModule -eq $null) {

            $newModule = $configXml.CreateElement("add")
            $newModule.SetAttribute("name", $moduleName)
            $newModule.SetAttribute("image", $imagePath)  # 将 type 更改为 image
            $newModule.SetAttribute("preCondition", $preCondition)
            $globalModulesElement = $configXml.SelectSingleNode("//globalModules")
            $globalModulesElement.AppendChild($newModule)
             $modulesElement = $configXml.SelectSingleNode("//modules")
             $moduleEntry = $configXml.CreateElement("add")
             $moduleEntry.SetAttribute("name", $moduleName)
             $moduleEntry.SetAttribute("preCondition", $preCondition)
             $modulesElement.AppendChild($moduleEntry)
        }
    }
    $configXml.Save($configFile.FullName)
}
