#!/usr/bin/env pwsh

Write-Host "Analyzing NuGet packages for .NET 8.0 compatibility..." -ForegroundColor Green

# Check each package compatibility with .NET 8.0
$packages = @(
    "CommunityToolkit.Mvvm",
    "Russkyc.AttachedUtilities.FilestreamExtensions", 
    "Russkyc.ModernControls.WPF"
)

foreach ($package in $packages) {
    Write-Host "`nChecking: $package" -ForegroundColor Yellow
    try {
        # Use dotnet to search for package info
        $result = dotnet package search $package --exact-match --format json 2>/dev/null
        if ($result) {
            Write-Host "Package found in registry" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "Could not retrieve package info: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nRecommendations for .NET 8.0 upgrade:" -ForegroundColor Cyan
Write-Host "1. CommunityToolkit.Mvvm: Latest version should support .NET 8.0" 
Write-Host "2. Russkyc packages: Check compatibility or find alternatives"
Write-Host "3. Review all package dependencies after framework upgrade"