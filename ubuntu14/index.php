<?php
include('../variables.php');

if (strlen($ubuntu14_patch) == 0){
        printf("%s.%02s", $ubuntu14_major,$ubuntu14_minor);
 } else {
        printf("%s.%02s.%s", $ubuntu14_major,$ubuntu14_minor,$ubuntu14_patch);
 }


 #printf("%s.%s", $ubuntu14_major,$ubuntu14_minor,$ubuntu14_patch);
 #echo "$ubuntu14_major.$ubuntu14_minor.$ubuntu14_patch";

?>
