<?php

/*
phpGD Bar Graph V1.11
Released: Sept. 09, 2003
Copyright 2003 AdeptiSoft.com. All rights reserved.

Server Requirements: PHP 4.x with PNG support, GD 1.x or greater
License: Freeware (Limited Use)
For commercial use please email us at graphs@adeptisoft.com

Instructions:
1) Copy this file along with the adepti_logo.png to your web site.
   (note: you will need to change the $full_img_url path if you
    copy these to any directory other than your web root directory.)
1) Edit the "Settings" and "Data" section to fit your needs.
2) Insert the graph into your web page: <img src="adepti_graph.php">
3) Visit our web site/forums for more help. www.adeptisoft.com
*/

/*
Change Log
V1.11 (Oct 31, 2003) - Fixed Y-axis numbers when data included a number with decimal.
V1.1 (Oct 28, 2003) - Added numbers above bars. 3 options to choose from.
*/

header("Content-type: image/jpeg");

include("../conect.php");
$sql = mysql_query("SELECT tomador_nome, SUM(valortotal) FROM notas GROUP BY tomador_nome ORDER BY SUM(valortotal) DESC LIMIT 20");
$sql_rows=mysql_num_rows($sql);
if($sql_rows<=4){$largura=400;}else{$largura=200+$sql_rows*50;}
/* Settings */
$graph_width=$largura; //Width of entire graph
$graph_height=500; //Height of entire graph
$graph_padding=20; //Padding for edges of graph
$graph_title="Resumo notas"; //Graph title
$left_title=""; //Y-axis title
$bottom_title="qualquer dia"; //X-axis title
$marks=9; //How many numbers to generate in Y-axis
$text_bars=3; //1=Show numbers above and below bars
              //2=Show numbers only below bars
              //3=Show numbers only above bars

$use_logo=0; //Add logo to the bottom of your graph? 1-Yes 0-No
$full_img_url=$_SERVER["DOCUMENT_ROOT"] . "sepiss/inc/nfe/logo.png"; //You may change this to your own logo


while(list($tomador, $valor)=mysql_fetch_array($sql)){
	$bar_data[$tomador]=$valor;
}
/* Data */
/*
$bar_data=array( //array de teste, nao é inportante.
                  "João" => 52,
                  "Jean" => 45,
                  "Lucas" => 25,
                  "Dani" => 0.25,
                  "Rodrigo" => 58,
                  "Guilherme" => 174,
                  "João" => 52,
                  "Jean" => 45,
                  "Lucas" => 25,
                  "Dani" => 0.25,
                  "Rodrigo" => 58,
                  "Guilherme" => 74,
                  "Maikon" => 58,
                  "Rafa" => 25,
                  "Vini" => 45,
                  "Alguém" => 17
               );
*/
/* Find highest number */
$highest=MyRound(BarDataArraySort($bar_data));

/* Find total of all numbers */
$total=Total($bar_data);

/* Find extra height from key text */
$box_height=BoxHeight($bar_data)*6+15;

