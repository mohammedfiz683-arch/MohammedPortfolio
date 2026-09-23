Add-Type -AssemblyName System.Drawing

for ($i=1; $i -le 12; $i++) {
    $file = "C:\Users\Mohammed\.gemini\antigravity\scratch\neo-retro-portfolio\char_$i.png"
    if (Test-Path $file) {
        $bytes = [System.IO.File]::ReadAllBytes($file)
        $ms = New-Object System.IO.MemoryStream(,$bytes)
        $img = [System.Drawing.Image]::FromStream($ms)
        $bmp = new-object System.Drawing.Bitmap $img
        
        $width = $bmp.Width
        $height = $bmp.Height
        $left = $width
        $top = $height
        $right = 0
        $bottom = 0

        for ($x=0; $x -lt $width; $x++) {
            for ($y=0; $y -lt $height; $y++) {
                $pixel = $bmp.GetPixel($x, $y)
                if ($pixel.A -gt 0) {
                    if ($x -lt $left) { $left = $x }
                    if ($x -gt $right) { $right = $x }
                    if ($y -lt $top) { $top = $y }
                    if ($y -gt $bottom) { $bottom = $y }
                }
            }
        }
        
        $newWidth = $right - $left + 1
        $newHeight = $bottom - $top + 1
        
        if ($newWidth -gt 0 -and $newHeight -gt 0) {
            $rect = New-Object System.Drawing.Rectangle($left, $top, $newWidth, $newHeight)
            $cropped = $bmp.Clone($rect, $bmp.PixelFormat)
            $cropped.Save($file, [System.Drawing.Imaging.ImageFormat]::Png)
            $cropped.Dispose()
            Write-Host "Cropped char_$i.png to $newWidth x $newHeight"
        }
        
        $bmp.Dispose()
        $img.Dispose()
        $ms.Dispose()
    }
}
