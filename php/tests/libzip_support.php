<?php
try {
  $za = new ZipArchive;
} catch (Exception $e) {
  echo $e;
  exit(1);
}
exit(0);
