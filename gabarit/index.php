<h1>Salut :)</h1>
<?php
$mysqli = new mysqli('localhost', 'e22000229sql', 'p3Zu!M?w', 'e22000229_db2');

if($mysqli->connect_errno){
    echo("Erreur : " . $mysqli->connect_error);
}

$userpassword = "admin23_XEUJ";
$salt = 'fdgjkyrrtejkl5$tyjtyorhpùpo$*urttouiltze1353!';
$password = hash('sha256', $salt.$userpassword);
$requete = "UPDATE T_COMPTE_CPT SET password = '$password' WHERE cpt_mail='admin@example.fr'";
echo $requete;
$resultat = $mysqli->query($requete);
if(!$resultat){
    echo "Erreur lors de l'exectuin de la requete: $mysqli->error";
}
$mysqli->close();
?>
