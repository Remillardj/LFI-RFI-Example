<?php
if (isset($_GET['view'])) {
    include($_GET['view']);
} else {
    echo "No file specified.";
}
?>

