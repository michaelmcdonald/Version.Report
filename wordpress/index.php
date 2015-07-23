<?php
include('../variables.php');

 if (strlen($word_patch) == 0){
        printf("%s.%s", $word_major,$word_minor,$word_patch ) ;
 } else {
        printf("%s.%s.%s", $word_major,$word_minor,$word_patch ) ;
 }


 #echo "$word_major.$word_minor.$word_patch";

?>
