<form enctype="multipart/form-data" action="uploadaction.php" method="POST">
    <input type="hidden" name="MAX_FILE_SIZE" value="1000000" />
    Envoyez ce fichier : <input type="file" name="userfile" required />
    <input type="submit" value="Envoyer le fichier" />
</form>