function PrintGraph($bar_data) {

   global $graph_width,$graph_height,$graph_padding,$graph_title,$left_title,$bottom_title,$marks,$highest,$box_height,$full_img_url,$use_logo,$text_bars;

   /* Create initial image */
   $graph=ImageCreate($graph_width, $graph_height);

   if($use_logo==1) {

   /* Import logo */
   $logo=ImageCreateFromPNG("$full_img_url");

   /* Get size of imported logo */
   $logo_size=GetImageSize($full_img_url);
   $logo_width=$logo_size[0];
   $logo_height=$logo_size[1];

   /* Copy the logo into the graph */
   $logo_dst_x=$graph_width-$logo_width-$graph_padding; //How far from left to position
   $logo_dst_y=$graph_height-$logo_height-$graph_padding+18; //How far from top to position
   ImageCopy($graph, $logo, $logo_dst_x, $logo_dst_y, 0, 0, $logo_width, $logo_height);

   }

   /* Make our color palette */
   $white = ImageColorAllocate($graph, 255, 255, 255);
   $red = ImageColorAllocate($graph, 180, 0, 0);
   $darkblue = ImageColorAllocate($graph, 72, 107, 143);
   $lightblue = ImageColorAllocate($graph, 102, 153, 204);
   $lightgrey = ImageColorAllocate($graph, 231, 231, 231);
   $mediumgrey = ImageColorAllocate($graph, 210, 210, 210);
   $darkgrey = ImageColorAllocate($graph, 170, 170, 170);
   $black = ImageColorAllocate($graph, 0, 0, 0);
   $color2[] = ImageColorAllocate($graph, 0, 0, 0); //Color of text that appears above bars
   $color2[] = ImageColorAllocate($graph, 255, 255, 255); //Color of text that appears below bars

   /* Fill the border of the whole graph with blue */
   ImageRectangle($graph, 0, 0, $graph_width-1, $graph_height-1, $black);

   /* Create inner box and border */
   $box_left_start=60;
   $box_top_start=40;
   $box_left_end=$graph_width-60;
   $box_top_end=$graph_height-60-$box_height;

   ImageFilledRectangle($graph, $box_left_start, $box_top_start, $box_left_end, $box_top_end, $lightgrey);
   ImageRectangle($graph, $box_left_start, $box_top_start, $box_left_end, $box_top_end, $darkblue);

   /* Draw left box lines */
   LeftLines($graph,$marks,$box_left_start,$box_top_start,$box_left_end,$box_top_end,array($darkgrey,$darkblue));

   /* Print left numbers */
   LeftNumbers($graph,$marks,$highest,$box_left_start,$box_top_start,$box_left_end,$box_top_end,$black);

   /* Draw bottom box lines */
   BottomLines($graph,$bar_data,$box_left_start,$box_top_start,$box_left_end,$box_top_end,$darkblue);

   /* Print bottom values */
   BottomValues($graph,$bar_data,$box_left_start,$box_top_start,$box_left_end,$box_top_end,$black);

   /* Print graph bars */
   GraphBars($graph,$bar_data,$box_left_start,$box_top_start,$box_left_end,$box_top_end,$red,$color2,$text_bars);

   /* Position our titles */
   ImageString($graph, 5, $graph_width/2-strlen($graph_title)*4, $graph_padding, $graph_title, $black);
   ImageStringUp($graph, 3, $graph_padding, $graph_height/2+strlen($left_title)*3, $left_title, $black);
   ImageString($graph, 3, $graph_width/2-strlen($bottom_title)*3, $box_top_end+$graph_padding+$box_height-10, $bottom_title, $black);

   /* Print the copyright */
   /* Note: Please leave our copyright as-is. */
   $copyright="                               ";
   ImageString($graph, 3, $graph_width/2-strlen($copyright)*3.5, $box_top_end+$graph_padding+$box_height+20, $copyright, $mediumgrey);

   /* Output the image */
   ImagePNG($graph);

   /* Cleanup */
   ImageDestroy($graph);

}

function Total($bardata) {

   foreach($bardata as $key => $value) {

      $total+=$value;

   }

   return $total;

}

function MyRound($highest) {

  if(strstr($highest,".")) {

  return ceil($highest);

  } else {

  $length=strlen($highest);
  $piece1=substr($highest,0,1);
  $piece2=substr($highest,1,$length-1);

  if($piece2!=0) {
     $piece1=$piece1+1;
  }

  for($i=0; $i<$length-1; $i++) {
     $zero.="0";
  }

  return $piece1 . "" . $zero;

  }

}

function BoxHeight($bardata) {

   foreach($bardata as $key => $value) {

      if(!is_array($num_array)) { $num_array=array(); }
      //Find the longest key
      array_push($num_array,strlen($key));

   }

   $i=count($bardata)-1;

   sort($num_array);
   return $num_array[$i];
   //return $num_array;

}

function BarDataArraySort($bardata) {

   foreach($bardata as $key => $value) {

      if(!is_array($num_array)) { $num_array=array(); }
      //Find the longest key
      array_push($num_array,$value);

   }

   $i=count($bardata)-1;

   sort($num_array);
   return $num_array[$i];
   //return $num_array;

}

