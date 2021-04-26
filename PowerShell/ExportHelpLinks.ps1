######## Setup
$projectFolder = "C:\Users\mynavblog\projects\AL\MyWorkSpacePath" #Put here path to your apps
$pathToExport = "C:\temp\PageHelpLinks.csv" #Put here path where do you want to store the csv file
######## End of Setup

$pagesArray = @()

Get-ChildItem $projectFolder -Filter *.Page.al –Recurse | Foreach-Object {
    $fileName = $_.FullName
    $content = Get-Content $_.FullName

    $objectNumber = (Get-Content $_.FullName -First 1) -replace "[^0-9]" , ''
    $objectName = (Get-Content $_.FullName -First 1) 
    $objectName = $objectName.Split('"')[1]
    Write-Host $objectNumber $objectName
  
    $pageType = Select-String -Path $fileName -Pattern 'PageType =*' | Select-Object -ExpandProperty Line 
    $pageType = $pageType.Split('=')[1] -replace '[;]',''

    Write-Host "         pageType = "  $pageType -ForegroundColor Green

    $pageCaption = Select-String -Path $fileName -Pattern 'Caption =*' | Select-Object -ExpandProperty Line 
    $pageCaption = $pageCaption.Split('=')[1] -replace '[;]','' -replace "[']",""

    Write-Host "         pageCaption = " $pageCaption -ForegroundColor Red
    
    $pageContextSensitiveHelpPageExists = Select-String -Path $fileName -Pattern 'ContextSensitiveHelpPage =*' -Quiet
    $pageContextSensitiveHelpPage = ""
    $pageContextSensitiveHelpPage = Select-String -Path $fileName -Pattern 'ContextSensitiveHelpPage =*' | Select-Object -ExpandProperty Line -ErrorAction SilentlyContinue
    
    if ($pageContextSensitiveHelpPageExists -eq $true) {
        $pageContextSensitiveHelpPage = $pageContextSensitiveHelpPage.Split('=')[1] -replace '[;]','' -replace "[']","" 
        Write-Host "         pageContextSensitiveHelpPage = " $pageContextSensitiveHelpPage -ForegroundColor Yellow
    }

    $newRow = [pscustomobject]@{objectId = $objectNumber; objectName = $objectName; pageType=$pageType; pageCaption=$pageCaption; pageHelpExists = $pageContextSensitiveHelpPageExists; pageContextSensitiveHelpPage=$pageContextSensitiveHelpPage}
    $pagesArray += $newRow

}
$pagesArray | Export-Csv -Path $pathToExport -NoTypeInformation