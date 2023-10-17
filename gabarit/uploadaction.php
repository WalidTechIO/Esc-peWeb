<?php
$uploaddir = __DIR__ . DIRECTORY_SEPARATOR . 'documents' . DIRECTORY_SEPARATOR;
$uploadfile = $uploaddir . basename($_FILES['userfile']['name']);
$fileOk = end(explode('.', $uploadfile)) != "php" ? true : false;
echo $uploadfile;
echo '<pre>';
if($fileOk && move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadfile)){
    echo "Le fichier a été uploader avec succès !<br>";
} else {
    if($fileOk) echo "Le fichier n'a pas pu être uploader !<br>";
    if(!$fileOk) echo "Pas de fichier php !<br>";
}
echo "Voici plus d'informations sur le téléversement : <br>";
print_r($_FILES);
echo '</pre>';

$mysqli = new mysqli('localhost', 'e22000229sql', 'p3Zu!M?w', 'e22000229_db2');

if($mysqli->connect_errno){
    echo("Erreur : " . $mysqli->connect_error);
}

$filename = basename($_FILES['userfile']['name']);
$requete = "UPDATE T_RESSOURCE_RES SET res_chemin = 'documents/$filename' WHERE res_id = 1";
echo $requete;
$resultat = $mysqli->query($requete);
if(!$resultat){
    echo "Erreur lors de l'exectuin de la requete: $mysqli->error";
}
$requete = "SELECT res_chemin FROM T_RESSOURCE_RES WHERE res_id = 1";
$resultat = $mysqli->query($requete);
while($res = $resultat->fetch_assoc()){
    $chemin = $res['res_chemin'];
    echo "<br>Chemin (relatif) récupéré depuis les ressources en BD via un fetch_assoc<br>$chemin<br>";
    echo "<img src='$chemin' />";
    echo "<a href='$chemin'>Lien vers l'image</a>";
}
$mysqli->close();
?>