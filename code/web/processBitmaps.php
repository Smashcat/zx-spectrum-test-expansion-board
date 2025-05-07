<?php

header("Content-type: text/plain");

$bitmapIX=0;

function processBitmap($fName){

    global $bitmapIX;

    $data=include $fName;
    $width=$data[0];
    $height=$data[1];
    $attrWidth=$data[2];
    $attrHeight=$data[3];
    $attrData=[];

    // Reduce the Attr data if any for bicolor use
    if($attrWidth>0){
        $dst=0;
        $baseIX=4+($width*$height); // Start of attr data
        for($y=0;$y<$attrHeight;$y+=4){
            $row=($y*$width);
            for($x=0;$x<$attrWidth;$x++){
                $attrData[$dst]=$data[$baseIX+$x+$row];
                ++$dst;
            }
        }
        $attrHeight/=4;
    }
    $im=imagecreatetruecolor($width*8,$height);

    $color=[
        imagecolorallocate($im, 0,0,0),
        imagecolorallocate($im, 0,0,128),
        imagecolorallocate($im, 128,0,0),
        imagecolorallocate($im, 128,0,128),
        imagecolorallocate($im, 0,128,0),
        imagecolorallocate($im, 0,128,128),
        imagecolorallocate($im, 128,128,0),
        imagecolorallocate($im, 128,128,128),

        imagecolorallocate($im, 0,0,0),
        imagecolorallocate($im, 0,0,255),
        imagecolorallocate($im, 255,0,0),
        imagecolorallocate($im, 255,0,255),
        imagecolorallocate($im, 0,255,0),
        imagecolorallocate($im, 0,255,255),
        imagecolorallocate($im, 255,255,0),
        imagecolorallocate($im, 255,255,255)
    ];

    $src=4;
    $inkColor=$color[7];
    $paperColor=$color[0];
    for($y=0;$y<$height;$y++){
        for($x=0;$x<$width;$x++){
            $pX=$x*8;

            if($attrWidth>0){
                $attrByte=$attrData[(($y>>2)*$attrWidth)+$x]&0x7f;
                $brightBit=($attrByte>>3)&0x08;
                $inkColor=$color[($attrByte&0x07)+$brightBit];
                $paperColor=$color[(($attrByte>>3)&0x07)+$brightBit];
            }

            for($bit=7;$bit>-1;$bit--){
                imagesetpixel($im,$pX,$y,($data[$src]&(1<<$bit))?$inkColor:$paperColor);
                ++$pX;
            }

            ++$src;
        }
    }


    imagepng($im, $fName.'.png');
    imagedestroy($im);

    print "// file: $fName\n";
    print "const uint8_t bitmap".$bitmapIX."[".(($width*$height)+4)."] __attribute__((aligned(4))) ={\n\t$width,\t// Bitmap width (bytes)\n\t$height,\t// bitmap height (pixels)\n\t$attrWidth,\t// attr width (bytes)\n\t$attrHeight,\t// attr height (blocks)";
    for($n=4;$n<($width*$height)+4;$n++){
        if((($n-4)%$width)==0){
            print "\n\t";
        }
        printf("0x%02X,",$data[$n]);
    }
    print "\n};\n\n";

    if($attrWidth>0){
        print "const uint8_t attr".$bitmapIX."[".($attrWidth*$attrHeight)."] __attribute__((aligned(4))) ={";
        for($n=0;$n<($attrWidth*$attrHeight);$n++){
            if(($n%$width)==0){
                print "\n\t";
            }
            printf("0x%02X,",$attrData[$n]);
        }
        print "\n};\n\n";
    }

    ++$bitmapIX;
}


$asmFiles = glob("*.asm");
foreach ($asmFiles as $file) {
    processBitmap($file);
}