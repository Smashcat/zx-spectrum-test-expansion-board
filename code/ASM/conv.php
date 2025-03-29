<?php
// Input binary file
$binaryFile = "sp48.rom";

// Output C header file
$headerFile = "output.h";

// Read the binary file
$data = file_get_contents($binaryFile);
if ($data === false) {
    die("Error: Could not read $binaryFile\n");
}

// Convert binary data to an array of hex values
$hexArray = [];
foreach (str_split($data) as $byte) {
    $hexArray[] = sprintf("0x%02X", ord($byte)); // Format each byte as "0xHH"
}
$len=count($hexArray);

// Format the C header file
$headerContent = "#ifndef OUTPUT_H\n#define OUTPUT_H\n\n#include <stdint.h>\n\n";
$headerContent.="const uint8_t binaryData[0x2f00] = {";
for($n=0;$n<0x2f00;$n++){
    if(($n%32)==0){
        $headerContent.="\n\t/* ".sprintf("0x%04X",$n)." */\t";
    }
    $headerContent.=($n<$len?$hexArray[$n]:"0x00").", ";
}


$headerContent.="};\n\n#endif // OUTPUT_H\n";

// Save the C header file
if (file_put_contents($headerFile, $headerContent) !== false) {
    echo "C header file generated: $headerFile\n";
} else {
    echo "Error: Could not write to $headerFile\n";
}
?>
