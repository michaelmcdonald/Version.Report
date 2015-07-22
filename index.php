<?php
echo "<link rel='stylesheet' type='text/css' href='style.css' />";
include('variables.php');



#echo '<div class="about">';
#echo '<a href="http://updates.version.report/moreinfo">More Info</a>';
#echo '</div>';


$today = date("m.d.y @ H:i");


 echo '<div class="description">A simple page designed to provide you with the latest stable version numbers for various pieces of software. A script will automatically run every four hours to check for any updated versions and will alter the versions displayed if one is detected</div>';


echo '<div class="versions">';
 echo "";
 # Apache version string
 echo '<div>';
 echo '<span class="field-tip apache">';
 printf("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Apache: %s.%s.%s ", $apache_major,$apache_minor,$apache_patch) ;
 echo '<span class="tip-content apache">Updated '.$apache_update.'</span></span>';
 echo '</div>';
 #echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Apache: $apache_major.$apache_minor.$apache_patch\n";


 # bbPress version string
 echo '<div>';
 echo '<span class="field-tip bbpress">';
 printf("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bbPress: %s.%s.%s ", $bbpress_major,$bbpress_minor,$bbpress_patch ) ;
 echo '<span class="tip-content bbpress">Updated '.$bbpress_update.'</span></span>';
 echo '</div>';
 #echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bbPress: $bbpress_major.$bbpress_minor.$bbpress_patch\n ";

 # CentOS 6 version string
 echo '<div>';
 echo '<span class="field-tip centos6">';
 printf("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CentOS&nbsp;6: %s.%s ", $centos6_major,$centos6_minor ) ;
 echo '<span class="tip-content centos6">Updated '.$centos6_update.'</span></span>';
 echo '</div>';
 #echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CentOS&nbsp;6: $centos6_major.$centos6_minor\n ";

 # CentOS 7 version string
 echo '<div>';
 echo '<span class="field-tip centos7">';
 printf("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CentOS&nbsp;7: %s ", $centos7_all ) ;
 #printf("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CentOS&nbsp;7: %s.%s ", $centos7_major,$centos7_minor ) ;
 echo '<span class="tip-content centos7">Updated '.$centos7_update.'</span></span>';
 echo '</div>';
 #echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CentOS&nbsp;7: $centos7_major.$centos7_minor\n ";

 # cPanel version string
 echo '<div>';
 echo '<span class="field-tip cpanel">';
 printf("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cPanel: %s.%s.%s.%s ", $cpanel_major,$cpanel_minor,$cpanel_patch,$cpanel_build ) ;
 echo '<span class="tip-content cpanel">Updated '.$cpanel_update.'</span></span>';
 echo '</div>';
 #echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cPanel: $cpanel_major.$cpanel_minor.$cpanel_patch.$cpanel_build\n ";

 # Drupal 6 version string
 echo '<div>';
 echo '<span class="field-tip drupal6">';
 printf("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Drupal&nbsp6: %s.%s ", $drupal6_major,$drupal6_minor ) ;
 echo '<span class="tip-content drupal6">Updated '.$drupal6_update.'</span></span>';
 echo '</div>';
 #echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Drupal&nbsp6: $drupal6_major.$drupal6_minor\n ";

 # Drupal 7 version string
 echo '<div>';
 echo '<span class="field-tip drupal7">';
 printf("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Drupal&nbsp7: %s.%s ", $drupal7_major,$drupal7_minor ) ;
 echo '<span class="tip-content drupal7">Updated '.$drupal7_update.'</span></span>';
 echo '</div>';
 #echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Drupal&nbsp7: $drupal7_major.$drupal7_minor\n ";

 # Joomla 2 version string
 echo '<div>';
 echo '<span class="field-tip joomla2">';
 printf("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Joomla&nbsp;2: %s.%s.%s ", $joomla2_major,$joomla2_minor,$joomla2_patch ) ;
 echo '<span class="tip-content joomla2">Updated '.$joomla2_update.'</span></span>';
 echo '</div>';
 #echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Joomla&nbsp;2: $joomla2_major.$joomla2_minor.$joomla2_patch\n ";

 # Joomla 3 version string
 echo '<div>';
 echo '<span class="field-tip joomla3">';
 printf("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Joomla&nbsp;3: %s.%s.%s ", $joomla3_major,$joomla3_minor,$joomla3_patch ) ;
 echo '<span class="tip-content joomla3">Updated '.$joomla3_update.'</span></span>';
 echo '</div>';
 #echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Joomla&nbsp;3: $joomla3_major.$joomla3_minor.$joomla3_patch\n ";

 # Magento version string
 echo '<div>';
 echo '<span class="field-tip magento">';
 printf("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Magento: %s.%s.%s.%s ", $magento_major,$magento_minor,$magento_patch,$magento_build ) ;
 echo '<span class="tip-content magento">Updated '.$magento_update.'</span></span>';
 echo '</div>';
 #echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Magento: $magento_major.$magento_minor.$magento_patch.$magento_build\n ";

 # MariaDB version string
 echo '<div>';
 echo '<span class="field-tip mariadb">';
 printf("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MariaDB: %s.%s.%s ", $mariadb_major,$mariadb_minor,$mariadb_patch ) ;
 echo '<span class="tip-content mariadb">Updated '.$mariadb_update.'</span></span>';
 echo '</div>';
 #echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MariaDB: $mariadb_major.$mariadb_minor.$mariadb_patch\n ";

 # MediaWIKI version string
 echo '<div>';
 echo '<span class="field-tip mediawiki">';
 printf("&nbsp;&nbsp;&nbsp;&nbsp;MediaWiki: %s.%s.%s ", $mediawiki_major,$mediawiki_minor,$mediawiki_patch ) ;
 echo '<span class="tip-content mediawiki">Updated '.$mediawiki_update.'</span></span>';
 echo '</div>';
 #echo "&nbsp;&nbsp;&nbsp;&nbsp;MediaWiki: $mediawiki_major.$mediawiki_minor.$mediawiki_patch\n ";

 # MySQL version string
 echo '<div>';
 echo '<span class="field-tip mysql">';
 printf("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MySQL: %s.%s.%s ", $mysql_major,$mysql_minor,$mysql_patch ) ;
 echo '<span class="tip-content mysql">Updated '.$mysql_update.'</span></span>';
 echo '</div>';
 #echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MySQL: $mysql_major.$mysql_minor.$mysql_patch\n ";

 # NGINX version string
 echo '<div>';
 echo '<span class="field-tip nginx">';
 printf("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nginx: %s.%s.%s ", $nginx_major,$nginx_minor,$nginx_patch ) ;
 echo '<span class="tip-content nginx">Updated '.$nginx_update.'</span></span>';
 echo '</div>';
 #echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nginx: $nginx_major.$nginx_minor.$nginx_patch\n";

 # PHP version string
 echo '<div>';
 echo '<span class="field-tip php">';
 printf("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PHP: %s.%s.%s ", $php_major,$php_minor,$php_patch ) ;
 echo '<span class="tip-content php">Updated '.$php_update.'</span></span>';
 echo '</div>';
 #echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PHP: $php_major.$php_minor.$php_patch\n ";

 # phpBB version string
 echo '<div>';
 echo '<span class="field-tip phpbb">';
 printf("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;phpBB: %s.%s.%s ", $phpbb_major,$phpbb_minor,$phpbb_patch ) ;
 echo '<span class="tip-content phpbb">Updated '.$phpbb_update.'</span></span>';
 echo '</div>';
 #echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;phpBB: $phpbb_major.$phpbb_minor.$phpbb_patch\n ";

 # Ubuntu 10 LTS version string
 echo '<div>';
 echo '<span class="field-tip ubuntu10lts">';
 printf("Ubuntu&nbsp;10&nbsp;LTS: %s.%02s.%s ", $ubuntu10LTS_major,$ubuntu10LTS_minor,$ubuntu10LTS_patch ) ;
 echo '<span class="tip-content ubuntu10lts">Updated '.$ubuntu10LTS_update.'</span></span>';
 echo '</div>';
 #echo "Ubuntu&nbsp;10&nbsp;LTS: $ubuntu10LTS_major.$ubuntu10LTS_minor.$ubuntu10LTS_patch\n ";

 # Ubuntu 12 LTS version string
 echo '<div>';
 echo '<span class="field-tip ubuntu12lts">';
 printf("Ubuntu&nbsp;12&nbsp;LTS: %s.%02s.%s ", $ubuntu12LTS_major,$ubuntu12LTS_minor,$ubuntu12LTS_patch ) ;
 echo '<span class="tip-content ubuntu12lts">Updated '.$ubuntu12LTS_update.'</span></span>';
 echo '</div>';
 #echo "Ubuntu&nbsp;12&nbsp;LTS: $ubuntu12LTS_major.$ubuntu12LTS_minor.$ubuntu12LTS_patch\n ";

 # Ubuntu 14 version string
 echo '<div>';
 echo '<span class="field-tip ubuntu14">';
 if (strlen($ubuntu14_patch) == 0){
        printf("&nbsp;&nbsp;&nbsp;&nbsp;Ubuntu&nbsp;14: %s.%02s ", $ubuntu14_major,$ubuntu14_minor);
 } else {
        printf("&nbsp;&nbsp;&nbsp;&nbsp;Ubuntu&nbsp;14: %s.%02s.%s ", $ubuntu14_major,$ubuntu14_minor,$ubuntu14_patch);
 }
 echo '<span class="tip-content ubuntu14">Updated '.$ubuntu14_update.'</span></span>';
 echo '</div>';
 #printf("&nbsp;&nbsp;&nbsp;&nbsp;Ubuntu&nbsp;14: %s.%s ", $ubuntu14_major,$ubuntu14_minor ) ;
 #echo "&nbsp;&nbsp;&nbsp;&nbsp;Ubuntu&nbsp;14: $ubuntu14_major.$ubuntu14_minor\n ";

 # Ubuntu 14 LTS version string
 echo '<div>';
 echo '<span class="field-tip ubuntu14lts">';
 printf("Ubuntu&nbsp;14&nbsp;LTS: %s.%02s.%s ", $ubuntu14LTS_major,$ubuntu14LTS_minor,$ubuntu14LTS_patch ) ;
 echo '<span class="tip-content ubuntu14lts">Updated '.$ubuntu14LTS_update.'</span></span>';
 echo '</div>';
 #echo "Ubuntu&nbsp;14&nbsp;LTS: $ubuntu14LTS_major.$ubuntu14LTS_minor.$ubuntu14LTS_patch\n ";

 # Ubuntu 15 version string
 echo '<div>';
 echo '<span class="field-tip ubuntu15">';
 if (strlen($ubuntu15_patch) == 0){
        printf("&nbsp;&nbsp;&nbsp;&nbsp;Ubuntu&nbsp;15: %s.%02s ", $ubuntu15_major,$ubuntu15_minor);
 } else {
        printf("&nbsp;&nbsp;&nbsp;&nbsp;Ubuntu&nbsp;15: %s.%02s.%s ", $ubuntu15_major,$ubuntu15_minor,$ubuntu15_patch);
 }
 echo '<span class="tip-content ubuntu15">Updated '.$ubuntu15_update.'</span></span>';
 echo '</div>';
 #printf("&nbsp;&nbsp;&nbsp;&nbsp;Ubuntu&nbsp;15: %s.%02s ", $ubuntu15_major,$ubuntu15_minor ) ;

 # vBulletin version string
 echo '<div>';
 echo '<span class="field-tip vbulletin">';
 printf("&nbsp;&nbsp;&nbsp;&nbsp;vBulletin: %s.%s.%s ", $vbulletin_major,$vbulletin_minor,$vbulletin_patch ) ;
 echo '<span class="tip-content vbulletin">Updated '.$vbulletin_update.'</span></span>';
 echo '</div>';
 #echo "&nbsp;&nbsp;&nbsp;&nbsp;vBulletin: $vbulletin_major.$vbulletin_minor.$vbulletin_patch\n ";

 # Wordpress version string
 echo '<div>';
 echo '<span class="field-tip word">';
 if (strlen($word_patch) == 0){
        printf("&nbsp;&nbsp;&nbsp;&nbsp;WordPress: %s.%s ", $word_major,$word_minor,$word_patch ) ;
 } else {
        printf("&nbsp;&nbsp;&nbsp;&nbsp;WordPress: %s.%s.%s ", $word_major,$word_minor,$word_patch ) ;
 }
 echo '<span class="tip-content word">Updated '.$word_update.'</span></span>';
 echo '</div>';

echo '</div>';
?>
