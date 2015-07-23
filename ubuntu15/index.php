<?php
include('../variables.php');

if (strlen($ubuntu15_patch) == 0){
	printf("%s.%02s", $ubuntu15_major,$ubuntu15_minor);
 } else {
	printf("%s.%02s.%s", $ubuntu15_major,$ubuntu15_minor,$ubuntu15_patch);
 }

?>