function GraphBars($image,$bardata,$box_left_start,$box_top_start,$box_left_end,$box_top_end,$color,$color2,$num_bars) {

  global $total,$highest;

  $count=count($bardata);

  foreach($bardata as $key => $value) {

     if(!$left) { $left=$box_left_start; } else {
     $left=round((($box_left_end-$box_left_start)/$count),2)+$left;
     }

     $bar_height=(($box_top_end-$box_top_start)*$value)/$highest;

     $mywidth=(.75*($box_left_end-$box_left_start)/$count)/2;

     ImageFilledRectangle($image, $left+((($box_left_end-$box_left_start)/$count)/2)-$mywidth, $box_top_end-$bar_height, $left+((($box_left_end-$box_left_start)/$count)/2)+$mywidth, $box_top_end, $color);

     # Added Oct 28 #
     $start1=$left+((($box_left_end-$box_left_start)/$count)/2)-$mywidth;
     $end1=$left+((($box_left_end-$box_left_start)/$count)/2)+$mywidth;
     $startx=(($end1-$start1)/2)-(strlen($value)*3);
     $start=$start1+$startx;

     if(($bar_height>13 AND $num_bars==1) OR $num_bars==2) {
        $v=1;
        $start2=$box_top_end-$bar_height;
     } else {
        $v=0;
        $start2=$box_top_end-$bar_height-13;
     }

     ImageString($image, 2, $start, $start2, $value, $color2[$v]);

     unset($start1);
     unset($end1);
     unset($startx);
     unset($data);
     # Added Oct 28 #

  }

}

function BottomLines($image,$bardata,$box_left_start,$box_top_start,$box_left_end,$box_top_end,$color) {

  $count=count($bardata);
  for($i=0; $i<=$count; $i++) {

     if(!$left) { $left=$box_left_start; } else {
     $left=round((($box_left_end-$box_left_start)/$count),2)+$left;
     }

     ImageLine($image, $left, $box_top_end-5, $left, $box_top_end+5, $color);

  }

}

function BottomValues($image,$bardata,$box_left_start,$box_top_start,$box_left_end,$box_top_end,$color) {

  $count=count($bardata);

  foreach($bardata as $key => $value) {

     if(!$left) { $left=$box_left_start; } else {
     $left=round((($box_left_end-$box_left_start)/$count),2)+$left;
     }

     ImageStringUp($image, 2, $left+((($box_left_end-$box_left_start)/$count)/2)-5, $box_top_end+5+strlen($key)*6, $key, $color);

  }

}

function LeftLines($image,$marks,$box_left_start,$box_top_start,$box_left_end,$box_top_end,$colors) {

  for($i=0; $i<=$marks; $i++) {

     if(!$top) { $top=$box_top_start; } else {
     $top=round((($box_top_end-$box_top_start)/$marks),2)+$top;
     }

     $style=array($colors[0], $colors[0], $colors[0], $colors[0], IMG_COLOR_TRANSPARENT, IMG_COLOR_TRANSPARENT, IMG_COLOR_TRANSPARENT);
     ImageSetStyle($image, $style);

     ImageLine($image, $box_left_start-5, $top, $box_left_end, $top, IMG_COLOR_STYLED);
     ImageLine($image, $box_left_start-5, $top, $box_left_start+5, $top, $colors[1]);

  }

}

function LeftNumbers($image,$marks,$highest,$box_left_start,$box_top_start,$box_left_end,$box_top_end,$color) {

  for($i=0; $i<=$marks; $i++) {

     if(!$number) { $number=$highest; } else {
     $number=$number-($highest/$marks);
     }
     if(!$top) { $top=$box_top_start; } else {
     $top=round((($box_top_end-$box_top_start)/$marks),2)+$top;
     }

     if(substr($number,0,2)=="0.") { $number=substr($number,1,strlen($number)); }

     ImageString($image, 2, $box_left_start-12-strlen($number)*4, $top-6, $number, $color);

  }

}

printgraph($bar_data);

?>